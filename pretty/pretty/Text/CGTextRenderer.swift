//
//  CGTextRenderer.swift
//  pretty
//
//  Created by Lilly Cham on 23/02/2023.
//

import Cocoa
import CoreGraphics
import CoreText
import Foundation
import SwiftUI

// MARK: - CTTerminalViewController

class CTTerminalViewController: NSViewController {
  // MARK: Lifecycle

  init() {
    self.text = ""
    self.pipe = Pipe()
    self.proc = Process()
    self.input = ""
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  let pipe: Pipe
  var text: String
  var input: String
  let proc: Process
  var monitor: Any?

  override func loadView() {
    view = contentView
    logger.info("loaded term view")
    monitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
      if event.keyCode == 51 {
        self.text = String(self.text.dropLast(1))
        self.input = String(self.input.dropLast(1))
      } else {
        self.text += event.characters!
        self.input += event.characters!
      }
      self.pipe.fileHandleForWriting.write(Data(event.characters!.utf8))
      logger.info("got input: \(event.characters!)")
      self.contentView.refresh()
      return event
    }
  }

  override func viewDidLoad() {
    logger.info("hit viewDidLoad, initialising process")
    consoleHandler()
  }

  override func viewDidDisappear() {
    logger.notice("viewDidDisappear called, cleaning up!")
    proc.terminate()
  }
  
  override func didChangeValue(forKey key: String) {
    contentView.setNeedsDisplay(contentView.frame)
  }

  func consoleHandler() {
    logger.info("setting up process connection to terminal")
    guard let (parent, child) = ttyInit() else { fatalError("Failed to init tty") }
    
    proc.standardError = child
    proc.standardInput = child
    proc.standardOutput = child

    proc.executableURL = URL(fileURLWithPath: "/bin/zsh")

//    pfh.readabilityHandler = { handle in
//      guard let line = String(data: try! handle.readToEnd()!,
//                              encoding: .utf8), !line.isEmpty else { return }
//      #if DEBUG
//      //logger.trace("\(line)")
//      #endif
//      print("<==", self.text)
//    }
//
//    pfh.writeabilityHandler = { handle in
//      try! handle.seekToEnd()
//      guard ((try? handle.write(contentsOf: Data(self.input.utf8))) != nil) else {
//        fatalError("failed to write to pipe")
//      }
//      print("==>", self.input)
//    }

//    try! pipe.fileHandleForWriting.write(contentsOf: Data("echo\n".utf8))
    
    let group = DispatchGroup()
    
    group.enter()
    child.readabilityHandler = { stdOutFileHandle in
      let stdOutPartialData = stdOutFileHandle.availableData
      if stdOutPartialData.isEmpty  {
        logger.notice("EOF on stdin")
        child.readabilityHandler = nil
        group.leave()
      } else {
        self.text.append(contentsOf: String(data: stdOutPartialData, encoding: .utf8)!)
      }
    }
    
    group.enter()
    child.readabilityHandler = { stdErrFileHandle in
      let stdErrPartialData = stdErrFileHandle.availableData
      if stdErrPartialData.isEmpty  {
        logger.notice("EOF on stderr")
        child.readabilityHandler = nil
        group.leave()
      } else {
        self.text.append(contentsOf: String(data: stdErrPartialData, encoding: .utf8)!)
      }
    }
    
    DispatchQueue.main.async {
      guard (try? self.proc.run()) != nil else {
        logger.critical("Process failed to start!")
        return
      }
    }
    
    
    
    logger.info("console setup successfully")
  }

  // MARK: Private

  private lazy var contentView = CTTerminalView()
}

// MARK: - CTTerminalView

class CTTerminalView: NSView {
  // MARK: Lifecycle

  public init( // child: FileHandle,
    // parent: FileHandle,
    font: CTFont = CTFontCreateWithName("SF Mono" as CFString, 16.0, nil),
    bg: NSColor = .init(red: 1.00, green: 1.00, blue: 0.92, alpha: 1.00))
  {
    self.text = ""
    self.font = font
    self.bg = bg

    super.init(frame: NSRect())
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  var text: String?
  var font: CTFont = CTFontCreateWithName("SF Mono" as CFString, 16.0, nil)
  var bg: NSColor = .init(red: 1.00,
                          green: 1.00,
                          blue: 0.92,
                          alpha: 1.00) // Acme BG = #ffffea

  override func draw(_ dirtyRect: NSRect) {
    guard let ctx = NSGraphicsContext.current?.cgContext else { return }

    super.draw(dirtyRect)

    let attrString = NSAttributedString(string: text ?? "",
                                        attributes: [.font: font, .backgroundColor: bg])

    let framesetter = CTFramesetterCreateWithAttributedString(attrString)
    let path = CGMutablePath()
    path.addRect(bounds)
    let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attrString.length), path, nil)

    CTFrameDraw(frame, ctx)
  }
  
  public func refresh() {
    self.setNeedsDisplay(self.frame)
  }
}

// MARK: - PrettyView

struct PrettyView: NSViewRepresentable {
  typealias NSViewType = CTTerminalView

//  var child: FileHandle
//  var parent: FileHandle

  func makeNSView(context: Context) -> CTTerminalView {
    let view = CTTerminalView() // child: child, parent: parent)
    return view
  }

  func updateNSView(_ nsView: CTTerminalView, context: Context) {}
}

// MARK: - PrettyViewController

struct PrettyViewController: NSViewControllerRepresentable {
  typealias NSViewControllerType = CTTerminalViewController

  func makeNSViewController(context: Context) -> CTTerminalViewController {
    let term = CTTerminalViewController()
    return term
  }

  func updateNSViewController(_ nsViewController: CTTerminalViewController, context: Context) {}
}

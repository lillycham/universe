//
//  PrettyApp.swift
//  pretty
//
//  Created by Lilly Cham on 23/02/2023.
//

import SwiftUI
import Foundation
import os.log

let logger = Logger()

/// Setup a tty with user's shell
func initEnv(withChild fh: FileHandle, withParent pfh: FileHandle) -> Process {
  let proc = Foundation.Process()
  guard let str = ProcessInfo.processInfo.environment["SHELL"] else {
    fatalError("Failed to get shell")
  }
  print(str)
  
  proc.executableURL = URL(fileURLWithPath: "/bin/zsh")//URL(fileURLWithPath: str)
  proc.standardError = fh
  proc.standardInput = fh
  proc.standardOutput = fh
  
  pfh.readabilityHandler = { handle in
    guard let line = String(data: handle.availableData,
                            encoding: .utf8), !line.isEmpty else { return }
    logger.info("\(line)")
  }
  return proc
}

@main
struct PrettyApp: App {
  // let (child, parent): (FileHandle, FileHandle) = ttyInit()
//  let (child, parent) = {
//    let (child, parent): (FileHandle, FileHandle) = ttyInit()
//    // let proc = initEnv(withChild: child, withParent: parent)
//    return (child, parent)
//  }()

  
  var body: some Scene {
    WindowGroup {
      ContentView()//parent: parent, child: child)
    }.windowStyle(.hiddenTitleBar)
  }
}

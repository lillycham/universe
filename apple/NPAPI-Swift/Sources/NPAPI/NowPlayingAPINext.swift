//
//  NowPlayingAPINext.swift
//
//
//  Created by Lilly Cham on 11/02/2023.
//

import Foundation
import SwiftUI

private typealias MRMediaRemoteGetNowPlayingInfoFunction =
  @convention(c) (DispatchQueue, @escaping ([String: Any]) -> Void) -> Void

private typealias MRNowPlayingClientGetBundleIdentifierFunction = @convention(c) (AnyObject?) -> String

private func getNPFunc() -> MRMediaRemoteGetNowPlayingInfoFunction? {
  // Load framework
  let bundle = CFBundleCreate(kCFAllocatorDefault,
                              NSURL(fileURLWithPath: "/System/Library/PrivateFrameworks/MediaRemote.framework"))
  
  // Get a Swift function for MRMediaRemoteGetNowPlayingInfo
  guard let MRMediaRemoteGetNowPlayingInfoPointer =
    CFBundleGetFunctionPointerForName(bundle,
                                      "MRMediaRemoteGetNowPlayingInfo"
                                        as CFString)
  else { return nil }
  
  let MRMediaRemoteGetNowPlayingInfo =
    unsafeBitCast(MRMediaRemoteGetNowPlayingInfoPointer,
                  to: MRMediaRemoteGetNowPlayingInfoFunction.self)
  
  return .some(MRMediaRemoteGetNowPlayingInfo)
}

@_optimize(none)
private func getNPData() async -> [String: Any] {
  let cbNPFunc = getNPFunc()!
  return await withUnsafeContinuation { continuation in
    cbNPFunc(DispatchQueue.main) { x in
      continuation.resume(returning: x)
    }
  }
}

// MARK: - NowPlayingInfo

struct NowPlayingInfo {
  // MARK: Lifecycle

  init(NowPlayingAPI: NSDictionary) {
    self.nowPlayingAPI = NowPlayingAPI
  }
  
  init() async {
    self.nowPlayingAPI = await getNPData() as NSDictionary
  }

  // MARK: Internal

  var timestamp: Date? {
    self["kMRMediaRemoteNowPlayingInfoTimestamp"]
  }
  
  var elapsedTime: TimeInterval? {
    self["kMRMediaRemoteNowPlayingInfoElapsedTime"]
  }
  
  var _startTime: Date? {
    self["kMRMediaRemoteNowPlayingInfoStartTime"]
  }
  
  var uniqueID: Int? {
    self["kMRMediaRemoteNowPlayingInfoUniqueIdentifier"]
  }
  
  var title: String? {
    self["kMRMediaRemoteNowPlayingInfoTitle"]
  }
  
  var album: String? {
    self["kMRMediaRemoteNowPlayingInfoAlbum"]
  }
  
  var artist: String? {
    self["kMRMediaRemoteNowPlayingInfoArtist"]
  }
  
  var duration: TimeInterval? {
    self["kMRMediaRemoteNowPlayingInfoDuration"]
  }
  
  var artworkData: Data? {
    self["kMRMediaRemoteNowPlayingInfoArtworkData"]
  }
  
  var startTime: Date? {
    if let _elapsedTime = elapsedTime {
      if let timestamp = timestamp {
        return timestamp.addingTimeInterval(-_elapsedTime)
      } else {
        return Date(timeIntervalSinceNow: -_elapsedTime)
      }
    } else {
      return nil
    }
  }
  
  var artwork: Image? {
    guard let artworkData = artworkData else {
      return nil
    }
    return Image(nsImage: NSImage(data: artworkData)!)
  }
  
  var id: String? {
    if let id = uniqueID {
      return id.description
    } else if let title = title {
      return "NowPlaying-\(title)-\(album ?? "")-\(duration.map(Int.init) ?? 0)"
    } else {
      return nil
    }
  }

  public var track: NPSong? {
    print(self.title!)
    return NPSong(title: title!,
                  album: album!,
                  artist: artist!,
                  track: 0,
                  tracks: 0,
                  elapsed: elapsedTime!,
                  duration: duration!,
                  disc: 0,
                  discs: 0,
                  artwork: artwork)
  }

  // MARK: Private

  private var nowPlayingAPI: NSDictionary

  private subscript<T>(key: String) -> T? {
    return nowPlayingAPI.value(forKey: key) as? T
  }
}

// MARK: - NPSong

public struct NPSong: Equatable {
  // MARK: Lifecycle

  public init(title: String = "",
              album: String = "",
              artist: String = "",
              track: Int = 0,
              tracks: Int = 0,
              elapsed: TimeInterval = 0.0,
              duration: TimeInterval = 0.0,
              disc: Int = 0,
              discs: Int = 0,
              artwork: Image? = nil)
  {
    self.title = title
    self.album = album
    self.artist = artist
    self.track = track
    self.elapsed = elapsed
    self.duration = duration
    self.tracks = tracks
    self.disc = disc
    self.discs = discs
    self.artwork = artwork
  }
  
  // MARK: Public

  public let title: String
  public let album: String
  public let artist: String
  public let track: Int
  public let tracks: Int
  public var elapsed: TimeInterval
  public let duration: TimeInterval
  public let disc: Int
  public let discs: Int
  public var artwork: Image?
}

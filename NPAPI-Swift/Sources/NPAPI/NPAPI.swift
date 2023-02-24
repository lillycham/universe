import AppKit
import Combine
import Dispatch
import Foundation
import NPAPIObjC

private extension Result {
  /// Convert a `Result<S,E>` into an `Optional<S>`, discarding the Error.
  func ok() -> Success? {
    switch self {
    case .failure: return nil
    case .success(let r): return .some(r)
    }
  }
}

// MARK: - RefreshingSong

@available(macOS 10.15, *)
public class RefreshingSong: ObservableObject {
  // MARK: Lifecycle

  public init() {
    Timer.scheduledTimer(withTimeInterval: 1.0,
                         repeats: true) { _ in
      Task {
        let newSong = await self.npInst.getNPSong()
        await MainActor.run {
          if newSong.name == self.song.name {
            // self.song.elapsed += 1
          } else {
            self.song = newSong
          }
          print(self.song.elapsed)
        }
      }
    }
  }

  // MARK: Public

  @Published public var song: Song = .init()

  // MARK: Private

  private let npInst = try! NPAPI()
  private let timer: Timer? = nil
}

// MARK: - Song

public struct Song: Equatable {
  // MARK: Lifecycle

  public init(name: String = "",
              album: String = "",
              artist: String = "",
              track: Int = 0,
              tracks: Int = 0,
              elapsed: Float = 0.0,
              duration: Float = 0.0,
              disc: Int = 0,
              discs: Int = 0,
              artwork: NSImage? = nil)
  {
    self.name     = name
    self.album    = album
    self.artist   = artist
    self.track    = track
    self.elapsed  = elapsed
    self.duration = duration
    self.tracks   = tracks
    self.disc     = disc
    self.discs    = discs
    self.artwork  = artwork
  }

  // MARK: Public

  public let name: String
  public let album: String
  public let artist: String
  public let track: Int
  public let tracks: Int
  public var elapsed: Float
  public let duration: Float
  public let disc: Int
  public let discs: Int
  public var artwork: NSImage?
}

// MARK: - SongError

public enum SongError: Error {
  case FailedFetch
  case NotPlaying
  case BundleError
}

// MARK: - NPAPI

@available(macOS 10.15, *)
public struct NPAPI {
  // MARK: Lifecycle

  public init() throws {
    guard let cbnpf = NPAPI.getNPFunc() else {
      throw SongError.BundleError
    }
    self.cbNPFunc = cbnpf
  }

  // MARK: Public
  
  public func getNPSong() async -> Song {
    let songData = await getNPData()
    let name     = songData[title] as? String ?? ""
    let album    = songData[album] as? String ?? ""
    let artist   = songData[artist] as? String ?? ""
    let track    = songData["kMRMediaRemoteNowPlayingInfoTrackNumber"] as? Int ?? 0
    let tracks   = songData["kMRMediaRemoteNowPlayingInfoTotalTrackCount"] as? Int ?? 0
    let elapsed  = ncnToDouble(songData["kMRMediaRemoteNowPlayingInfoElapsedTime"])
    let duration = ncnToDouble(songData["kMRMediaRemoteNowPlayingInfoDuration"])
    let disc     = songData["kMRMediaRemoteNowPlayingInfoDiscNumber"] as? Int ?? 0
    let discs    = songData["kMRMediaRemoteNowPlayingInfoTotalDiscCount"] as? Int ?? 0

    if let artwork: Data = songData[artwork] as? Data ?? nil {
      return Song(name: name,
                  album: album,
                  artist: artist,
                  track: track,
                  tracks: tracks,
                  elapsed: Float(elapsed),
                  duration: Float(duration),
                  disc: disc,
                  discs: discs,
                  artwork: NSImage(data: artwork))
    }
    
    return Song(name: name,
                album: album,
                artist: artist,
                track: track,
                tracks: tracks,
                elapsed: Float(elapsed),
                duration: Float(duration),
                disc: disc,
                discs: discs)
  }

  public func getAllNP() async -> [String: Any] {
    return await getNPData()
  }

  // MARK: Private

  private typealias MRMediaRemoteGetNowPlayingInfoFunction =
    @convention(c) (DispatchQueue, @escaping ([String: Any]) -> Void) -> Void

  private typealias MRNowPlayingClientGetBundleIdentifierFunction = @convention(c) (AnyObject?) -> String

  private let cbNPFunc: MRMediaRemoteGetNowPlayingInfoFunction

  private let title   = "kMRMediaRemoteNowPlayingInfoTitle"
  private let album   = "kMRMediaRemoteNowPlayingInfoAlbum"
  private let artist  = "kMRMediaRemoteNowPlayingInfoArtist"
  private let artwork = "kMRMediaRemoteNowPlayingInfoArtworkData"

  private static func getNPFunc() -> MRMediaRemoteGetNowPlayingInfoFunction? {
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
    return await withUnsafeContinuation { continuation in
      cbNPFunc(DispatchQueue.main) { x in
        continuation.resume(returning: x)
      }
    }
  }
}

//
//  NowPlaying.m
//  
//
//  Created by Lilly Cham on 27/01/2023.
//

@import Foundation;
@import Dispatch;
@import CoreFoundation;

typedef void (^AcceptsNSDict)(NSDictionary*);
typedef void (^MRMediaRemoteGetNowPlayingInfoFunction)(dispatch_queue_t, AcceptsNSDict);
typedef void (^MRMediaRemoteGetBundleIdentifierFunction)(NSString* id);

MRMediaRemoteGetNowPlayingInfoFunction loadMRBundle() {
  NSURL *path = [NSURL fileURLWithPath:
                 @"/System/Library/PrivateFrameworks/MediaRemote.framework"];
  
  CFBundleRef media_remote = CFBundleCreate(kCFAllocatorDefault,
                                            CFBridgingRetain(path));
  
  void *MediaRemoteGetNowPlayingInfoPtr = CFBundleGetFunctionPointerForName(media_remote,
                                                                            CFBridgingRetain(@"MRMediaRemoteGetNowPlayingInfo"));
  MRMediaRemoteGetNowPlayingInfoFunction MediaRemoteGetNowPlayingInfo = CFBridgingRelease(MediaRemoteGetNowPlayingInfoPtr);
  
  return MediaRemoteGetNowPlayingInfo;
}

void testMR() {
  MRMediaRemoteGetNowPlayingInfoFunction MediaRemoteGetNowPlayingInfo = loadMRBundle();
  
  MediaRemoteGetNowPlayingInfo(dispatch_get_main_queue(), ^(NSDictionary *dict) {
    for(NSString *key in [dict allKeys]) {
      NSLog(@"%@",[dict objectForKey:key]);
    }
  });
}

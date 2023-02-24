//
//  ViewController.h
//  NowPlayingObjC
//
//  Created by Lilly Cham on 09/02/2023.
//

@import Cocoa;
#import "MediaRemote/MRNowPlayingPlayerClient.h"

@interface ViewController : NSViewController
@property (weak) IBOutlet NSTextField *textView;
@property (retain, nonatomic) MRNowPlayingPlayerClient * NPClient;

@end


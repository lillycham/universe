//
//  ViewController.m
//  NowPlayingObjC
//
//  Created by Lilly Cham on 09/02/2023.
//

#import "ViewController.h"
@import AppKit;
#import "AppDelegate.h"
#import "MediaRemote/MRNowPlayingPlayerClient.h"

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // Do any additional setup after loading the view.
  // Get a Now Playing Client
  self.NPClient = [MRNowPlayingPlayerClient new];
  NSDictionary * dict = [_NPClient nowPlayingInfo];
  
  NSLog(@"%@", dict);
  
  [_textView setStringValue:@"Hello world!"];
}


- (void)setRepresentedObject:(id)representedObject {
  [super setRepresentedObject:representedObject];

  // Update the view, if already loaded.
}


@end

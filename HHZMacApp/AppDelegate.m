//
//  AppDelegate.m
//  HHZMacApp
//
//  Created by 陈哲是个好孩子 on 2017/7/12.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import "AppDelegate.h"
#import "MainWindowController.h"
#import "TestVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
//    NSWindow * window = [[NSWindow alloc] initWithContentRect:NSRectFromCGRect(CGRectMake(0, 0, 100, 100)) styleMask:NSWindowStyleMaskBorderless backing:NSBackingStoreRetained defer:YES];
//
//    TestVC * vc = [[TestVC alloc] initWithNibName:@"TestVC" bundle:nil];
//    window.contentViewController = vc;

    // Insert code here to initialize your application
    NSLog(@"111");
    
    [self generateMainWindow];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

#pragma mark 创建主视图
-(void)generateMainWindow
{
//    NSWindow * window = [[NSWindow alloc] initWithContentRect:NSRectFromCGRect(CGRectMake(0, 0, 100, 100)) styleMask:NSWindowStyleMaskBorderless backing:NSBackingStoreRetained defer:YES];
    
    TestVC * vc = [[TestVC alloc] init];
    NSWindow * window = [NSWindow windowWithContentViewController:vc];
    
    MainWindowController * mainWindowVC = [[MainWindowController alloc] initWithWindow:window];
    mainWindowVC.window.title = @"陈哲是个好孩子";
    
   
    
    [mainWindowVC showWindow:self];

    
    [mainWindowVC.window makeKeyWindow];

}


@end

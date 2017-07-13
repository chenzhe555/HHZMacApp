//
//  AppDelegate.m
//  HHZMacApp
//
//  Created by 陈哲是个好孩子 on 2017/7/12.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTemplateVC.h"
#import "HHZNSMainTestVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    //代码创建Window
    [self generateMainWindow];
    
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

#pragma mark 创建主视图
-(void)generateMainWindow
{
    MainTemplateVC * vc = [[MainTemplateVC alloc] init];
//    HHZNSMainTestVC * vc = [[HHZNSMainTestVC alloc] initWithNibName:@"HHZNSMainTestVC" bundle:nil];
    NSWindow * window = [NSWindow windowWithContentViewController:vc];

    self.loginWindow = [[MainWindowController alloc] initWithWindow:window];
    self.loginWindow.window.title = @"陈哲是个好孩子";
    [self.loginWindow showWindow:self];
    //注册窗口拉伸导致Size改变的通知
    [self registerWindowSizeModify:window];
}

-(void)registerWindowSizeModify:(NSWindow *)window
{
    [[NSNotificationCenter defaultCenter] addObserver:window
                                             selector:@selector(windowDidResize:)
                                                 name:NSWindowDidResizeNotification
                                               object:self];
}

- (void)windowDidResize:(NSNotification *)aNotification
{
    NSLog(@"xxxxx");
}

@end

//
//  TestVC.m
//  HHZMacApp
//
//  Created by 陈哲是个好孩子 on 2017/7/12.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import "TestVC.h"

@interface TestVC ()

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    NSButton * btn = [NSButton buttonWithTitle:@"ceshi" target:self action:@selector(test)];
    
    
    btn.frame = CGRectMake(30, 50, 100, 50);
    [self.view addSubview:btn];
}

@end

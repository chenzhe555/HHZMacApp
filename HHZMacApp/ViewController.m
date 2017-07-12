//
//  ViewController.m
//  HHZMacApp
//
//  Created by 陈哲是个好孩子 on 2017/7/12.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import "ViewController.h"
#import "TestVC.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    NSButton * btn = [NSButton buttonWithTitle:@"ceshi" target:self action:@selector(test)];
    
    
    btn.frame = CGRectMake(30, 50, 100, 50);
    [self.view addSubview:btn];
    
}

-(void)test
{
    NSLog(@"xxww");
    TestVC * vc = [[TestVC alloc] initWithNibName:@"TestVC" bundle:nil];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end

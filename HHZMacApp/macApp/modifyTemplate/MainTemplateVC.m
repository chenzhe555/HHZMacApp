//
//  MainTemplateVC.m
//  HHZMacApp
//
//  Created by 陈哲是个好孩子 on 2017/7/13.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import "MainTemplateVC.h"
#import "AppDelegate.h"
#import <AppKit/AppKit.h>
#import <STPrivilegedTask/STPrivilegedTask.h>

@interface MainTemplateVC ()<NSTableViewDelegate,NSTableViewDataSource>
@property (strong) NSSegmentedControl * segmentControl;
@property (strong) NSView * templateMainView;
@property (strong) NSScrollView * templateLeftScrollView;
@property (strong) NSTableView * templateLeftTableView;
@property (strong) NSMutableArray * templateArray;
@property (strong) NSScrollView * templateRightScrollView;
@property (strong) NSTextView * templateRightTextView;
@property (strong) NSText * templateRightTopText;
@property (strong) NSView * templateRightTopTextField;
@property (strong) NSComboBox * box1;
@property (strong) NSComboBox * box2;
@property (strong) NSComboBox * box3;
@property (strong) NSComboBox * box4;
@property (strong) NSFileManager * fileManager;
@property (copy) NSString * selectBtnTitle;
@property (copy) NSString * selectFilePath;
@property (strong) NSButton * saveButton;
@property (strong) NSButton * sublimeButton;
@end

@implementation MainTemplateVC

-(void)loadView
{
    self.view = [[NSView alloc] initWithFrame:NSRectFromCGRect(CGRectMake(0, 0, ([HHZNSViewUtils getNSScreenSize].width - 2*100), ([HHZNSViewUtils getNSScreenSize].height - 2*100)))];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.fileManager = [NSFileManager defaultManager];
    [self createMainView];
}

-(void)createMainView
{
    [self createTopSegmentControl];
    [self createTemplateMainView];
}

-(void)createTopSegmentControl
{
    self.segmentControl = [NSSegmentedControl segmentedControlWithLabels:@[@"修改模版文件",@"待开发..."] trackingMode:NSSegmentSwitchTrackingSelectOne target:self action:@selector(test:)];
    self.segmentControl.frame = NSRectFromCGRect(CGRectMake(-1, self.view.frame.size.height - 24, self.view.frame.size.width, 24));
    self.segmentControl.segmentStyle = NSSegmentStyleAutomatic;
    [self.segmentControl setSegmentCount:2];
    [self.segmentControl setSelectedSegment:0];
    [self.segmentControl setWidth:(self.segmentControl.frame.size.width/2) forSegment:0];
    [self.segmentControl setWidth:(self.segmentControl.frame.size.width/2) forSegment:1];
    
    [self.view addSubview:self.segmentControl];
}

-(void)test:(NSSegmentedControl *)segControl
{
    switch (segControl.selectedSegment) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            NSAlert * alert = [[NSAlert alloc] init];
            alert.messageText = @"有新的想法再加入吧...";
            [alert addButtonWithTitle:@"确定"];
            [alert runModal];
            [self.segmentControl setSelectedSegment:0];
        }
            break;
        default:
            break;
    }
}

-(void)createTemplateMainView
{
    self.templateMainView = [[NSView alloc] initWithFrame:NSRectFromCGRect(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 24))];
//    self.templateMainView.wantsLayer = YES;
//    self.templateMainView.layer.backgroundColor = [[NSColor redColor] CGColor];
    [self.view addSubview:self.templateMainView];
    
    [self createTemplateLeftTableView];
    [self createTemplateRightTextView];
}

-(void)createTemplateLeftTableView
{
    self.templateArray = [NSMutableArray arrayWithArray:@[@"NSObjectObjective-C",
                                                          @"UICollectionReusableViewObjective-C",
                                                          @"UICollectionReusableViewXIBObjective-C",
                                                          @"UICollectionViewCellObjective-C",
                                                          @"UICollectionViewCellXIBObjective-C",
                                                          @"UICollectionViewControllerObjective-C",
                                                          @"UICollectionViewControllerXIBObjective-C",
                                                          @"UITableViewCellObjective-C",
                                                          @"UITableViewCellXIBObjective-C",
                                                          @"UITableViewControllerObjective-C",
                                                          @"UITableViewControllerXIBObjective-C",
                                                          @"UIViewControllerObjective-C",
                                                          @"UIViewControllerXIBObjective-C",
                                                          @"UIViewObjective-C",
                                                          
                                                          @"NSObjectSwift",
                                                          @"UICollectionReusableViewSwift",
                                                          @"UICollectionReusableViewXIBSwift",
                                                          @"UICollectionViewCellSwift",
                                                          @"UICollectionViewCellXIBSwift",
                                                          @"UICollectionViewControllerSwift",
                                                          @"UICollectionViewControllerXIBSwift",
                                                          @"UITableViewCellSwift",
                                                          @"UITableViewCellXIBSwift",
                                                          @"UITableViewControllerSwift",
                                                          @"UITableViewControllerXIBSwift",
                                                          @"UIViewControllerSwift",
                                                          @"UIViewControllerXIBSwift",
                                                          @"UIViewSwift",]];
    
    self.templateLeftScrollView = [[NSScrollView alloc] initWithFrame:CGRectMake(0, 0, 300, self.templateMainView.frame.size.height)];
    self.templateLeftScrollView.hasVerticalRuler = YES;
    [self.templateMainView addSubview:self.templateLeftScrollView];
    
    self.templateLeftTableView = [[NSTableView alloc] init];
    self.templateLeftTableView.frame = self.templateLeftScrollView.bounds;
    self.templateLeftTableView.dataSource = self;
    self.templateLeftTableView.delegate = self;
    [self.templateLeftScrollView addSubview:self.templateLeftTableView];
    self.templateLeftScrollView.contentView.documentView = self.templateLeftTableView;
    
    
    NSTableColumn * column1 = [[NSTableColumn alloc] initWithIdentifier:@"column1"];
    column1.width = self.templateLeftScrollView.frame.size.width;
    column1.title = @"模版文件列表";
    [self.templateLeftTableView addTableColumn:column1];
    
}

#pragma mark tableview
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.templateArray.count;
}

-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return 30;
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSText * text = [[NSText alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    text.string = self.templateArray[row];
    
    NSButton * btn = [NSButton buttonWithTitle:self.templateArray[row] target:self action:@selector(cellBtnClicked:)];
    btn.bezelStyle = NSBezelStyleSmallSquare;
    btn.frame = CGRectMake(0, 0, tableView.frame.size.width, 30);
    
    
    return btn;
}

-(void)cellBtnClicked:(NSButton *)btn
{
    _selectBtnTitle = btn.title;
    NSMutableString * mutaStr = [[NSMutableString alloc] init];
    [mutaStr appendFormat:@"当前显示:        %@ / ___FILEBASENAME___%@",_selectBtnTitle,_box4.stringValue];
    self.templateRightTopText.string = mutaStr;
    
    
    NSString * showStr = [self readFileText];
    if(showStr != nil) self.templateRightTextView.string = showStr;
    else self.templateRightTextView.string = @"文件不存在...(如有疑问，暂时别管)";
    
}


-(void)createTemplateRightTextView
{
    [self createChooseTextField];
    
    
    self.templateRightTopText = [[NSText alloc] initWithFrame:NSRectFromCGRect(CGRectMake(self.templateRightTopTextField.frame.origin.x, self.templateRightTopTextField.frame.origin.y - 10 - 20, self.templateRightTopTextField.frame.size.width, 20))];
    self.templateRightTopText.string = @"请选择需要显示的模版文件...";
    self.templateRightTopText.alignment = NSCenterTextAlignment;
    [self.templateMainView addSubview:self.templateRightTopText];
    
    
    
    self.templateRightScrollView = [[NSScrollView alloc] initWithFrame:CGRectMake(self.templateRightTopText.frame.origin.x, 44, self.templateRightTopText.frame.size.width, self.templateRightTopText.frame.origin.y - 10 - 44)];
    
    self.templateRightTextView = [[NSTextView alloc] init];
    _templateRightTextView.frame = self.templateRightScrollView.bounds;
    self.templateRightScrollView.contentView.documentView = _templateRightTextView;
    self.templateRightTextView.string = @"暂无数据...";
    [self.templateMainView addSubview:self.templateRightScrollView];
    
    [self createSaveButton];
}

-(void)createChooseTextField
{
    self.templateRightTopTextField = [[NSView alloc] initWithFrame:NSRectFromCGRect(CGRectMake(self.templateLeftTableView.frame.origin.x + self.templateLeftTableView.frame.size.width, self.templateMainView.frame.size.height - 10 - 24, self.templateMainView.frame.size.width - self.templateLeftTableView.frame.size.width, 24))];
    
    self.box1 = [[NSComboBox alloc] init];
    _box1.frame = CGRectMake(0, 0, self.templateRightTopTextField.frame.size.width/4.0, self.templateRightTopTextField.frame.size.height);
    [_box1 addItemWithObjectValue:@"Xcode"];
    [_box1 selectItemWithObjectValue:@"Xcode"];
    [self.templateRightTopTextField addSubview:_box1];
    
    self.box2 = [[NSComboBox alloc] init];
    _box2.frame = CGRectMake(_box1.frame.origin.x + _box1.frame.size.width, 0, self.templateRightTopTextField.frame.size.width/4.0, self.templateRightTopTextField.frame.size.height);
    [_box2 addItemWithObjectValue:@"iPhoneOS"];
    [_box2 selectItemWithObjectValue:@"iPhoneOS"];
    [self.templateRightTopTextField addSubview:_box2];
    
    self.box3 = [[NSComboBox alloc] init];
    _box3.frame = CGRectMake(_box2.frame.origin.x + _box2.frame.size.width, 0, self.templateRightTopTextField.frame.size.width/4.0, self.templateRightTopTextField.frame.size.height);
    [_box3 addItemWithObjectValue:@"Cocoa Touch Class"];
    [_box3 selectItemWithObjectValue:@"Cocoa Touch Class"];
    [self.templateRightTopTextField addSubview:_box3];
    
    self.box4 = [[NSComboBox alloc] init];
    _box4.frame = CGRectMake(_box3.frame.origin.x + _box3.frame.size.width, 0, self.templateRightTopTextField.frame.size.width/4.0, self.templateRightTopTextField.frame.size.height);
    [_box4 addItemWithObjectValue:@".m"];
    [_box4 addItemWithObjectValue:@".h"];
    [_box4 addItemWithObjectValue:@".xib"];
    [_box4 addItemWithObjectValue:@".swift"];
    [_box4 selectItemWithObjectValue:@".m"];
    [self.templateRightTopTextField addSubview:_box4];
    
    _box1.selectable = NO;
    _box2.selectable = NO;
    _box3.selectable = NO;
    _box4.selectable = NO;
    
    [self.templateMainView addSubview:self.templateRightTopTextField];
}

-(void)createSaveButton
{
    self.sublimeButton = [NSButton buttonWithTitle:@"用Sublime Text打开(推荐使用)" target:self action:@selector(openFileWithSublime)];
    self.sublimeButton.frame = CGRectMake(self.templateLeftTableView.frame.origin.x + self.templateLeftTableView.frame.size.width + (self.templateRightTopText.frame.size.width/2 - 240)/2, 10, 240, 24);
    [self.templateMainView addSubview:self.sublimeButton];
    
    self.saveButton = [NSButton buttonWithTitle:@"保存修改" target:self action:@selector(writeStringToFileText)];
    self.saveButton.frame = CGRectMake(self.templateLeftTableView.frame.origin.x + self.templateLeftTableView.frame.size.width + (self.templateRightTopText.frame.size.width*3/2 - 100)/2, 10, 100, 24);
    [self.templateMainView addSubview:self.saveButton];
}

-(NSString *)readFileText
{
    @autoreleasepool {
        NSMutableString * mutaStr = [[NSMutableString alloc] init];
        NSString * str1 = [_box1.stringValue stringByReplacingOccurrencesOfString:@" " withString:@"\ "];
        NSString * str2 = [_box2.stringValue stringByReplacingOccurrencesOfString:@" " withString:@"\ "];
        NSString * str3 = [_box3.stringValue stringByReplacingOccurrencesOfString:@" " withString:@"\ "];
        NSString * str4 = [_box4.stringValue stringByReplacingOccurrencesOfString:@" " withString:@"\ "];
        [mutaStr appendFormat:@"/Applications/%@.app/Contents/Developer/Platforms/%@.platform/Developer/Library/Xcode/Templates/File\ Templates/Source/%@.xctemplate/%@/___FILEBASENAME___%@",str1,str2,str3,_selectBtnTitle,str4];
        NSError * fileError = nil;
        _selectFilePath = mutaStr;
        NSString * str = [NSString stringWithContentsOfFile:_selectFilePath encoding:NSUTF8StringEncoding error:&fileError];
        
        if(fileError == nil && str.length > 0)
        {
            return str;
        }
        else
        {
            return nil;
        }
    }
}

-(void)writeStringToFileText
{
    NSAlert * alert = [[NSAlert alloc] init];
    alert.messageText = @"由于权限问题，不能直接写入。\n可通过AuthorizationExecuteWithPrivileges脚本写入，暂不深入了，毕竟刚做一天半的OSX开发，蛋疼地方有点多...";
    [alert addButtonWithTitle:@"确定"];
    [alert runModal];
}

-(void)openFileWithSublime
{
    if([[NSFileManager defaultManager] fileExistsAtPath:_selectFilePath])
    {
        NSTask * task = [NSTask launchedTaskWithLaunchPath:@"/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl" arguments:@[_selectFilePath]];
        [task launch];
    }
    else
    {
        NSAlert * alert = [[NSAlert alloc] init];
        alert.messageText = @"文件不存在/未安装Sublime Text!\n(或者你给Sublime改名了...别坑我!)";
        [alert addButtonWithTitle:@"确定"];
        [alert runModal];
    }
}

@end

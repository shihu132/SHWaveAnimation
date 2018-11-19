//
//  ViewController.m
//  SHWaveAnimation
//
//  Created by joyshow on 2018/11/19.
//  Copyright © 2018年 石虎. All rights reserved.
//

#import "SHViewController.h"
#import "SHWaveView.h"

@interface SHViewController ()

@end

@implementation SHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"邂逅波浪图";
    
    [self.view addSubview:[[SHWaveView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)]];
}


@end

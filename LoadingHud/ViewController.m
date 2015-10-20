//
//  ViewController.m
//  LoadingHud
//
//  Created by JunpingWon on 15/10/20.
//  Copyright (c) 2015年 JunpingWon. All rights reserved.
//

#import "ViewController.h"
#import "LoadingHudView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
//    UIVisualEffectView *bgView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
//    bgView.frame = CGRectMake(100, 100, 100, 100);
//    bgView.layer.cornerRadius = 10;
//    bgView.clipsToBounds = YES;
//    [self.view addSubview:bgView];
    LoadingHudView *loadingHudView = [[LoadingHudView alloc]initWithFrame:CGRectMake(120, 120, 120, 120)];
    [self.view addSubview:loadingHudView];
    [loadingHudView showHud];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

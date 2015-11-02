//
//  ViewController.m
//  Spread
//
//  Created by City--Online on 15/10/30.
//  Copyright © 2015年 City--Online. All rights reserved.
//

#import "ViewController.h"

#import "SpreadScrollView.h"


@interface ViewController ()<UIScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SpreadScrollView *spreadView=[[SpreadScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width) withTitleArray:@[@"1",@"2",@"3",@"2",@"3",@"2",@"3",@"2",@"3"]];
    spreadView.scrollViewFrameChangedBlock=^(CGRect frame)
    {
        NSLog(@"%@",NSStringFromCGRect(frame));
    };
    [self.view addSubview:spreadView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

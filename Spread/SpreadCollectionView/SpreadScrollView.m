//
//  SpreadScrollView.m
//  Spread
//
//  Created by City--Online on 15/11/2.
//  Copyright © 2015年 City--Online. All rights reserved.
//

#import "SpreadScrollView.h"
#import "MainView.h"

@interface SpreadScrollView ()<UIScrollViewDelegate>

@property (nonatomic,strong) NSMutableArray *ViewArr;

@property (nonatomic,strong) NSArray *titleArray;

@end
@implementation SpreadScrollView

- (instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray *)titleArray
{
    _titleArray=titleArray;
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame=frame;
        _ViewArr=[[NSMutableArray alloc]init];
        
        self.contentSize=CGSizeMake(frame.size.width*2,frame.size.height);
        //画布里墙角的距离 类似CSS的盒子模型  contentSize、contentInset共同组成整块墙
        //    _scrollView.contentInset=UIEdgeInsetsMake(10, 10, 10, 10);
        //设置代理
        self.delegate=self;
        //指定控件是否只能在一个方向上滚动
        self.directionalLockEnabled=YES;
        //控制控件遇到边框是否反弹
        self.bounces=NO;
        //控制垂直方向遇到边框是否反弹
        self.alwaysBounceVertical=NO;
        //控制水平方向遇到边框是否反弹
        self.alwaysBounceHorizontal=NO;
        //控制控件是否整页翻动
        self.pagingEnabled=YES;
        //控制控件是否能滚动
        self.scrollEnabled=YES;
        //控制是否显示水平方向的滚动条
        self.showsHorizontalScrollIndicator=NO;
        //控制是否显示垂直方向的滚动条
        self.showsVerticalScrollIndicator=NO;
        NSMutableArray *mainArray;
        int i=0;
        for (NSString *title in _titleArray) {
            
            if (i%8==0) {
                
                mainArray=[[NSMutableArray alloc]init];
            }
            [mainArray addObject:title];
            
            if ((i%8==7) || _titleArray.count-1 == i) {
                MainView *mainView=[[MainView alloc]initWithFrame:CGRectMake(frame.size.width*((int)i/8), 0, frame.size.width, frame.size.height) withTitleArray:mainArray];
                mainView.mainFrameChangedBlock=^(CGRect frame)
                {
                    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width, frame.size.height);
                    self.contentSize=CGSizeMake(self.bounds.size.width*2, frame.size.height);
                    _scrollViewFrameChangedBlock(frame);
                };
                
                [self addSubview:mainView];
                [_ViewArr addObject:mainView];
            }
            
            i++;
        }
        
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    for (MainView *mainView in _ViewArr) {
        [mainView hideDetailView];
    }
    
}

@end

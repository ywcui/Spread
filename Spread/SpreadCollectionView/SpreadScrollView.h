//
//  SpreadScrollView.h
//  Spread
//
//  Created by City--Online on 15/11/2.
//  Copyright © 2015年 City--Online. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ScrollViewFrameChangedBlock) (CGRect frame);

@interface SpreadScrollView : UIScrollView

@property (nonatomic,copy) ScrollViewFrameChangedBlock scrollViewFrameChangedBlock;

- (instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray *)titleArray;

@end

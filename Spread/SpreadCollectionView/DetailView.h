//
//  DeatilView.h
//  Spread
//
//  Created by City--Online on 15/10/30.
//  Copyright © 2015年 City--Online. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DetailIndexPathBlock) (NSIndexPath *indexPath);

@interface DetailView : UIView

@property (nonatomic,copy) DetailIndexPathBlock detailIndexPathBlock;

- (instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray *)titleArray;

@end

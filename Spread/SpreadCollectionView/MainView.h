//
//  MainView.h
//  Spread
//
//  Created by City--Online on 15/10/30.
//  Copyright © 2015年 City--Online. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MainFrameChangedBlock) (CGRect frame);

@interface MainView : UIView


@property (nonatomic,copy) MainFrameChangedBlock mainFrameChangedBlock;

- (instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray *)mainArray;

-(void) hideDetailView;
@end

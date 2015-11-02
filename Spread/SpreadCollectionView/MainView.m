//
//  MainView.m
//  Spread
//
//  Created by City--Online on 15/10/30.
//  Copyright © 2015年 City--Online. All rights reserved.
//

#import "MainView.h"
#import "DetailView.h"

static const int columns=4;

@interface MainView ()<UICollectionViewDataSource,UIBarPositioningDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSArray *mainArray;

@property (nonatomic,strong) NSMutableArray *detailArray;

@property (nonatomic,strong) NSIndexPath *selectIndexPath;

@property (nonatomic,strong) DetailView *detailView;

@property (nonatomic,assign) bool    *IsSpread;

@end

@implementation MainView

- (instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray *)mainArray
{
    _mainArray=mainArray;
    _selectIndexPath=nil;
    return [self initWithFrame:frame];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout  *collectionViewFlowLayout=[[UICollectionViewFlowLayout alloc]init];
        collectionViewFlowLayout.minimumInteritemSpacing=1.0;
        collectionViewFlowLayout.minimumLineSpacing=0.0;
        collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0.0, 0.0, 0, 0.0);
        float columnWidth=(self.bounds.size.width-columns+1)/columns;
        float columnHeight=(self.bounds.size.height-columns+1)/columns;
        collectionViewFlowLayout.itemSize=CGSizeMake(columnWidth, columnHeight);
        collectionViewFlowLayout.estimatedItemSize=CGSizeMake(columnWidth, columnHeight);
        collectionViewFlowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
        collectionViewFlowLayout.headerReferenceSize=CGSizeMake(0, 0);
        collectionViewFlowLayout.footerReferenceSize=CGSizeMake(0, 0);
        _collectionView=[[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:collectionViewFlowLayout];
        _collectionView.backgroundColor=[UIColor whiteColor];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.allowsSelection=YES;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
        [self addSubview:_collectionView];
    }
    return self;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return columns;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor=indexPath.section%2? [UIColor redColor]:[UIColor yellowColor];
    if (indexPath.section*columns+indexPath.row>_mainArray.count-1) {
        cell.backgroundColor=[UIColor clearColor];
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (_selectIndexPath!=indexPath&&_selectIndexPath!=nil) {
        _IsSpread=YES;
    }
    else
    {
        _IsSpread=!_IsSpread;
    }
    
    if (!_IsSpread) {
        //改变主CollectionView视图Frame和子CollectionView的Frame
        self.frame=CGRectMake(self.frame.origin.x, 0, self.bounds.size.width, self.bounds.size.width);
    }
    else
    {
        self.frame = CGRectMake(self.frame.origin.x, 0, self.bounds.size.width, self.bounds.size.width+((int)(_detailArray.count+3)/4)*30.0);
    }
    
    _collectionView.frame = self.bounds;
    _mainFrameChangedBlock(self.bounds);
    _selectIndexPath=indexPath;
    //改变数据源
     _detailArray=[(@[@"AAA",@"BBB",@"CCC",@"DDD",@"EEE"]) mutableCopy];
    [_collectionView reloadData];
    
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return (_mainArray.count+columns-1)/columns;
}
//针对每个分区的页眉和页脚, 返回对应的视图对象, 重用的
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
    
    //将第二个视图控制器添加到区尾上
    if (_detailView!=nil) {
        [_detailView removeFromSuperview];
        _detailView=nil;
    }
    _detailView =[[DetailView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, ((int)(_detailArray.count+3)/4)*30.0) withTitleArray:_detailArray];
    _detailView.detailIndexPathBlock=^(NSIndexPath *indexPath)
    {
        
        NSLog(@"%@",indexPath);
    };
    [footerView addSubview:_detailView];
    
    return footerView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section==_selectIndexPath.section&&_IsSpread) {
        return CGSizeMake(self.bounds.size.width, ((int)(_detailArray.count+3)/4)*30.0) ;
    }
    else
    {
        return CGSizeZero;
    }
}
-(void) hideDetailView
{
    self.frame=CGRectMake(self.frame.origin.x, 0, self.bounds.size.width, self.bounds.size.width);
    _selectIndexPath=nil;
    _collectionView.frame = self.bounds;
    _IsSpread=NO;
    //改变数据源
    _detailArray=nil;
    [_collectionView reloadData];

}


@end

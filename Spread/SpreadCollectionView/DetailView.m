//
//  DeatilView.m
//  Spread
//
//  Created by City--Online on 15/10/30.
//  Copyright © 2015年 City--Online. All rights reserved.
//

#import "DetailView.h"

static const int columns=4;
static const float rowHeight=30.0;

@interface DetailView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSArray *titleArray;
@end

@implementation DetailView

- (instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray *)titleArray
{
    _titleArray=titleArray;
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        UICollectionViewFlowLayout  *collectionViewFlowLayout=[[UICollectionViewFlowLayout alloc]init];
        collectionViewFlowLayout.minimumInteritemSpacing=0.0;
        collectionViewFlowLayout.minimumLineSpacing=0.0;
        collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0.0, 0.0, 0, 0.0);
       
        
        float columuWidth=self.bounds.size.width/columns;
        collectionViewFlowLayout.itemSize=CGSizeMake(columuWidth, rowHeight);
        collectionViewFlowLayout.estimatedItemSize=CGSizeMake(columuWidth, rowHeight);
       
        collectionViewFlowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
        
        collectionViewFlowLayout.headerReferenceSize=CGSizeMake(0, 0);
        collectionViewFlowLayout.footerReferenceSize=CGSizeMake(0, 0);
        
        _collectionView=[[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:collectionViewFlowLayout];
        _collectionView.backgroundColor=[UIColor whiteColor];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.allowsSelection=YES;
//        _collectionView.allowsMultipleSelection=YES;

        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self addSubview:_collectionView];
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%256/ 255.0  green:arc4random()%256 / 255.0 blue:arc4random()% 256 / 255.0  alpha:1];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.detailIndexPathBlock != nil) {
        self.detailIndexPathBlock(indexPath);
    }
}

@end

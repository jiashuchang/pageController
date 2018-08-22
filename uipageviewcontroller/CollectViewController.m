//
//  CollectViewController.m
//  uipageviewcontroller
//
//  Created by TianLi on 2018/7/6.
//  Copyright © 2018年 TianLi. All rights reserved.
//

#import "CollectViewController.h"
#import "ceceCollectionViewCell.h"

#define JyColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

static NSString *const cellId = @"ModuleViewddcellId";



@interface CollectViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    UICollectionView *_collectionView;
    NSArray *_titleArray;
    CGFloat _cellWidth;
    NSIndexPath *_selectIndexPath;
}
@end

@implementation CollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   _selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    _titleArray = [NSArray arrayWithObjects:@"品智社区", @"月子中心",@"产后康复",@"女性医院",nil];
    _cellWidth = self.view.frame.size.width/4;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    _collectionView.backgroundColor = JyColor(255,143,143,1);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[ceceCollectionViewCell class] forCellWithReuseIdentifier:cellId];
    
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
//    CGFloat frameX = (self.view.frame.size.width - (_cellWidth * _titleArray.count))/2;
    
    _collectionView.frame = CGRectMake(0, 64, self.view.frame.size.width, 30);
    
    
}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _titleArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ceceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.labelStr = _titleArray[indexPath.row];
    if (indexPath == _selectIndexPath) {
        cell.isSelected = YES;
    }else{
        cell.isSelected = NO;
    }
    return cell;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((self.view.frame.size.width)/4, 30);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    ceceCollectionViewCell *cell = (ceceCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (_selectIndexPath != indexPath) {
//        cell.isSelected = YES;
        
        NSArray *array = [NSArray arrayWithObjects:_selectIndexPath,indexPath, nil];
        _selectIndexPath = indexPath;
        [collectionView reloadItemsAtIndexPaths:array];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  ViewController.m
//  uipageviewcontroller
//
//  Created by TianLi on 2018/7/3.
//  Copyright © 2018年 TianLi. All rights reserved.

//  注意：此页面是pageviewcontroller和collectviewcontroller的融合

#import "ViewController.h"
#import "TLViewController.h"
#import "HSViewController.h"
#import "JYViewController.h"
#import "JSCViewController.h"
#import "ceceCollectionViewCell.h"

#define JyColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

static NSString *const cellId = @"ModuleViewddcellId";

@interface ViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    
    UICollectionView *_collectionView;
    NSArray *_titleArray;
    CGFloat _cellWidth;
    NSIndexPath *_selectIndexPath;
}
@property (nonatomic, strong)NSArray *childViewControllersArray;
@property (nonatomic, strong)UIPageViewController *pageViewController;
@property (nonatomic, assign)NSInteger currentIndex;

@end

@implementation ViewController

- (NSArray<UIViewController *> *)childViewControllersArray {
    if (!_childViewControllersArray) {
        TLViewController *vc1 = [[TLViewController alloc] init];
        HSViewController *vc2 = [[HSViewController alloc] init];
        JYViewController *vc3 = [[JYViewController alloc] init];
        JSCViewController *vc4 = [[JSCViewController alloc] init];
        _childViewControllersArray = @[vc1, vc2, vc3,vc4];
        
    }
    return _childViewControllersArray;
}
- (UIPageViewController *)pageViewController {
    
    if (!_pageViewController) {
//         NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:10] forKey:UIPageViewControllerOptionInterPageSpacingKey];
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
        _pageViewController.view.frame = CGRectMake(0, 64+30, self.view.frame.size.width, self.view.frame.size.height - 64-30);
        _pageViewController.dataSource = self;
        _pageViewController.delegate = self;
        
        [self addChildViewController:_pageViewController];
        [self.view addSubview:_pageViewController.view];
        
//        [_pageViewController setViewControllers:@[self.childViewControllersArray[_currentIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
    return _pageViewController;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpSegmentView];
    
    //切换控制器
    [self.pageViewController setViewControllers:@[self.childViewControllersArray[_currentIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
//    [self setupPageViewController];
}
- (void)setUpSegmentView{
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

#pragma mark - UIPageViewControllerDataSource
//当前界面的上一个界面，该代理在手势操作时便触发（轻微滑动），并且应该是有某种缓存机制，同一界面的第二次手势操作不触发
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSInteger beforeIndex = _currentIndex - 1;
    //返回nil时禁止继续滑动
    if (beforeIndex < 0) return nil;
    
    return self.childViewControllersArray[beforeIndex];
}

//当前界面的下一个界面，机理同上
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSInteger afterIndex = _currentIndex + 1;
    if (afterIndex > self.childViewControllersArray.count - 1) return nil;
    
    return self.childViewControllersArray[afterIndex];
}

//跳转动画开始时触发，利用该方法可以定位将要跳转的界面
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
    UIViewController *nextVC = [pendingViewControllers firstObject];

    NSInteger index = [self.childViewControllersArray indexOfObject:nextVC];

    _currentIndex = index;
    
}

// Sent when a gesture-initiated transition ends. The 'finished' parameter indicates whether the animation finished, while the 'completed' parameter indicates whether the transition completed or bailed out (if the user let go early).
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    if (completed) {
        NSIndexPath *newindexPath = [NSIndexPath indexPathForRow:_currentIndex inSection:0];
        
        NSArray *array = [NSArray arrayWithObjects:_selectIndexPath,newindexPath, nil];
        _selectIndexPath = newindexPath;
        [_collectionView reloadItemsAtIndexPaths:array];
        
        
    }else{
        
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    //    [self.segmentView reloadData];
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
        
        
        [_pageViewController setViewControllers:@[self.childViewControllersArray[indexPath.row]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        _currentIndex = indexPath.row;
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

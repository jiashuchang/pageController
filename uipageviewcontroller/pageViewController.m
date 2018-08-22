//
//  pageViewController.m
//  uipageviewcontroller
//
//  Created by TianLi on 2018/7/6.
//  Copyright © 2018年 TianLi. All rights reserved.
//

#import "pageViewController.h"
#import "TLViewController.h"
#import "HSViewController.h"
#import "JYViewController.h"


@interface pageViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
@property (nonatomic, strong)NSArray *childViewControllersArray;
@property (nonatomic, strong)UIPageViewController *pageViewController;
@property (nonatomic, assign)NSInteger currentIndex;

@end




@implementation pageViewController

- (NSArray<UIViewController *> *)childViewControllersArray {
    if (!_childViewControllersArray) {
        TLViewController *vc1 = [[TLViewController alloc] init];
        HSViewController *vc2 = [[HSViewController alloc] init];
        JYViewController *vc3 = [[JYViewController alloc] init];
        _childViewControllersArray = @[vc1, vc2, vc3];
        
    }
    return _childViewControllersArray;
}
- (UIPageViewController *)pageViewController {
    
    if (!_pageViewController) {
        //         NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:10] forKey:UIPageViewControllerOptionInterPageSpacingKey];
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
        _pageViewController.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
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
        
        //        self.segmentView.selectedIndex = ld_currentIndex ;
    }else{
        
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    //    [self.segmentView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


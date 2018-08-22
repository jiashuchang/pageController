//
//  JYViewController.m
//  uipageviewcontroller
//
//  Created by TianLi on 2018/7/3.
//  Copyright © 2018年 TianLi. All rights reserved.
//

#import "JYViewController.h"

@interface JYViewController ()

@end

@implementation JYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor blueColor];
    UILabel *label = [[UILabel alloc] init];
    [self.view addSubview:label];
    label.textColor = [UIColor blackColor];
    label.text = @"第三页";
    label.frame = CGRectMake(10, 100, 100, 30);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

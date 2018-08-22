//
//  ceceCollectionViewCell.m
//  uipageviewcontroller
//
//  Created by TianLi on 2018/7/6.
//  Copyright © 2018年 TianLi. All rights reserved.
//

#import "ceceCollectionViewCell.h"
#import "PureLayout.h"

#define JyColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

@interface ceceCollectionViewCell(){
    UILabel *_tlLabel;
    UIView *_lineView;
}
@end

@implementation ceceCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}
- (void)initView{
    _tlLabel = [[UILabel alloc] init];
    _tlLabel.textColor = JyColor(255, 255, 255, 0.6);
    _tlLabel.textAlignment = NSTextAlignmentCenter;
    _tlLabel.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:_tlLabel];
    
    _lineView = [[UIView alloc] init];
    _lineView.hidden = YES;
    _lineView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_lineView];;
    
    
    _tlLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_tlLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_tlLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_tlLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_tlLabel autoSetDimension:ALDimensionHeight toSize:15];
    
    _lineView.translatesAutoresizingMaskIntoConstraints = NO;
    [_lineView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_tlLabel withOffset:7];
    [_lineView autoSetDimension:ALDimensionHeight toSize:2];
    [_lineView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_lineView autoSetDimension:ALDimensionWidth toSize:25];
    
}
- (void)setLabelStr:(NSString *)labelStr{
    _tlLabel.text = labelStr;
}
- (void)setIsSelected:(BOOL)isSelected{
     _isSelected = isSelected;
    if (isSelected) {
        _tlLabel.textColor = JyColor(255, 255, 255, 1);
        _lineView.hidden = NO;
    }else{
        _tlLabel.textColor = JyColor(255, 255, 255, 0.6);
        _lineView.hidden = YES;
    }
    
}
@end

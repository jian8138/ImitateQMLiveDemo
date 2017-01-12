//
//  RcommendHeaderView.h
//  TRProject
//
//  Created by Jian on 2016/11/28.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RcommendHeaderView : UICollectionReusableView

@property (nonatomic) UILabel* nameLB;

@property (nonatomic) UIButton* contentBtn;

@property (nonatomic,copy) void(^ClickBlock)(RcommendHeaderView* hv);

@end

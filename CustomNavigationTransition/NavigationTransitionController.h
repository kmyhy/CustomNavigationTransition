//
//  NavigationTransitionController.h
//  CustomNavigationTransition
//
//  Created by qq on 2018/2/6.
//  Copyright © 2018年 yhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationTransitionController : NSObject<UIViewControllerAnimatedTransitioning>

@property(assign,nonatomic) BOOL reverse;// 表示动画方向，push 为 NO，pop 为 YES
@end

//
//  ViewController.h
//  CustomNavigationTransition
//
//  Created by qq on 2018/2/6.
//  Copyright © 2018年 yhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationTransitionController.h"

@interface ViewController : UIViewController<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>
@property(strong,nonatomic)NavigationTransitionController* navTransController; 

@end


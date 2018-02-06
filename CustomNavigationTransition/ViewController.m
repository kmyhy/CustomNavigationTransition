//
//  ViewController.m
//  CustomNavigationTransition
//
//  Created by qq on 2018/2/6.
//  Copyright © 2018年 yhy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _navTransController = [NavigationTransitionController new];
    self.navigationController.delegate = self;
    
}

// MARK: - UINavigationControllerDelegate
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    _navTransController.reverse = operation == UINavigationControllerOperationPop;
    return _navTransController;
}



@end

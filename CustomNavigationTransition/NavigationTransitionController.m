//
//  NavigationTransitionController.m
//  CustomNavigationTransition
//
//  Created by qq on 2018/2/6.
//  Copyright © 2018年 yhy. All rights reserved.
//

#import "NavigationTransitionController.h"

@implementation NavigationTransitionController

-(CGFloat)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.75;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    // 注意，push 和 pop 时，fromVC 和 toVC 是互换的
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    // snapshot 为 nil 时会 crash
    if(fromVC && toVC){
        UIView* containerView = transitionContext.containerView;
        UIView* fromView = fromVC.view;
        UIView* toView = toVC.view;
        int direction = _reverse ? -1 : 1;// -1 为 pop，1 为 push
        CGFloat m34 = -0.002; // m34 越小，透视效果越好，你可以调整这个值
        
        // to 视图和 from 视图互相垂直，拼成90º角。在 push 时，to 视图以左侧边为轴开始运动，from 视图以右侧边为轴开始运动。当 pop 时，to 视图以右侧边为轴开始运动，from 视图以左侧边为轴开始运动。
        toView.layer.anchorPoint = CGPointMake(direction == 1 ? 0 : 1, 0.5);
        fromView.layer.anchorPoint = CGPointMake(direction == 1 ? 1 : 0, 0.5);
        
        // fromView 动画结束时的状态：+/-90º 垂直于屏幕
        CATransform3D viewFromTransform = CATransform3DMakeRotation(direction*M_PI_2, 0.0, 1.0, 0.0);
        // toView 在动画开始时的状态：+/-90º（垂直于屏幕，隐藏）
        CATransform3D viewToTransform = CATransform3DMakeRotation(-direction*M_PI_2, 0.0, 1.0, 0.0);
        // 设置一点透视效果
        viewFromTransform.m34 = m34;
        viewToTransform.m34 = m34;
        
        // 动画开始前，container 视图（包含有 to 视图）先平移到屏幕外边（右边或左边，根据方向而定）
        // 这样，动画开始后，to 视图实际上是以边旋转边移动的方式运动
        
        containerView.transform = CGAffineTransformMakeTranslation(direction * containerView.frame.size.width/2 , 0);
        // 设置 to 视图，摆成和 from 视图垂直状态
        toView.layer.transform = viewToTransform;
        [containerView addSubview:toView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options: UIViewAnimationOptionCurveEaseIn animations:^{
            // 让 container 视图做平移运动，push 时移动方向向左，pop 向右
            containerView.transform = CGAffineTransformMakeTranslation(-direction * containerView.frame.size.width/2 , 0);
            // 让 from 视图和 to 视图做旋转 90º 运动，push 时顺时针，pop 时反时针
            fromView.layer.transform = viewFromTransform;
            toView.layer.transform = CATransform3DIdentity;
            
        } completion:^(BOOL finished) {
            // 动画完成，将 container 视图、from 视图、to 视图恢复到初始状态
            containerView.transform = CGAffineTransformIdentity;
            fromView.layer.transform = CATransform3DIdentity;
            toView.layer.transform = CATransform3DIdentity;
            // 将锚点恢复到视图中心
            fromView.layer.anchorPoint = CGPointMake(0.5, 0.5);
            toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
            
            if (transitionContext.transitionWasCancelled) {
                // 如果取消，删除 to 视图
                [toView removeFromSuperview];
            } else {
                // 如果未取消，删除 from 视图
                [fromView removeFromSuperview];
            }
            // 通知 UIKit，动画完成
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
        
    }
    
 
}
@end

//
//  TestVC.m
//  Animations
//
//  Created by Arvin on 2017/6/30.
//  Copyright © 2017年 Arvin. All rights reserved.
//

#import "TestVC.h"

@interface TestVC ()
@property (nonatomic, weak) IBOutlet UIView *layerView;
@property (nonatomic, strong) CALayer *colorLayer;
@end

@implementation TestVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    //set the color of our layerView backing layer directly
    self.layerView.layer.backgroundColor = [UIColor blueColor].CGColor;
    
}

/*
 *  我们把改变属性时CALayer自动应用的动画称作行为，当CALayer的属性被修改时候，它会调用-actionForKey:方法，传递属性的名称。剩下的操作都在CALayer的头文件中有详细的说明，实质上是如下几步：
 *  +图层首先检测它是否有委托，并且是否实现CALayerDelegate协议指定的-actionForLayer:forKey方法。如果有，直接调用并返回结果。
 *  如果没有委托，或者委托没有实现-actionForLayer:forKey方法，图层接着检查包含属性名称对应行为映射的actions字典。
 *  如果actions字典没有包含对应的属性，那么图层接着在它的style字典接着搜索属性名。
 *  最后，如果在style里面也找不到对应的行为，那么图层将会直接调用定义了每个属性的标准行为的-defaultActionForKey:方法。
 *  所以一轮完整的搜索结束之后，-actionForKey:要么返回空（这种情况下将不会有动画发生），要么是CAAction协议对应的对象，最
 *  后CALayer拿这个结果去对先前和当前的值做动画
 *
 *  每个UIView对它关联的图层都扮演了一个委托，并且提供了-actionForLayer:forKey的实现方法。当不在一个动画块的实现中，
 *  UIView对所有图层行为返回nil，但是在动画block范围之内，它就返回了一个非空值。
 *

 *
 *  当然返回nil并不是禁用隐式动画唯一的办法，CATransacition有个方法叫做+setDisableActions:，
 *  可以用来对所有属性打开或者关闭隐式动画。
 *  UIView关联的图层禁用了隐式动画，对这种图层做动画的唯一办法就是使用UIView的动画函数（而不是依赖CATransaction），
 *  或者继承UIView，并覆盖-actionForLayer:forKey:方法，或者直接创建一个显式动画（具体细节见第八章）。
 *  对于单独存在的图层，我们可以通过实现图层的-actionForLayer:forKey:委托方法，或者提供一个actions字典来控制隐式动画。
 */
//隐式动画被禁用

- (void)yingShiDongHuaAble:(BOOL)ret {
    if (ret) {
        self.colorLayer = [CALayer layer];
        self.colorLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
        self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
        //add a custom action
        CATransition *transition = [CATransition animation];
        transition.type = kCATransitionFade;//kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        self.colorLayer.actions = @{@"backgroundColor": transition};
        //add it to our view
        [self.layerView.layer addSublayer:self.colorLayer];
    }else{
        //begin a new transaction
        [CATransaction begin];
        //set the animation duration to 1 second
        [CATransaction setAnimationDuration:1.0];
        //randomize the layer background color
        CGFloat red = arc4random() / (CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
        self.layerView.layer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
        //commit the transaction
        [CATransaction commit];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self yingShiDongHuaAble:YES];
}
- (IBAction)changeColor
{
    //解禁CATransaction的隐式动画
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    //CATransaction 隐式动画被禁用栗子：
//    [self yingShiDongHuaAble:NO];
}
//暂停和回复图层的动画
- (void)pasueLayer:(CALayer *)layer {
    CFTimeInterval pasuedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.;
    layer.timeOffset = pasuedTime;
}
- (void)resumeLayer:(CALayer *)layer {
    CFTimeInterval pasuedTime = [layer timeOffset];
    layer.speed = 1.;
    layer.timeOffset = 0;
    layer.beginTime = 0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pasuedTime;
    layer.beginTime = timeSincePause;
}
@end

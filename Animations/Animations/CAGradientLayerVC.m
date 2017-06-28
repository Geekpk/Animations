//
//  CAGradientLayerVC.m
//  Animations
//
//  Created by Arvin on 2017/6/28.
//  Copyright © 2017年 Arvin. All rights reserved.
//

#import "CAGradientLayerVC.h"
/*
 *  CAGradientLayer是用来生成两种或更多颜色平滑渐变的。用Core Graphics复制一个CAGradientLayer并将内容绘制到一个普通图层的寄宿图也是有可能的，但是CAGradientLayer的真正好处在于绘制使用了硬件加速。
 */
@interface CAGradientLayerVC ()
@property (weak, nonatomic) IBOutlet UIView *tipV;

@end

@implementation CAGradientLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)parameterSetting {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.tipV.bounds;
    [self.tipV.layer addSublayer:gradientLayer];
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blueColor].CGColor, (__bridge id)[UIColor whiteColor].CGColor,(__bridge id)[UIColor blackColor].CGColor];
    gradientLayer.locations = @[@(0), @(0.15), @(0.5)];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 0);
//    [self.view setNeedsDisplay];
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

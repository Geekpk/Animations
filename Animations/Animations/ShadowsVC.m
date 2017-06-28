//
//  ShadowsVC.m
//  Animations
//
//  Created by Arvin on 2017/6/27.
//  Copyright © 2017年 Arvin. All rights reserved.
//

#import "ShadowsVC.h"

@interface ShadowsVC ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;

@end

@implementation ShadowsVC
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
/*
 //CALayer
 * CALayer 与 UIView处于平行层级关系，CALayer不处理用户的交互、不清楚事件响应
 *  阴影，圆角，带颜色的边框
 *  3D变换
 *  非矩形范围
 *  透明遮罩
 *  多级非线性动画
 
 * 独立的Core Animation框架使得 macOS和iOS都可以公用该代码
 * 视图层级 、 图层树 、 呈现树  、 渲染树
 *
 *
 *
 */
- (void)parameterSetting {
//如果给contents赋的不是CGImage，那么你得到的图层将是空白的
//之所以被定义为id类型，是因为在Mac OS系统上，这个属性对CGImage和NSImage类型的值都起作用
//因为CGImageRef并不是一个真正的Cocoa对象，而是一个Core Foundation类型
//CGImage没有拉伸的概念。当我们使用UIImage类去读取我们的图片的时候，它读取了高质量的Retina版本的图片。
//但是当我们用CGImage来设置我们的图层的内容时，拉伸这个因素在转换的时候就丢失了。
    self.view1.layer.contents = (__bridge id)[UIImage imageNamed:@"love"].CGImage;
    
//contentsScale属性其实属于支持高分辨率（又称Hi-DPI或Retina）屏幕机制的一部分；
//它用来判断在绘制图层的时候应该为寄宿图创建的空间大小，和需要显示的图片的拉伸度（假设并没有设置contentsGravity属性）
    self.view1.layer.contentsScale = [UIScreen mainScreen].scale;
    
//给contents赋CGImage的值不是唯一的设置寄宿图的方法。我们也可以直接用Core Graphics直接绘制寄宿图。能够通过继承UIView并实现-drawRect:方法来自定义绘制。
//如果UIView检测到-drawRect: 方法被调用了，它就会为视图分配一个寄宿图，这个寄宿图的像素尺寸等于视图大小乘以 contentsScale的值
//如果你不需要寄宿图，那就不要创建这个方法了，这会造成CPU资源和内存的浪费，这也是为什么苹果建议：如果没有自定义绘制的任务就不要在子类中写一个空的-drawRect:方法。
    
//当视图在屏幕上出现的时候 -drawRect:方法就会被自动调用。-drawRect:方法里面的代码利用Core Graphics去绘制一个寄宿图，然后内容就会被缓存起来直到它需要被更新（通常是因为开发者调用了-setNeedsDisplay方法，尽管影响到表现效果的属性值被更改时，一些视图类型会被自动重绘，如bounds属性）。虽然-drawRect:方法是一个UIView方法，事实上都是底层的CALayer安排了重绘工作和保存了因此产生的图片
    
    self.view1.layer.shadowOpacity = 0.5;
    self.view2.layer.shadowOpacity = 0.5;
    CGMutablePathRef ref1 = CGPathCreateMutable();
    CGPathAddRect(ref1, NULL, self.view1.bounds);
    self.view1.layer.shadowPath = ref1;
    CGPathRelease(ref1);
    
    CGMutablePathRef ref2 = CGPathCreateMutable();
    CGPathAddRect(ref2, NULL, self.view2.bounds);
    self.view2.layer.shadowPath = ref2;
    CGPathRelease(ref2);
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
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

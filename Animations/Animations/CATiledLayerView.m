//
//  CATiledLayerView.m
//  Animations
//
//  Created by Arvin on 2017/6/29.
//  Copyright © 2017年 Arvin. All rights reserved.
//
/*
 *  载入大图可能会相当地慢，那些对你看上去比较方便的做法（在主线程调用UIImage的-imageNamed:方法或
 *  者-imageWithContentsOfFile:方法）将会阻塞你的用户界面，至少会引起动画卡顿现象。
 *  高效绘制在iOS上的图片也有一个大小限制。所有显示在屏幕上的图片最终都会被转化为OpenGL纹理，同时
 *  OpenGL有一个最大的纹理尺寸（通常是2048*2048，或4096*4096，这个取决于设备型号）。如果你想在单
 *  个纹理中显示一个比这大的图，即便图片已经存在于内存中了，你仍然会遇到很大的性能问题，因为Core
 *  Animation强制用CPU处理图片而不是更快的GPU（见『速度的曲调』，和『高效绘图』，它更
 *  加详细地解释了软件绘制和硬件绘制）。
 *  CATiledLayer为载入大图造成的性能问题提供了一个解决方案：将大图分解成小片然后将他们单独按需载入
 */
#import "CATiledLayerView.h"
@interface CATiledLayerView ()
@property (nonatomic, assign) CGFloat sideLength;
@end
@implementation CATiledLayerView
+ (Class)layerClass {
    return [CATiledLayer class];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    CGFloat scale = [UIScreen mainScreen].scale;
    self.layer.contentsScale = scale;
    CATiledLayer *layer = (CATiledLayer *)self.layer;
    self.sideLength = 50.;
    layer.tileSize = CGSizeMake(_sideLength * scale, _sideLength * scale);
}

- (void)saveTilesOfSize:(CGSize)size forImage:(UIImage *)image toDirectory:(NSString *)directoryPath usingPrefix:(NSString *)prefix {
    CGFloat cols = image.size.width / size.width;
    CGFloat rows = image.size.height / size.height;
    
    int fullColumns = floorf(cols);
    int fullRows = floorf(rows);
    CGFloat remainderWidth = image.size.width - (fullColumns * size.width);
    CGFloat remainderHeight = image.size.height - (fullColumns * size.height);
    if (cols > fullColumns) fullColumns++;
    if (rows > fullRows) fullRows++;
    CGImageRef fullImage = image.CGImage;
    for (int y=0; y<fullRows; ++y) {
        for (int x=0; x<fullColumns; ++x) {
            CGSize tileSize = size;
            if (x+1==fullColumns && remainderWidth>0) {
                tileSize.width = remainderWidth;
            }
            if (y+1==fullRows && remainderWidth>0) {
                tileSize.height = remainderHeight;
            }
            CGImageRef tileImage = CGImageCreateWithImageInRect(fullImage, (CGRect){{x*size.width, y*size.height},tileSize});
            NSData *data = UIImagePNGRepresentation([UIImage imageWithCGImage:tileImage]);
            NSString *path = [NSString stringWithFormat:@"%@/%@%d_%d.png",directoryPath, prefix, x,y];
            [data writeToFile:path atomically:NO];
        }
    }
}
- (UIImage *)titleAtCol:(int)col row:(int)row {
    NSString *tileDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [NSString stringWithFormat:@"%@/%d_%d.png", tileDirectory, col, row];
    return [UIImage imageWithContentsOfFile:path];
}
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGSize tileSize = CGSizeMake(256, 256);
    
    int fc = floorf(CGRectGetMinX(rect) / tileSize.width);
    int lc = floorf((CGRectGetMaxX(rect)-1) / tileSize.width);
    int fr = floorf(CGRectGetMinY(rect) / tileSize.height);
    int lr = floorf((CGRectGetMaxY(rect)-1) / tileSize.height);
    
    for (int row = fr; row<=lr; row++) {
        for (int col = fc; col<=lc; col++) {
            UIImage *tile = [self titleAtCol:col row:row];
            CGRect tileRect = CGRectMake(tileSize.width*col, tileSize.height*row, tileSize.width, tileSize.height);
            /*
             *  CGRectContainsRect表示rect1和rect2是否有重叠
             *  CGRectContainsPoint表示point是不是在rect上
             *  CGRectIntersectsRect的意思是rect1是否包含了rect2
             CGRectUnion(rect1,rect2) 返回值是能够包含两个矩形的最小矩形
             CGRectIntersection(rect1, rect2)
             求两个矩形的交集，返回结果是两个矩形相交的区域，如果没有交集的话，返回值是NSNullRect
             */
            tileRect = CGRectIntersection(self.bounds, tileRect);
            [tile drawInRect:tileRect];
            CGContextSetLineWidth(context, 6.);
            CGContextStrokeRect(context, tileRect);
        }
    }

//    CGFloat r = drand48();
//    CGFloat g = drand48();
//    CGFloat b = drand48();
//    CGContextSetRGBFillColor(context, r, g, b, 1);
//    CGContextFillRect(context, rect);
    /*
    CGContextRef context = UIGraphicsGetCurrentContext();
    设置填充颜色
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    设置描边颜色
    CGContextSetStrokeColorWithColor(context, [UIColor darkGrayColor].CGColor);
    
    为了颜色更好的区分 对矩形进行描边
    CGContextFillRect(context, rect);
    CGContextStrokeRect(context, rect);
    实际line和point代码
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    设置画笔的宽度
    CGContextSetLineWidth(context, 4.0);
    设置线的顶端的样式
    CGContextSetLineCap(context, kCGLineCapRound);
    设置线相交处的样式
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGPoint selfCent = CGPointMake(self.bounds.size.width / 2 + 1, self.bounds.size.height / 2);
    CGFloat width = 1;
    设置画线的起点
    CGContextMoveToPoint(context, selfCent.x - width /2 , selfCent.y - width /2 );
    //移动画笔到结束点，并将结束点作为下一次画线的起点
    CGContextAddLineToPoint(context, selfCent.x - width /2 , selfCent.y + width /2 );
    CGContextAddLineToPoint(context, selfCent.x + width / 2, selfCent.y);
    CGContextAddLineToPoint(context, selfCent.x - width / 2, selfCent.y - width / 2);
    //提交 开始渲染
    CGContextStrokePath(context);
     */
}
/*
 *  当你滑动这个图片，你会发现当CATiledLayer载入小图的时候，他们会淡入到界面中。这是CATiledLayer的默
 *  认行为。（你可能已经在iOS 6之前的苹果地图程序中见过这个效果）你可以用fadeDuration属性改变淡入时
 *  长或直接禁用掉。CATiledLayer（不同于大部分的UIKit和Core Animation方法）支持多线程绘制，-
 *  drawLayer:inContext:方法可以在多个线程中同时地并发调用，所以请小心谨慎地确保你在这个方法中实现的
 *  绘制代码是线程安全的。
 *
 */
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    
}
@end

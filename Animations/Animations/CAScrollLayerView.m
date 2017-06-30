//
//  CAScrollLayerView.m
//  Animations
//
//  Created by Arvin on 2017/6/29.
//  Copyright © 2017年 Arvin. All rights reserved.
//

#import "CAScrollLayerView.h"

@implementation CAScrollLayerView
+ (Class)layerClass
{
    return [CAScrollLayer class];
}

- (void)setUp {
    //enable clipping
    self.layer.masksToBounds = YES;
    
    //attach pan gesture recognizer
    UIPanGestureRecognizer *recognizer = nil;
    recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:recognizer];
}

- (id)initWithFrame:(CGRect)frame
{
    //this is called when view is created in code
    if ((self = [super initWithFrame:frame])) {
        UIImageView *imgV= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"love"]];
        [self addSubview:imgV];
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib {
    //this is called when view is created from a nib
    [self setUp];
}

- (void)pan:(UIPanGestureRecognizer *)recognizer {
    //get the offset by subtracting the pan gesture
    //translation from the current bounds origin
    CGPoint offset = self.bounds.origin;
    offset.x -= [recognizer translationInView:self].x;
    offset.y -= [recognizer translationInView:self].y;
    
    //scroll the layer
    [(CAScrollLayer *)self.layer scrollToPoint:offset];
    
    //reset the pan gesture translation
    [recognizer setTranslation:CGPointZero inView:self];
}
@end

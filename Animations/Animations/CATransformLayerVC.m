//
//  CATransformLayerVC.m
//  Animations
//
//  Created by Arvin on 2017/6/28.
//  Copyright © 2017年 Arvin. All rights reserved.
//

#import "CATransformLayerVC.h"

@interface CATransformLayerVC ()
//@property (weak, nonatomic) IBOutlet UIView *cViwe;

@end

@implementation CATransformLayerVC
- (CALayer *)faceWithTransform:(CATransform3D)transform {
    CALayer *face = [CALayer layer];
    face.frame = CGRectMake(-50, -50, 100, 100);
    CGFloat r = (rand() / (double)INT_MAX);
    CGFloat g = (rand() /(double)INT_MAX);
    CGFloat b = (rand() /(double)INT_MAX);
    face.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1].CGColor;
    face.transform = transform;
    return face;
}
- (CALayer *)cubeWithTransform:(CATransform3D)transform {
    CATransformLayer *cube = [CATransformLayer layer];
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
//
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
//
    CGSize containSize = self.view.bounds.size;
    cube.position = CGPointMake(containSize.width/2., containSize.height/2.);
    cube.transform = transform;
    return cube;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];   
}

- (void)parameterSetting {
    CATransform3D pt = CATransform3DIdentity;
    pt.m34 = -1./500;
    
    self.view.layer.sublayerTransform = pt;
    
    //    CATransform3D c1t = CATransform3DIdentity;
    //    c1t = CATransform3DTranslate(c1t, -100, 0, 0);
    //    CALayer *cube1 = [self cubeWithTransform:c1t];
    //    [self.view.layer addSublayer:cube1];
    CATransform3D c2t = CATransform3DIdentity;
    c2t = CATransform3DRotate(c2t, -M_PI_4, 1, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 0, 1, 0);
    CALayer *cube2 = [self cubeWithTransform:c2t];
    [self.view.layer addSublayer:cube2];
//    [self.view setNeedsDisplay];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
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

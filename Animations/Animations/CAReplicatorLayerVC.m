//
//  CAReplicatorLayerVC.m
//  Animations
//
//  Created by Arvin on 2017/6/28.
//  Copyright © 2017年 Arvin. All rights reserved.
//
//http://www.uml.org.cn/mobiledev/2015091110.asp
#import "CAReplicatorLayerVC.h"
#import "CAReplicatorLayerView.h"
@interface CAReplicatorLayerVC ()
@property (weak, nonatomic) IBOutlet UIView *tipV;

@end

@implementation CAReplicatorLayerVC
- (void)parameterSetting {
    CAReplicatorLayerView *v = [[[NSBundle mainBundle] loadNibNamed:@"CAReplicatorLayerView" owner:self options:nil] firstObject];
//    v.frame = CGRectMake(100, 100, 200, 200);
    v.frame = self.view.bounds;
    [self.view.layer addSublayer:v.layer];
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = self.tipV.bounds;
    [self.tipV.layer addSublayer:replicator];
    replicator.instanceCount = 10;
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 120, 0);
    transform = CATransform3DRotate(transform, M_PI / 5, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -120, 0);
    replicator.instanceTransform = transform;
    //    replicator.instanceGreenOffset = -0.1;
    //    replicator.instanceRedOffset = -0.1;
    replicator.instanceBlueOffset = -0.1;
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, self.view.center.y-40, 80, 80);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
//    [replicator addSublayer:layer];
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

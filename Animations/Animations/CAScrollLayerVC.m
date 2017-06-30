//
//  CAScrollLayerVC.m
//  Animations
//
//  Created by Arvin on 2017/6/29.
//  Copyright © 2017年 Arvin. All rights reserved.
//

#import "CAScrollLayerVC.h"
#import "CAScrollLayerView.h"
@interface CAScrollLayerVC ()

@end

@implementation CAScrollLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)parameterSetting {
    CAScrollLayerView *v = [[CAScrollLayerView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    v.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

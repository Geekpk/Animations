//
//  BasicVC.m
//  Animations
//
//  Created by Arvin on 2017/6/27.
//  Copyright © 2017年 Arvin. All rights reserved.
//

#import "BasicVC.h"

@interface BasicVC ()

@end

@implementation BasicVC
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self normalSetting];
    
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self parameterSetting];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self parameterSetting];
}
- (void)normalSetting {
    
}
- (void)parameterSetting {
    
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

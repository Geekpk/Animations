//
//  ViewController.m
//  Animations
//
//  Created by Arvin on 2017/6/27.
//  Copyright © 2017年 Arvin. All rights reserved.
//

#import "ViewController.h"
#import "ShadowsVC.h"
#import "CAShapeLayerVC.h"
@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)normalSetting {
    NSArray *arr = @[@"Shadows", @"CAShapeLayer", @"AnchorPoint",@"CATransformLayer",@"CAGradientLayer" , @"CAReplicatorLayer"];
    [self.dataSource addObjectsFromArray:arr];
}
- (void)parameterSetting {
    
}
#pragma mark- Setter & Getter
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
#pragma mark- UITableViewDelegate & UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.layer.cornerRadius = 20;
    cell.layer.masksToBounds = YES;
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = [UIColor colorWithRed:(arc4random() % 255) /255. green:(arc4random() % 255) /255. blue:(arc4random() % 255) /255. alpha:1];
    if (CGColorEqualToColor(cell.backgroundColor.CGColor, [UIColor whiteColor].CGColor)) {
        cell.textLabel.textColor = [UIColor blackColor];
    }else{
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    NSString *clsstr = [NSString stringWithFormat:@"%@VC",self.dataSource[indexPath.row]];
//    Class cls = [NSClassFromString(clsstr) class];
//    UIViewController *obj = [[cls alloc] init];
    UIViewController *obj =  [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:clsstr];
    obj.title = self.dataSource[indexPath.row];
//    obj.view.backgroundColor = [UIColor whiteColor];
    obj.view.backgroundColor = cell.backgroundColor;
    
    [self.navigationController pushViewController:obj animated:YES];
}




@end

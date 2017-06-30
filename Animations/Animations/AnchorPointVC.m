//
//  AnchorPointVC.m
//  Animations
//
//  Created by Arvin on 2017/6/27.
//  Copyright © 2017年 Arvin. All rights reserved.
//

#import "AnchorPointVC.h"

@interface AnchorPointVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hChangdu;
@property (weak, nonatomic) IBOutlet UIImageView *himgV;
@property (weak, nonatomic) IBOutlet UIImageView *mimgV;
@property (weak, nonatomic) IBOutlet UIImageView *simgV;
@property (nonatomic, retain) dispatch_source_t timer;
@property (nonatomic, retain) dispatch_queue_t quene;
@property (weak, nonatomic) IBOutlet UIImageView *imgRomato;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgsShuZi;
@end

@implementation AnchorPointVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImage *digits = [UIImage imageNamed:@"shuzizhong"];
    
    //set up digit views
    for (id view in self.imgsShuZi) {
        //set contents
        if (![view isKindOfClass:[UIView class]]) {
            UIView *v = (UIView *)view;
            v.layer.contents = (__bridge id)digits.CGImage;
            v.layer.contentsRect = CGRectMake(0, 0, 0.1, 1.0);
            v.layer.contentsGravity = kCAGravityResizeAspect;
        }else{
            UIImageView *imgv = (UIImageView *)view;
            imgv.image = digits;
            imgv.layer.contentsRect = CGRectMake(0, 0, 0.1, 1.);
            imgv.layer.contentsGravity = kCAGravityResizeAspect;
        }
        
    }
    
    self.quene = dispatch_queue_create("otw0909.clock", NULL);
    //start timer
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.quene);
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, ^{
        [self performSelectorOnMainThread:@selector(tick) withObject:nil waitUntilDone:NO];
    });
    dispatch_resume(self.timer);
    
    //set initial hand positions
    self.imgRomato.layer.transform = CATransform3DMakeRotation(3*M_PI_4, 0, 0, 1);
}


- (void)parameterSetting {
    self.simgV.layer.anchorPoint = CGPointMake(0.5f, 0.8f);
    self.mimgV.layer.anchorPoint = CGPointMake(0.5f, 0.8f);
    self.himgV.layer.anchorPoint = CGPointMake(0.5f, 0.8f);
}

- (void)setDigit:(NSInteger)digit forView:(UIView *)view
{
    //adjust contentsRect to select correct digit
    view.layer.contentsRect = CGRectMake(digit * 0.1, 0, 0.1, 1.0);
}

- (void)tick {
    //convert time to hours, minutes and seconds
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    CGFloat hoursAngle = (components.hour / 12.0) * M_PI * 2.0;
    //calculate hour hand angle //calculate minute hand angle
    CGFloat minsAngle = (components.minute / 60.0) * M_PI * 2.0;
    //calculate second hand angle
    CGFloat secsAngle = (components.second / 60.0) * M_PI * 2.0;
    //rotate hands
    self.himgV.transform = CGAffineTransformMakeRotation(hoursAngle);
    self.mimgV.transform = CGAffineTransformMakeRotation(minsAngle);
    self.simgV.transform = CGAffineTransformMakeRotation(secsAngle);
    
    //set hours
    [self setDigit:components.hour / 10 forView:self.imgsShuZi[0]];
    [self setDigit:components.hour % 10 forView:self.imgsShuZi[1]];
    
    //set minutes
    [self setDigit:components.minute / 10 forView:self.imgsShuZi[2]];
    [self setDigit:components.minute % 10 forView:self.imgsShuZi[3]];
    
    //set seconds
    [self setDigit:components.second / 10 forView:self.imgsShuZi[4]];
    [self setDigit:components.second % 10 forView:self.imgsShuZi[5]];
}
@end

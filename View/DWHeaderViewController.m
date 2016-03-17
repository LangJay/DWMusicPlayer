//
//  DWHeaderViewController.m
//  DWMusicPlayer
//
//  Created by 周继良 on 15/11/11.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWHeaderViewController.h"

@interface DWHeaderViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;
@end

@implementation DWHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backView.backgroundColor = kBackGroundColor;
    self.dateLabel.text = [self getCurrentDate];
}

-(NSString *)getCurrentDate
{
    NSDate *senddate = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *currentDate = [[dateformatter stringFromDate:senddate] stringByAppendingString:@"更新"];
    return currentDate;
}
- (IBAction)downLoadBtn:(UIButton *)sender {
    NSLog(@"...");
}
- (IBAction)playBtn:(UIButton *)sender {
    NSLog(@"bofang");
}


@end

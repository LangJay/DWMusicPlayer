//
//  DWBoFangViewController.h
//  逗我
//
//  Created by 周继良 on 15/11/25.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DWRecommendList.h"

@interface DWBoFangViewController : UIViewController
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *songLists;
-(void)show;
-(void)pushViewFromView;
@end

//
//  DWRecommendViewModel.h
//  逗我
//
//  Created by 周继良 on 15/11/14.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWBaseViewModel.h"
#import "DWRecommendNetManager.h"

@interface DWRecommendViewModel : DWBaseViewModel
@property(nonatomic)NSInteger index;

-(songListModel *)ListArrayForRow:(NSInteger)row;
-(NSString *)titleForRow:(NSInteger)row;
-(NSString *)authorForRow:(NSInteger)row;
-(NSURL *)smallPicForRow:(NSInteger)row;
-(BOOL)hasMVForRow:(NSInteger)row;
-(NSString *)songIDForRow:(NSInteger)row;
-(NSMutableArray *)getDataArray;
-(NSInteger)rowNumber;
@end

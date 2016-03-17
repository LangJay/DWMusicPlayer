//
//  DWScrollModel.m
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/2.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWScrollModel.h"

@implementation DWScrollModel
//定义两个数组对象中的元素，对应的解析类
+(NSDictionary *)objectClassInArray
{
    return @{@"pic":[DWPicScrollModel class]};
}
@end
@implementation DWPicScrollModel
+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ipadDesc":@"ipad_desc"
             ,@"isPublish":@"is_publish"
             ,@"randpic2":@"randpic_2"
             ,@"randpicDesc":@"randpic_desc"
             ,@"randpicIos5":@"randpic_ios5"
             ,@"randpicIpad":@"randpic_ipad"
             ,@"randpicIphone6":@"randpic_iphone6"
             ,@"randpicQq":@"randpic_qq"
             ,@"specialType":@"special_type"
             };
}
@end

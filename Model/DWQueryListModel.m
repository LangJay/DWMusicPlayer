//
//  DWQueryListModel.m
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/1.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWQueryListModel.h"

@implementation DWQueryListModel
+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"suggestionList":@"suggestion_list"
             };
}
@end

//
//  DWQueryListModel.h
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/1.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWBaseModel.h"

@interface DWQueryListModel : DWBaseModel
@property (nonatomic, strong) NSString *query;
@property (nonatomic, strong) NSArray *suggestionList;
@end

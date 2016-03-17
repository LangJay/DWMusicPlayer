//
//  DWRadioModel.h
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/8.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWBaseModel.h"

@interface DWRadioModel : DWBaseModel
@property (nonatomic, assign) double errorCode;
@property (nonatomic, strong) NSArray *list;
@end
@interface DWRadioList : DWBaseModel
@property (nonatomic, strong) NSString *albumId;
@property (nonatomic, strong) NSString *itemid;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *channelid;
@property (nonatomic, strong) NSString *desc;
@end
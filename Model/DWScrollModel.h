//
//  DWScrollModel.h
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/2.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWBaseModel.h"

@interface DWScrollModel : DWBaseModel
@property (nonatomic, strong) NSArray *pic;
@property (nonatomic, assign) double errorCode;
@end
@interface DWPicScrollModel : DWBaseModel
@property (nonatomic, assign) double specialType;
@property (nonatomic, strong) NSString *randpicIphone6;
@property (nonatomic, strong) NSString *isPublish;
@property (nonatomic, strong) NSString *randpic;
@property (nonatomic, strong) NSString *randpicIpad;
@property (nonatomic, strong) NSString *moType;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *randpic2;
@property (nonatomic, strong) NSString *randpicIos5;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *randpicQq;
@property (nonatomic, strong) NSString *ipadDesc;
@property (nonatomic, strong) NSString *randpicDesc;
@end
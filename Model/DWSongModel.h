//
//  DWSongModel.h
//  逗我
//
//  Created by 周继良 on 15/11/25.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWBaseModel.h"

@interface DWSongModel : DWBaseModel
@property (nonatomic, strong) NSString *lrclink;
@property (nonatomic, strong) NSString *shareUrl;
@property (nonatomic, strong) NSArray *songurl;
@property (nonatomic, strong) NSString *picPremium;
@property (nonatomic, strong) NSString *songId;
@end
@interface DWSongUrl : DWBaseModel
@property (nonatomic, assign) double canSee;
@property (nonatomic, strong) NSString *hash1;
@property (nonatomic, assign) double downType;
@property (nonatomic, strong) NSString *replayGain;
@property (nonatomic, assign) BOOL canLoad;
@property (nonatomic, assign) double free;
@property (nonatomic, assign) double original;
@property (nonatomic, strong) NSString *showLink;
@property (nonatomic, assign) double preload;
@property (nonatomic, strong) NSString *fileLink;
@property (nonatomic, strong) NSString *fileExtension;
@property (nonatomic, assign) double isUditionUrl;
@property (nonatomic, assign) double fileSize;
@property (nonatomic, assign) double fileDuration;
@property (nonatomic, assign) double fileBitrate;
@property (nonatomic, assign) double songFileId;
@end

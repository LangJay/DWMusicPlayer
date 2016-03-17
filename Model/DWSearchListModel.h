//
//  DWSearchListModel.h
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/1.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWBaseModel.h"

@interface DWSearchListModel : DWBaseModel
@property (nonatomic, strong) NSArray *songList;
@end
@interface DwSearchSongModel : DWBaseModel
@property (nonatomic, strong) NSString *allRate;
@property (nonatomic, strong) NSString *allArtistId;
@property (nonatomic, strong) NSString *cpType;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) double learn;
@property (nonatomic, strong) NSString *toneid;
@property (nonatomic, assign) double hasMv;
@property (nonatomic, strong) NSString *resourceType;
@property (nonatomic, strong) NSString *mvProvider;
@property (nonatomic, assign) double relateStatus;
@property (nonatomic, strong) NSString *albumTitle;
@property (nonatomic, strong) NSString *songId;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *lrclink;
@property (nonatomic, assign) double hasMvMobile;
@property (nonatomic, strong) NSString *artistId;
@property (nonatomic, strong) NSString *appendix;
@property (nonatomic, assign) double havehigh;
@property (nonatomic, assign) double dataSource;
@property (nonatomic, assign) double charge;
@property (nonatomic, strong) NSString *albumId;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *content;
@end
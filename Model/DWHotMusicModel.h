//
//  DWHotMusicModel.h
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/7.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWBaseModel.h"

@interface DWHotMusicModel : DWBaseModel
@property (nonatomic, assign) double errorCode;
@property (nonatomic, strong) NSArray *songList;
@property (nonatomic, strong) NSDictionary *billboard;

@end
@interface DWHotBillBoardModel : DWBaseModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *billboardNo;
@property (nonatomic, strong) NSString *picS640;
@property (nonatomic, strong) NSString *billboardType;
@property (nonatomic, strong) NSString *picS210;
@property (nonatomic, strong) NSString *webUrl;
@property (nonatomic, strong) NSString *picS444;
@property (nonatomic, strong) NSString *updateDate;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *picS260;
@property (nonatomic, assign) double havemore;
@end
@interface DWHotSonglistModel : DWBaseModel
@property (nonatomic, strong) NSString *koreanBbSong;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *picBig;
@property (nonatomic, strong) NSString *rankChange;
@property (nonatomic, assign) double charge;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *resourceTypeExt;
@property (nonatomic, strong) NSString *piaoId;
@property (nonatomic, strong) NSString *rank;
@property (nonatomic, assign) double hasMv;
@property (nonatomic, strong) NSString *hot;
@property (nonatomic, strong) NSString *lrclink;
@property (nonatomic, strong) NSString *picSmall;
@property (nonatomic, strong) NSString *songSource;
@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, strong) NSString *allArtistTingUid;
@property (nonatomic, strong) NSString *isNew;
@property (nonatomic, assign) double havehigh;
@property (nonatomic, strong) NSString *publishtime;
@property (nonatomic, assign) double fileDuration;
@property (nonatomic, strong) NSString *toneid;
@property (nonatomic, strong) NSString *artistId;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *albumId;
@property (nonatomic, assign) double learn;
@property (nonatomic, strong) NSString *style;
@property (nonatomic, strong) NSString *mvProvider;
@property (nonatomic, strong) NSString *albumTitle;
@property (nonatomic, strong) NSString *delStatus;
@property (nonatomic, strong) NSString *soundEffect;
@property (nonatomic, strong) NSString *albumNo;
@property (nonatomic, assign) double hasMvMobile;
@property (nonatomic, strong) NSString *songId;
@property (nonatomic, strong) NSString *resourceType;
@property (nonatomic, assign) double isFirstPublish;
@property (nonatomic, strong) NSString *allRate;
@property (nonatomic, strong) NSString *tingUid;
@property (nonatomic, strong) NSString *allArtistId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *cpType;
@property (nonatomic, strong) NSString *relateStatus;
@end
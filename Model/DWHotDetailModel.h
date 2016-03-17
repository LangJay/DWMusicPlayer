//
//  DWHotDetailModel.h
//  DWMusicPlayer
//
//  Created by 周继良 on 15/12/10.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWBaseModel.h"

@interface DWHotDetailModel : DWBaseModel
@property (nonatomic, strong) NSString *webURL;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *picSmall;
@property (nonatomic, strong) NSString *songId;
@property (nonatomic, assign) NSString *resourceTyoe;
@property (nonatomic, assign) double hasMV;
@property (nonatomic, assign) double hasMore;
@end

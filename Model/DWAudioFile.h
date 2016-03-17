//
//  DWAudioFile.h
//  DWMusicPlayer
//
//  Created by 周继良 on 15/11/26.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOUAudioFile.h"

@interface DWAudioFile : NSObject<DOUAudioFile>
@property (nonatomic, strong) NSURL *audioFileURL;

@end

//
//  DWBaseNetManager.h
//  DWMusicPlayer
//
//  Created by 周继良 on 15/10/29.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCompletionHandle completionHandle:(void(^)(id model, NSError *error))completionHandle

@interface DWBaseNetManager : NSObject


+ (id)GET:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete;

+ (id)POST:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete;

@end

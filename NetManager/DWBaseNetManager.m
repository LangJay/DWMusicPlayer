//
//  DWBaseNetManager.m
//  DWMusicPlayer
//
//  Created by 周继良 on 15/10/29.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWBaseNetManager.h"
#import "MBProgressHUD+MJ.h"

static AFHTTPSessionManager *manager = nil;

@implementation DWBaseNetManager


+ (AFHTTPSessionManager *)sharedAFManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", nil];
    });
    return manager;
}

+ (id)GET:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete{
    //打印网络请求， DDLog  与  NSLog 功能一样
    DDLogVerbose(@"Request Path: %@, Params:%@", path, params);
    return [[self sharedAFManager] GET:path parameters:params success:^void(NSURLSessionDataTask * task, id responseObject) {
        complete(responseObject, nil);
    } failure:^void(NSURLSessionDataTask * task, NSError * error) {
        complete(nil, error);
        //回到主线程加载，否则会出错。
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showError:@"网络错误!"];
        });
    }];
}

+ (id)POST:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete{
    return [[self sharedAFManager] POST:path parameters:params success:^void(NSURLSessionDataTask * task, id responseObject) {
        complete(responseObject, nil);
    } failure:^void(NSURLSessionDataTask * task, NSError * error) {
        [self handleError:error];
        complete(nil, error);
    }];
}

+ (void)handleError:(NSError *)error{
    [[self new] showErrorMsg:error]; //弹出错误信息
}

@end

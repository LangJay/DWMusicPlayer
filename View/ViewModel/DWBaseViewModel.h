//
//  DWBaseViewModel.h
//  DWMusicPlayer
//
//  Created by 周继良 on 15/10/29.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionHandle)(NSError *error);

@protocol DWBaseViewModelDelegate <NSObject>

@optional
//获取更多
- (void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle;
//刷新
- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle;
//获取数据
- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle;

@end

@interface DWBaseViewModel : NSObject<DWBaseViewModelDelegate>

@property(nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,strong) NSURLSessionDataTask *dataTask;
- (void)cancelTask;  //取消任务
- (void)suspendTask; //暂停任务
- (void)resumeTask;  //继续任务

@end

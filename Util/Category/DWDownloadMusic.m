//
//  DWDownloadMusic.m
//  DWMusicPlayer
//
//  Created by 周继良 on 15/11/27.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWDownloadMusic.h"
#import "DWMusic.h"
#import "MBProgressHUD+MJ.h"

@implementation DWDownloadMusic
+(void)downloadMusicsWith:(NSArray *)musics
{
    for (DWMusic *m in musics) {
        if (![DWDownloadMusic isExistSongWithSongId:m.songId])//文件不存在才下载
        {
            [MBProgressHUD showError:@"正在下载..."];
            dispatch_queue_t queueLRC = dispatch_queue_create("downlrcQueue", NULL);
            dispatch_async(queueLRC, ^{
                [DWDownloadMusic downloadFileWithFileName:m.lrcname withExtension:[m.songId stringByAppendingString:@".lrc"] Formusic:m];
            });
            dispatch_queue_t queueMP3 = dispatch_queue_create("downmp3Queue", NULL);
            dispatch_async(queueMP3, ^{
                [DWDownloadMusic downloadFileWithFileName:m.songurl withExtension:[m.songId stringByAppendingString:@".mp3"] Formusic:m];
            });
            dispatch_queue_t queueJPF = dispatch_queue_create("downjpgQueue", NULL);
            dispatch_async(queueJPF, ^{
                [DWDownloadMusic downloadFileWithFileName:m.pic withExtension:[m.songId stringByAppendingString:@".jpg"] Formusic:m];
            });
        }
        else
        {
            [MBProgressHUD showError:@"歌曲已存在!"];
        }
        
    }
}
+(void)downloadFileWithFileName:(NSString *)fileName withExtension:(NSString *)extension Formusic:(DWMusic *)music
{
    NSURL *url = [NSURL URLWithString:fileName];
    NSURLRequest *urlRequest = [[NSURLRequest alloc]initWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:urlRequest completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        //location 参数是下载来的文件的临时地址
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        //如果是200请求是正常响应的-404错误是服务器不存在页面－－的http状态码
        if (httpResponse.statusCode == 200) {
            //临时文件在程序结束后会删除掉，所以将临时文件存放在指定的目录中
            NSString *path = [DWDownloadMusic createPlistFile];
            NSString *filePath = [path stringByAppendingPathComponent:extension];
            NSError *error = nil;
            [[NSFileManager defaultManager] moveItemAtPath:[location path] toPath:filePath error:&error];
            NSRange range = [extension rangeOfString:@"."];
            NSString *str = [extension substringFromIndex:range.location];
            if ([str isEqualToString:@".mp3"])//等待mp3下载完毕才提醒
            {
//                //回到主线程加载，否则会出错。
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [MBProgressHUD showError:@"下载成功!"];
//                });
                [DWDownloadMusic writeToPlist:music];
            }
            
        }
        else
        {
            //回到主线程加载，否则会出错。
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"网络错误!"];
            });
        }
    }];
    [task resume];
}
+(NSString *)createPlistFile
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"musics"];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}
+(void)writeToPlist:(DWMusic *)music
{
    //读取plist
    NSString *plistPath = [[DWDownloadMusic createPlistFile] stringByAppendingPathComponent:@"music.plist"];
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    if (data == nil) {
        data = [NSMutableArray new];
    }
    NSDictionary *dict = [music mj_keyValues];
    [data  addObject:dict];
    //输入写入
    if (![DWDownloadMusic isExistSongWithSongId:music.songId])//避免下载线程未完成重复下载
    {
        if (![data writeToFile:plistPath atomically:YES])
        {
            //回到主线程加载，否则会出错。
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"下载错误!"];
            });
            //把文件也删除
            NSMutableArray *musics = [NSMutableArray new];
            [musics addObject:music];
            [DWDownloadMusic deleteFailMusicWith:musics];
        }
    }
}
+(NSArray *)readFileFromPlist
{
    NSString *plistPath = [[DWDownloadMusic createPlistFile] stringByAppendingPathComponent:@"music.plist"];
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    if (data == nil) {
        data = [NSMutableArray new];
        return data;
    }
    else
    {
        NSMutableArray *arr = [NSMutableArray new];
        for (NSDictionary *d in data) {
            DWMusic *music = [DWMusic mj_objectWithKeyValues:d];
            [arr addObject:music];
        }
        return arr;
    }
}
+(BOOL)isExistSongWithSongId:(NSString *)songId
{
    NSArray *arr = [DWDownloadMusic readFileFromPlist];
    if (arr == nil) {
        return NO;
    }
    else
    {
        for (DWMusic *m in arr) {
            if ([m.songId isEqualToString:songId]) {
                return YES;
            }
        }
    }
    return NO;
}
+(void)deleteFailMusicWith:(NSArray *)musics
{
    
    for (DWMusic *m in musics) {
        if ([DWDownloadMusic isExistSongWithSongId:m.songId])//文件存在才删除
        {
            NSArray *arr = [DWDownloadMusic readFileFromPlist];
            NSMutableArray *data = [NSMutableArray arrayWithArray:arr];
            int indexs[data.count];
            int index = 0;
            for (int i = 0; i < data.count; i++) {
                DWMusic *music = [data objectAtIndex:i];
                if ([m.songId isEqualToString:music.songId]) {
                    indexs[index] = i;
                    index ++;
                    //搜索文件本地文件，并且删除
                    NSFileManager *fileManager = [NSFileManager defaultManager];
                    [fileManager removeItemAtURL:[DWDownloadMusic getURLByExtension:@"jpg" WithSongId:music.songId] error:nil];
                    
                    [fileManager removeItemAtURL:[DWDownloadMusic getURLByExtension:@"lrc" WithSongId:music.songId] error:nil];
                    [fileManager removeItemAtURL:[DWDownloadMusic getURLByExtension:@"mp3" WithSongId:music.songId] error:nil];//只判断歌曲是否删除就好，以防止该歌曲没有歌词或图片
                }
            }
            for (int i = 0; i<index; i++) {
                [data removeObjectAtIndex:indexs[i]];
            }
            for (NSDictionary *d in data)//删除文件后剩余的数据写会plist文件
            {
                DWMusic *music = [DWMusic mj_objectWithKeyValues:d];
                [DWDownloadMusic writeToPlist:music];
            }
        }
    }

}
+(void)deleteMusicWith:(NSArray *)musics
{
    
    for (DWMusic *m in musics) {
        if ([DWDownloadMusic isExistSongWithSongId:m.songId])//文件存在才删除
        {
            NSArray *arr = [DWDownloadMusic readFileFromPlist];
            NSMutableArray *data = [NSMutableArray arrayWithArray:arr];
            int indexs[data.count];
            int index = 0;
            for (int i = 0; i < data.count; i++) {
                DWMusic *music = [data objectAtIndex:i];
                if ([m.songId isEqualToString:music.songId]) {
                    indexs[index] = i;
                    index ++;
                    //搜索文件本地文件，并且删除,plist文件也一并删除
                    BOOL isDeleted = NO;
                    NSFileManager *fileManager = [NSFileManager defaultManager];
                    //读取plist
                    NSString *plistPath = [[DWDownloadMusic createPlistFile] stringByAppendingPathComponent:@"music.plist"];
                    [fileManager removeItemAtPath:plistPath error:nil];
                    [fileManager removeItemAtURL:[DWDownloadMusic getURLByExtension:@"jpg" WithSongId:music.songId] error:nil];
                   
                    [fileManager removeItemAtURL:[DWDownloadMusic getURLByExtension:@"lrc" WithSongId:music.songId] error:nil];
                    if ([fileManager removeItemAtURL:[DWDownloadMusic getURLByExtension:@"mp3" WithSongId:music.songId] error:nil])//只判断歌曲是否删除就好，以防止该歌曲没有歌词或图片
                    {
                        isDeleted = YES;
                    }
                    if (isDeleted == NO) {
                        [MBProgressHUD showError:@"删除失败!"];
                    }
                }
            }
            for (int i = 0; i<index; i++) {
                [data removeObjectAtIndex:indexs[i]];
                [MBProgressHUD showError:@"删除成功!"];
            }
            for (NSDictionary *d in data)//删除文件后剩余的数据写会plist文件
            {
                DWMusic *music = [DWMusic mj_objectWithKeyValues:d];
                [DWDownloadMusic writeToPlist:music];
            }
        }
        else
        {
            [MBProgressHUD showError:@"文件不存在!"];
        }
    }
    
}
+(NSURL *)getURLByExtension:(NSString *)extension WithSongId:(NSString *)songId
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSURL *url = [[manager URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] firstObject];
    NSString *extensionPath = [[@"musics" stringByAppendingPathComponent:songId] stringByAppendingPathExtension:extension];
    return [url URLByAppendingPathComponent:extensionPath];
}
@end

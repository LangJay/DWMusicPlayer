//
//  DWBoFangViewController.m
//  逗我
//
//  Created by 周继良 on 15/11/25.
//  Copyright © 2015年 周继良. All rights reserved.
//

#import "DWBoFangViewController.h"
#import "DWSongViewModel.h"
#import "DWMusic.h"
#import "DOUAudioStreamer.h"
#import <AVFoundation/AVFoundation.h>
#import "DWAudioFile.h"
#import "MBProgressHUD+MJ.h"
#import "DWPlayMusic.h"
#import "DWLrcLine.h"
#import "DWDownloadMusic.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface DWBoFangViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *beginTime;
@property (weak, nonatomic) IBOutlet UIImageView *picPremium;
@property (weak, nonatomic) IBOutlet UISlider *sliderView;

@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) DOUAudioStreamer *player;
@property (nonatomic, strong) DWAudioFile *audioFile;
@property (nonatomic, strong) NSTimer *timer;
@property (assign,nonatomic)NSInteger currentLrcIndex;
@property (nonatomic, strong) DWSongModel *songM;
@property (nonatomic, strong) NSArray *lrcStringArr;

@end

@implementation DWBoFangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.sliderView setThumbImage:[UIImage imageNamed:@"thumb.png"] forState:UIControlStateNormal];
    [self.sliderView trackRectForBounds:CGRectMake(0, 0, 0, 0)];
}
-(void)startTimer
{
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer bk_scheduledTimerWithTimeInterval:0.1 block:^(NSTimer *timer) {
        self.endTime.text = [self stringByTime:self.player.duration];
        if (self.lrcStringArr.count != 0) {
           [self scrollLrc];
        }
        if (self.player.status == DOUAudioStreamerError) {
            [MBProgressHUD showError:@"出错啦!"];
            [self.timer invalidate];
            self.timer = nil;
            return ;
        }
        if (self.player.currentTime) {
            if (self.player.status == DOUAudioStreamerPlaying) {
                self.playBtn.selected = NO;
            }
            else
            {
                self.playBtn.selected = YES;
            }
            NSInteger currentTime = self.player.currentTime;
            self.beginTime.text = [self stringByTime:self.player.currentTime];
            NSInteger duration = self.player.duration;
            CGFloat progress = currentTime / (duration *1.0);
            self.sliderView.value = progress;
            if (self.sliderView.value >= 1) {
                self.sliderView.value = 0.0;
            }
        }
        if (self.player.status == DOUAudioStreamerFinished)
        {
            self.index ++;
            if (self.index < self.songLists.count)
            {
                [self endLrcTimer];
                [self startPlayMusicWith:self.index];
            }
            else
            {
                self.index = 0;
                [self endLrcTimer];
                [self startPlayMusicWith:self.index];
            }
        }
    } repeats:YES];
}
-(void)endLrcTimer
{
    [self.timer invalidate];
    self.timer = nil;
}
-(void)scrollLrc
{
    
    int min = self.player.currentTime / 60;
    int sec = (int)self.player.currentTime % 60;
    int msec = (self.player.currentTime - (int)self.player.currentTime)*100;//毫秒
    for (NSInteger idx = 0; idx < self.lrcStringArr.count - 1; idx ++) {
        DWLrcLine *lrcline = self.lrcStringArr[idx];
        DWLrcLine *nextLine = self.lrcStringArr[idx + 1];
        NSString *currenTimeStr = [NSString stringWithFormat:@"%02d:%02d.%02d",min,sec,msec];
        if ([currenTimeStr compare:lrcline.time] == NSOrderedDescending && [currenTimeStr compare:nextLine.time] == NSOrderedAscending && self.currentLrcIndex != idx) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:idx inSection:0];
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:path];
            [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
            cell.textLabel.textColor = [UIColor whiteColor];
            self.currentLrcIndex = idx;
            
            //把歌词返回原来颜色
            if (idx > 1) {
                path = [NSIndexPath indexPathForRow:idx - 1 inSection:0];
                cell = [self.tableView cellForRowAtIndexPath:path];
                [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                cell.textLabel.textColor = [UIColor lightGrayColor];
            }
            
        }
        
    }
}

-(NSString *)stringByTime:(NSTimeInterval)time
{
    int min = time / 60;
    int sec = (int)time % 60;
    return [NSString stringWithFormat:@"%02d:%02d",min,sec];
}
#pragma mark - 按钮
- (IBAction)back:(UIButton *)sender
{
    CGRect startFrame = self.view.frame;
    CGRect  endFrame= startFrame;
    endFrame.origin.y = endFrame.size.height;
    self.view.frame = endFrame;
    [UIView animateWithDuration:1.0 animations:^{
        self.view.frame = endFrame;
    }];
}
- (IBAction)moreBtn:(UIButton *)sender {
    if (self.picPremium.hidden) {
        self.picPremium.hidden = NO;
    }
    else
    {
        self.picPremium.hidden = YES;
    }
}
- (IBAction)frontBtn:(UIButton *)sender
{
    self.index --;
    if (self.index >= 0)
    {
        [self startPlayMusicWith:self.index];
    }
    else
    {
        self.index = self.songLists.count - 1;
        [self startPlayMusicWith:self.index];
    }
}
- (IBAction)playBtn:(UIButton *)sender {
    self.playBtn.selected = -self.playBtn.selected;
    if (self.playBtn.selected) {
        [self.player play];
        [self startTimer];
    }
    else
    {
        [self.player pause];
    }
}
- (IBAction)nextBtn:(UIButton *)sender
{
    self.index ++;
    if (self.index < self.songLists.count)
    {
        [self startPlayMusicWith:self.index];
    }
    else
    {
        self.index = 0;
        [self startPlayMusicWith:self.index];
    }
}
- (IBAction)sliderValueChanged:(UISlider *)sender {
    self.player.currentTime = sender.value * self.player.duration * 1.0;
}

- (IBAction)suiJiBtn:(UIButton *)sender {
    NSInteger index = (arc4random() % self.index) + 1;
    [self startPlayMusicWith:index];
}
- (IBAction)xiaZaiBtn:(UIButton *)sender {
    DWMusic *music = [DWMusic new];
    DWPlayMusic *pMusic = self.songLists[self.index];
    music = [self changeMusicOfURLtoMusicOfString:pMusic];
    NSMutableArray *mArr = [NSMutableArray new];
    [mArr addObject:music];
    [DWDownloadMusic downloadMusicsWith:mArr];
}
-(DWMusic *)changeMusicOfURLtoMusicOfString:(DWPlayMusic *)pMusic
{
    DWMusic *music = [DWMusic new];
    music.title = pMusic.title;
    music.author = pMusic.author;
    music.songId = pMusic.songId;
    music.pic = pMusic.pic.absoluteString;
    music.lrcname = pMusic.lrcname.absoluteString;
    music.songurl = pMusic.songurl.absoluteString;
    music.showLink = pMusic.showLink.absoluteString;
    return music;
}
- (IBAction)fenXiangBtn:(UIButton *)sender {
    DWPlayMusic *pMusic = self.songLists[self.index];
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"DWbig.png"]];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:pMusic.author
                                         images:imageArray
                                            url:pMusic.showLink
                                          title:pMusic.title
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"失败原因：%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                       
                   }];
        
    }

}
- (IBAction)shanChuBtn:(UIButton *)sender {
    //先将播放器停止
    [self.player stop];
    NSMutableArray *musics = [NSMutableArray new];
    
    [musics addObject:[self changeMusicOfURLtoMusicOfString:self.songLists[self.index]]];
    [DWDownloadMusic deleteMusicWith:musics];
    //发送通知，让本地列表刷新
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:nil];
    //播放下一首
    self.index ++;
    if (self.index < self.songLists.count)
    {
        [self startPlayMusicWith:self.index];
    }
    else
    {
        self.index = 0;
        [self startPlayMusicWith:self.index];
    }
}

-(void)startPlayMusicWith:(NSInteger)index
{
    self.currentLrcIndex = 0;
    DWPlayMusic *music = self.songLists[index];
    [self.picPremium sd_setImageWithURL:music.pic];
    self.titleLabel.text = music.title;
    self.authorLabel.text = music.author;
    self.sliderView.value = 0;
    NSURL *lrcURL = music.lrcname;
    NSString *lrcString = [NSString stringWithContentsOfURL:lrcURL encoding:NSUTF8StringEncoding error:nil];
    self.lrcStringArr = nil;
    self.lrcStringArr = [self getLinelrc:lrcString];
    if (self.lrcStringArr.count == 0) {
        [MBProgressHUD showError:@"没有匹配的歌词!"];
    }
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    self.audioFile = [DWAudioFile new];
    self.audioFile.audioFileURL = music.songurl;
    self.player = [DOUAudioStreamer streamerWithAudioFile:self.audioFile];
    [self.player play];
    [self.tableView reloadData];
    [self startTimer];
}
-(void)show
{
    //拿window对象
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //将此VC中的view添加到window对象中
    self.view.frame = window.bounds;
    [window addSubview:self.view];
    //用动画的方式将view显示出来
    CGRect endFrame = self.view.frame;
    CGRect startFrame = endFrame;
    startFrame.origin.y = startFrame.size.height;
    self.view.frame = startFrame;
    [UIView animateWithDuration:1.0 animations:^{
        self.view.frame = endFrame;
    }];
    [self startPlayMusicWith:self.index];
}
-(void)pushViewFromView
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    NSInteger index = [window subviews].count - 1;
    UIView *view = [[window subviews] objectAtIndex:index];
    CGRect startFrame = view.frame;
    startFrame.origin.y = 0;
    [UIView animateWithDuration:1.0 animations:^{
        view.frame = startFrame;
    }];
}

- (DWSongModel *)songM {
	if(_songM == nil) {
		_songM = [[DWSongModel alloc] init];
	}
	return _songM;
}
#pragma mark - tableView数据源代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lrcStringArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //先尝试着按照定好的标识去队列中取，看有没有可重用的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bofangCell"];
    // 如果没有取到可重用的，则新建
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bofangCell"];
    }
    DWLrcLine *line = self.lrcStringArr[indexPath.row];
    cell.textLabel.text = line.word;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(NSArray *)getLinelrc:(NSString *)lrcString
{
    NSArray *lrcs = [lrcString componentsSeparatedByString:@"\n"];//字符串切成数组
    NSMutableArray *lrclines = [NSMutableArray new];
    for (NSString *line in lrcs)
    {
        if (![line hasPrefix:@"["])//不含“［”则继续
        {
            continue;
        }
        if ([line hasPrefix:@"[ti:"] || [line hasPrefix:@"ar:"] || [line hasPrefix:@"[al:"] || [line hasPrefix:@"[_time:"])//含有这些信息则继续
        {
            continue;
        }
        else
        {
            NSArray *arr = [line componentsSeparatedByString:@"]"];//将”[02:40.64][01:55.90][00:52.41]爱情不只玫瑰花 “切割
            for (int i = 0; i < arr.count - 1; i++)//一句歌词三个时间，按时间都加进数组
            {
                DWLrcLine *lrcline = [DWLrcLine new];
                lrcline.time =[arr[i] substringFromIndex:1];
                lrcline.word  = [arr lastObject];
                [lrclines addObject:lrcline];
            }
        }
    }
    //将歌词排序
    for (int i =0 ; i < lrclines.count; i++) {
        for (int j = i; j< lrclines.count; j++) {
            DWLrcLine *l1 = lrclines[i];
            DWLrcLine *l2 = lrclines[j];
            if ([l1.time compare:l2.time] == NSOrderedDescending)//l1>l2
            {
                [lrclines replaceObjectAtIndex:i withObject:l2];
                [lrclines replaceObjectAtIndex:j withObject:l1];
            }
        }
        
    }
    return lrclines;
}

- (NSArray *)lrcStringArr {
	if(_lrcStringArr == nil) {
		_lrcStringArr = [[NSArray alloc] init];
	}
	return _lrcStringArr;
}

@end

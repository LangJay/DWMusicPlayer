//
//  DwWebViewViewController.m
//  DWMusicPlayer
//
//  Created by 周继良 on 16/3/12.
//  Copyright © 2016年 周继良. All rights reserved.
//

#import "DwWebViewViewController.h"

@interface DwWebViewViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityInd;

@end

@implementation DwWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.scalesPageToFit = YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadWebPageWithString:self.url];
}
- (void)loadWebPageWithString:(NSString*)urlString
{
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityInd startAnimating] ;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityInd stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"获取失败！" message:[error localizedDescription]  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alterview show];
}

@end

//
//  UIImage+Circle.m
//  MusicPlayer
//
//  Created by 周继良 on 15/9/22.
//  Copyright © 2015年 zhoujiliang. All rights reserved.
//

#import "UIImage+Circle.h"

@implementation UIImage (Circle)
+(UIImage *)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderwidth borderColor:(UIColor *)borderColor
{
    //开启上下文
    UIImage *sourceImage = [UIImage imageNamed:name];
   return [self circleImageWithImage:sourceImage borderWidth:borderwidth borderColor:borderColor];
}
+(UIImage *)circleImageWithImage:(UIImage *)sourceImage borderWidth:(CGFloat)borderwidth borderColor:(UIColor *)borderColor
{
    //开启上下文
   // UIImage *sourceImage = [UIImage imageNamed:name];
    CGFloat imageWidth = sourceImage.size.width +2 * borderwidth;
    CGFloat imageHeight = sourceImage.size.height + 2 * borderwidth;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWidth, imageHeight), NO, 0);
    //获取上下文
    UIGraphicsGetCurrentContext();
    //画圆
    CGFloat radius = sourceImage.size.width < sourceImage.size.height ? sourceImage.size.width * 0.5 : sourceImage.size.height * 0.5;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(imageWidth * 0.5,imageHeight * 0.5) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    bezierPath.lineWidth = borderwidth;
    [borderColor setStroke];
    [bezierPath stroke];
    //使用BezierPath进行剪切
    [bezierPath addClip];
    //画图
    [sourceImage drawInRect:CGRectMake(borderwidth, borderwidth, sourceImage.size.width, sourceImage.size.height)];
    //从内存中创建新图片对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //结束上下文
    UIGraphicsEndImageContext();
    return newImage;
}
+(UIImage *)scaleTosize:(UIImage *)image size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end

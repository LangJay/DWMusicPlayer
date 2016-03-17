//
//  UIImage+Circle.h
//  MusicPlayer
//
//  Created by 周继良 on 15/9/22.
//  Copyright © 2015年 zhoujiliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Circle)
/**
 *根据指定图片的文件获取一张圆形的图片对象，并加边框
 *@param name 图片文件名
 *@param borderWidth 边框的宽
 *@param borderColor 边框的颜色
 *@return 切好的圆形图片
 **/
+(UIImage *)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderwidth borderColor:(UIColor *)borderColor;
+(UIImage *)circleImageWithImage:(UIImage *)sourceImage borderWidth:(CGFloat)borderwidth borderColor:(UIColor *)borderColor;
/**
 *将一张图片变成指定的大小
 *@param image 原图片
 *@param size指定大小
 *@return 指定大小的图片
 **/
+(UIImage *)scaleTosize:(UIImage *)image size:(CGSize)size;
@end

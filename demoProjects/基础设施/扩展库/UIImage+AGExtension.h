//
//  UIImage+ImageUtil.h
//  AppGame
//
//  Created by 姚东海 on 1/8/14.
//  Copyright (c) 2014年 计 炜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMedia/CoreMedia.h>

@class TVBPostModel;


@interface UIImage (AGExtension)
/**
 *  颜色生成图片
 *
 *  @param color 颜色
 *  @param size  大小
 *
 *  @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size scale:(CGFloat)scale;
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size radius:(CGFloat)radius scale:(CGFloat)scale;
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size radius:(CGFloat)radius;
+ (UIImage *)horizontalGradientImageFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor size:(CGSize)size;
+ (UIImage *)verticalGradientImageWithColors:(NSArray *)colors size:(CGSize)size;
+ (UIImage *)verticalGradientImageFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor size:(CGSize)size;
+ (UIImage *)verticalGradientImageWithColors:(NSArray *)colors locations:(NSArray *)locations size:(CGSize)size;
+ (UIImage *)horizontalGradientImageWithColors:(NSArray *)colors size:(CGSize)size;
- (UIImage *)coverWithImage:(UIImage *)image;
- (UIImage *)coverWithDefautlColor;
+ (UIImage *)wireframeWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;
+ (UIImage *)wireframeWithColor:(UIColor *)color size:(CGSize)size lineWith:(CGFloat)lineWith cornerRadius:(CGFloat)cornerRadius;
- (UIImage *)imageWithRoundedSize:(CGSize)size;
- (UIImage *)imageWithRoundedSize:(CGSize)size borderWidth:(CGFloat)borderWidth;
- (UIImage *)imageWithRoundedWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
- (UIImage *)imageWithRadius:(CGFloat)cornerRadius withBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

- (UIImage *)imageWithRounded;
- (UIImage *)imageWithRadius:(CGFloat )radius;
- (UIImage *)imageWithCornerRadius:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;
+ (UIImage *)imageFromCahcheWithURL:(NSURL *)URL size:(CGSize)size borderWidth:(CGFloat)borderWidth;
- (UIImage *)imageWithRoundedWithBorderWidth:(CGFloat)borderWidth;
- (UIImage *)imageWithCornerRadius:(CGFloat)radius;
- (UIImage *)imageWithCropRect:(CGRect)cropRect;
- (UIImage *)imageToOrientationUp;
+ (UIImage *)imageFromCahcheWithURL:(NSURL *)URL size:(CGSize)size;
+ (void)cacheImage:(UIImage *)image URL:(NSURL *)URL size:(CGSize)size;
+ (void)cacheImage:(UIImage *)image URL:(NSURL *)URL size:(CGSize)size borderWidth:(CGFloat)borderWidth;
- (UIImage *)imageWithOriginalRenderingMode;
- (UIImage *)imageWithTemplateRenderingMode;
+ (UIImage *)stretchableImageWithImageName:(NSString *)imageName LeftCapWidth:(float)w topCapHeight:(float)h;
//大图缩放，优化内存
+ (UIImage *)scaledImageWithData:(NSData *)data withSize:(CGSize)size scale:(CGFloat)scale orientation:(UIImageOrientation)orientation;

+ (UIImage *)drawImaginaryLineViewWithImageview:(UIImageView *)imageview;

+ (UIImage *)imageWithSampleBuffer:(CMSampleBufferRef)sampleBuffer;

- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor;
- (NSString *)ag_toJPEGBase64;
+ (UIImage *)joinImages:(NSArray *)images;
- (UIImage *)imageRotateInRadians:(CGFloat)radians scale:(CGFloat)scale;
- (UIColor *)colorAtPoint:(CGPoint)point;

- (UIImage *)transformtoSize:(CGSize)Newsize;

// 图片颜色转换
- (UIImage *)imageConvertColorWithColor:(UIColor*)color;

//截图
+ (UIImage *)screenshotWithView:(UIView *)screenshotView;
+ (UIImage *)screenshotHierarchyWithView:(UIView *)screenshotView;
//UIView转UIIamge
+ (UIImage *)captureImgWhenViewIsGPUImageView:(UIView *)view;

//生成二维码
+ (UIImage *)encodeQRImageWithContent:(NSString *)content size:(CGSize)size;

// 缺省图
+ (UIImage *)tvb_PlaceholderImage;
//
+ (UIImage *)tvb_PlaceholderLoadingImage;
+ (UIImage *)tvb_AvatarholderImage;

+ (UIImage *)tvb_nobilityholderImage;

//黄色 缺省头像
+ (UIImage *)tvb_YellowAvatarholderImage;

// image转换为NSData，比较通用
+ (NSData *)imageToData:(UIImage *)image;
// 返回图片类型
+ (NSString *)typeForImageData:(NSData *)data;

/**
 *  自适应居中裁剪
 *
 *  @param size          容器大小
 *
 *  @return 修改后的图
 */
- (UIImage *)clipCenterWithSize:(CGSize)size;

/**
 *  自适应底部裁剪
 *
 *  @param size          容器大小
 *
 *  @return 修改后的图
 */
- (UIImage *)clipBottomWithSize:(CGSize)size topScale:(CGFloat)topScale;

- (UIImage*)addTopImage:(UIImage*)topImage bottomImage:(UIImage*)bottomImage;

- (UIImage*)mergeImage:(UIImage*)topImage bottomImage:(UIImage*)bottomImage;

// 设置黑白色
+ (UIImage *)grayImage:(UIImage *)image;
// 切圆
+ (UIImage *)clipCircleImage:(UIImage *)image;

//生成二维码
+ (UIImage *)generateQRCodeWithString:(NSString *)string Size:(CGFloat)size;

//截图
+ (UIImage *)screenshotViewWithView:(UIView *)view;

//加载图片（无缓存）
+ (UIImage *)tvb_imageWithContentsOfFileWithImageName:(NSString *)imageName;

@end

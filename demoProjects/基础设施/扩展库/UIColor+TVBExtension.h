//
//  UIColor+TVBExtension.h
//  TVBCLive
//
//  Created by Wyman on 2018/3/20.
//  Copyright © 2018年 TVBC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (TVBExtension)

+ (UIColor *)R:(NSInteger)r G:(NSInteger)g B:(NSInteger)b A:(NSInteger)a;
+ (UIColor *)R:(NSInteger)r G:(NSInteger)g B:(NSInteger)b;
+ (UIColor *)HEX:(NSInteger)hex;
+ (UIColor *)randomColor;
/**
 字符串装颜色 支持六位或者八位
 @param colorString FF0FAB or FFFF0FAB
 @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

//判断是不是深色
- (BOOL)isDarkModeColor;

//颜色过度转化 coe系数：0～1
+ (UIColor *)pm_compositeFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor coe:(CGFloat)coe;

/// 字符色值转换为颜色数组
/// @param hexString 字符色值
+ (NSArray <UIColor *>*)colorArrayFromHexString:(NSString *)hexString;

/// 字符色值数组转换为颜色数组
/// @param hexStringArray 字符色值数组
+ (NSArray <UIColor *>*)colorArrayFormHexStringArray:(NSArray <NSString *>*)hexStringArray;

/// 默认文案-字符色值数组转换为颜色数组
/// @param hexStringArray 字符色值数组
+ (NSArray <UIColor *>*)placeholderColorArrayFormHexStringArray:(NSArray <NSString *>*)hexStringArray;

/// 渐变颜色
/// @param colors
/// @param frame 
+ (UIColor *)imageColorLayerFormColors:(NSArray *)colors frame:(CGRect)frame;

/// 渐变颜色图片
/// @param colors colors
/// @param cornerRadius cornerRadius
/// @param frame frame
+ (UIImage *)imageColorLayerFormColors:(NSArray *)colors cornerRadius:(CGFloat)cornerRadius frame:(CGRect)frame;

@end

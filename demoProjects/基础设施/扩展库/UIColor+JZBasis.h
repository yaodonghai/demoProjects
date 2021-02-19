//
//  UIColor+JZBasis.h
//  乐迹
//
//  Created by 李国明 on 2017/8/15.
//  Copyright © 2017年 小O. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIColor (JZBasis)

+ (UIColor *)colorForHex:(NSInteger)rgbHex;

+ (UIColor *)colorForHex:(NSInteger)rgbHex alpha:(CGFloat)alpha;
//支持多种字符串转换成颜色
+ (nullable UIColor *)colorForString:(NSString *)string;

@end
NS_ASSUME_NONNULL_END

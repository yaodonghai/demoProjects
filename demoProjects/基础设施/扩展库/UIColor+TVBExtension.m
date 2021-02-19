//
//  UIColor+TVBExtension.m
//  TVBCLive
//
//  Created by Wyman on 2018/3/20.
//  Copyright © 2018年 TVBC. All rights reserved.
//

#import "UIColor+TVBExtension.h"
#import "UIColor+JZBasis.h"

@implementation UIColor (TVBExtension)



+ (UIColor *)R:(NSInteger)r G:(NSInteger)g B:(NSInteger)b A:(NSInteger)a{
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a / 255.0f];
}

+ (UIColor *)R:(NSInteger)r G:(NSInteger)g B:(NSInteger)b{
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1];
}

+ (UIColor *)HEX:(NSInteger)hex{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1];
}

+ (UIColor *)randomColor{
    return [self R:arc4random() % 255 G:arc4random() % 255 B:arc4random() % 255];
}


/**
 字符串装颜色
 @param colorString FF0FAB
 @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString {
    //格式不正确返回透明
    if (hexString.length < 6) {
        return [UIColor clearColor];
    }
    //如果hexString 有@"0x"前缀
    if ([hexString hasPrefix:@"0x"]) {
        hexString = [hexString substringFromIndex:2];
    }
    //如果hexString 有@"#""前缀
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    unsigned int r = 0, g = 0, b = 0, a = 0;
    if (hexString.length == 6) {
        //R、G、B
        NSString *rString = [hexString substringWithRange:range];
        range.location = 2;
        NSString *gString = [hexString substringWithRange:range];
        range.location = 4;
        NSString *bString = [hexString substringWithRange:range];
        
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        a = 0xff;
        return [UIColor R:r G:g B:b A:a];
    } else if (hexString.length == 8) {
        //R、G、B、A
        NSString *aString = [hexString substringWithRange:range];
        range.location = 2;
        NSString *rString = [hexString substringWithRange:range];
        range.location = 4;
        NSString *gString = [hexString substringWithRange:range];
        range.location = 6;
        NSString *bString = [hexString substringWithRange:range];
        
        [[NSScanner scannerWithString:aString] scanHexInt:&a];
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        return [UIColor R:r G:g B:b A:a];
    } else {
        unsigned int outVal = 0;
        NSScanner *scanner = [NSScanner scannerWithString:hexString];
        [scanner scanHexInt:&outVal];
        UIColor *color = outVal? [UIColor HEX:outVal]: [UIColor HEX:0xd4dbe1];
        return color;
    }
}

//判断是不是深色
- (BOOL)isDarkModeColor
{
    CGFloat r = 0;
    CGFloat g = 0;
    CGFloat b = 0;
    CGFloat a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    
    r*=255;
    g*=255;
    b*=255;
    
    if(r*0.299 + g*0.578 + b*0.114 >= 192){ //浅色
        return NO;
    }else{  //深色
        return YES;
    }
}

+ (UIColor *)pm_compositeFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor coe:(CGFloat)coe
{
    NSArray<NSNumber *> *fromRPGA = [fromColor pm_getRPGA];
    NSArray<NSNumber *> *toRPGA = [toColor pm_getRPGA];
    NSArray<NSNumber *> *diff = @[@(toRPGA[0].floatValue - fromRPGA[0].floatValue),
                                  @(toRPGA[1].floatValue - fromRPGA[1].floatValue),
                                  @(toRPGA[2].floatValue - fromRPGA[2].floatValue),
                                  @(toRPGA[3].floatValue - fromRPGA[3].floatValue)];
    NSArray<NSNumber *> *offset = @[@(diff[0].floatValue * coe),
                                    @(diff[1].floatValue * coe),
                                    @(diff[2].floatValue * coe),
                                    @(diff[3].floatValue * coe)];
    NSArray<NSNumber *> *result = @[@(fromRPGA[0].floatValue + offset[0].floatValue),
                                    @(fromRPGA[1].floatValue + offset[1].floatValue),
                                    @(fromRPGA[2].floatValue + offset[2].floatValue),
                                    @(fromRPGA[3].floatValue + offset[3].floatValue)];
    
    return [UIColor colorWithRed:result[0].floatValue
                           green:result[1].floatValue
                            blue:result[2].floatValue
                           alpha:result[3].floatValue];
}

- (NSArray<NSNumber *> *)pm_getRPGA
{
    CGFloat r=0,g=0,b=0,a=0;
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self getRed:&r green:&g blue:&b alpha:&a];
    } else {
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    }
    return @[@(r),@(g),@(b),@(a)];
}

+ (NSArray <UIColor *>*)colorArrayFromHexString:(NSString *)hexString {
    NSArray *colorHexStrings = [hexString componentsSeparatedByString:@","];
    NSMutableArray *colorArray = [NSMutableArray array];
    for (NSString *colorHexString in colorHexStrings) {
        [colorArray addObject:(id)[UIColor colorForString:colorHexString].CGColor];
        if(colorHexStrings.count == 1) {
            [colorArray addObject:(id)[UIColor colorForString:colorHexString].CGColor];
        }
    }
    if (colorArray.count == 0) {
        [colorArray addObject:(id)[UIColor whiteColor].CGColor];
    }
    return colorArray;
}

+ (NSArray <UIColor *>*)colorArrayFormHexStringArray:(NSArray <NSString *>*)hexStringArray {
      NSMutableArray *colorArray = [NSMutableArray array];
      for (NSString *colorHexString in hexStringArray) {
          [colorArray addObject:(id)[UIColor colorForString:colorHexString].CGColor];
      }
    if (colorArray.count == 0) {
        [colorArray addObject:(id)[UIColor whiteColor].CGColor];
    }
      return colorArray;
}

+ (NSArray <UIColor *>*)placeholderColorArrayFormHexStringArray:(NSArray <NSString *>*)hexStringArray {
    NSMutableArray *colorArray = [NSMutableArray array];
    for (NSString *colorHexString in hexStringArray) {
        [colorArray addObject:(id)[[UIColor colorForString:colorHexString] colorWithAlphaComponent:0.6f].CGColor];
    }
    if (colorArray.count == 0) {
        [colorArray addObject:(id)[[UIColor whiteColor] colorWithAlphaComponent:0.6f].CGColor];
    }
    return colorArray;
}

+ (UIColor *)imageColorLayerFormColors:(NSArray *)colors frame:(CGRect)frame {
    //均等分颜色间隔，不均等分只有自己做了
    CGFloat interval = 1.0f/(CGFloat)(colors.count-1);
    NSMutableArray *loactions = [NSMutableArray arrayWithCapacity:colors.count];
    for (int i = 0; i < colors.count; i++) {
        [loactions addObject:[NSNumber numberWithFloat:(i*interval)]];
    }
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = frame;
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 0);
    gradient.locations = loactions;
    gradient.colors = colors;
    
    UIGraphicsBeginImageContextWithOptions(gradient.bounds.size, NO, 0);
    [gradient renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:outputImage];
}

+ (UIImage *)imageColorLayerFormColors:(NSArray *)colors cornerRadius:(CGFloat)cornerRadius frame:(CGRect)frame {
    //均等分颜色间隔，不均等分只有自己做了
    CGFloat interval = 1.0f/(CGFloat)(colors.count-1);
    NSMutableArray *loactions = [NSMutableArray arrayWithCapacity:colors.count];
    for (int i = 0; i < colors.count; i++) {
        [loactions addObject:[NSNumber numberWithFloat:(i*interval)]];
    }
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = frame;
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 0);
    gradient.locations = loactions;
    gradient.cornerRadius = cornerRadius;
    gradient.colors = colors;
    
    UIGraphicsBeginImageContextWithOptions(gradient.bounds.size, NO, 0);
    [gradient renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}

@end

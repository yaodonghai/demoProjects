//
//  DEUtilities.m
//  demoProjects
//
//  Created by 姚东海 on 2021/2/19.
//

#import "DEUtilities.h"
#import <Foundation/Foundation.h>

@implementation DEUtilities


+ (CGFloat)portraitScreenWidth {
    return CGRectGetWidth([UIScreen mainScreen].nativeBounds) / [UIScreen mainScreen].nativeScale;
}

+ (CGFloat)portraitScreenHeight {
    return CGRectGetHeight([UIScreen mainScreen].nativeBounds) / [UIScreen mainScreen].nativeScale;
}


@end

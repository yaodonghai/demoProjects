//
//  NSDictionary+JZBasis.h
//  一点心意
//
//  Created by 小O on 2017/6/12.
//  Copyright © 2017年 小O. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSDictionary (JZBasis)
//安全类型访问
- (NSInteger)integerValueForKey:(id)key;
- (int)intValueForKey:(id)key;
- (BOOL)boolValueForKey:(id)key;
- (float)floatValueForKey:(id)key;
- (NSString *)stringValueForKey:(id)key;
- (NSArray *)arrayValueForKey:(id)key;
- (NSMutableArray *)mutableArrayValueForKey:(NSString *)key;
- (NSDictionary *)dictionaryValueForKey:(id)key;

- (NSDictionary* )parseHTML;
- (NSDictionary *)urlEncoded;
//转换成JSON
- (nullable NSString *)jsonString;

@end
NS_ASSUME_NONNULL_END

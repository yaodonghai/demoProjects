//
//  NSDictionary+JZBasis.m
//  一点心意
//
//  Created by 小O on 2017/6/12.
//  Copyright © 2017年 小O. All rights reserved.
//

#import "NSDictionary+JZBasis.h"

@implementation NSDictionary (JZBasis)

- (NSInteger)integerValueForKey:(id)key {
    id value = [self notNullValueForKey:key];
    return value == nil ? 0 : [value integerValue];
}

- (int)intValueForKey:(id)key {
    id value = [self notNullValueForKey:key];
    return value == nil ? 0 : [value intValue];
}

- (BOOL)boolValueForKey:(id)key {
    id value = [self notNullValueForKey:key];
    return value == nil ? NO : [value boolValue];
}

- (float)floatValueForKey:(id)key {
    id value = [self notNullValueForKey:key];
    return value == nil ? NO : [value floatValue];
}

- (NSString *)stringValueForKey:(id)key {
    id value = [self notNullValueForKey:key];
    if([value isKindOfClass:[NSString class]]) {
        return value;
    }
    else if ([value isKindOfClass:[NSNumber class]]){
        return [NSString stringWithFormat:@"%@",value];
    }
    return [NSString string];
}

- (NSArray *)arrayValueForKey:(id)key {
    id value = [self notNullValueForKey:key];
    if(![value isKindOfClass:[NSArray class]]) {
        return [NSArray array];
    }
    return value;
}

- (NSMutableArray*)mutableArrayValueForKey:(NSString *)key {
    id value = [self notNullValueForKey:key];
    if(![value isKindOfClass:[NSMutableArray class]]) {
        return [NSMutableArray array];
    }
    return value;
}

- (NSDictionary *)dictionaryValueForKey:(id)key {
    id value = [self notNullValueForKey:key];
    if(![value isKindOfClass:[NSDictionary class]]) {
        return [NSDictionary dictionary];
    }
    return value;
}

- (BOOL)isNullValue:(id)value {
    return [value isEqual:[NSNull null]];
}

- (id)notNullValueForKey:(id)key {
    id value = [self objectForKey:key];
    if([self isNullValue:value]) {
        return nil;
    }
    return value;
}

- (NSDictionary* )parseHTML {
    NSMutableDictionary* resultDic = [[NSMutableDictionary alloc] init];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if([obj respondsToSelector:@selector(parseHTML)]) {
            id obj2 = [obj parseHTML];
            [resultDic setObject:obj2 forKey:key];
        } else {
            [resultDic setObject:obj forKey:key];
        }
    }];
    return resultDic;
}

- (NSDictionary *)urlEncoded {
    NSMutableDictionary* resultDic = [[NSMutableDictionary alloc] init];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if([obj respondsToSelector:@selector(urlEncoded)]) {
            [resultDic setObject:[obj urlEncoded] forKey:key];
        } else {
            [resultDic setObject:obj forKey:key];
        }
    }];
    return resultDic;
}

- (NSString *)jsonString
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end

//
//  ValidationVIN.m
//  Behavior
//
//  Created by cp316 on 17/3/1.
//  Copyright © 2017年 lanht. All rights reserved.
//

#import "ValidationVIN.h"

@implementation ValidationVIN

//LFMJ34AF9D3009402

+ (BOOL)validatVinWithCode:(NSString *)vinStr {
    if (vinStr.length != 17) {
        NSLog(@"vin码不足17位");
        return NO;
    }
    NSString *upStr = [vinStr uppercaseString];
    NSRange range = {0,1};
    NSString *firstCharactor = [upStr substringWithRange:range];
    BOOL isAllSame = YES;
    for (int i = 0; i< upStr.length; i++) {
        NSRange range = {i,1};
        NSString * subCharactor = [upStr substringWithRange:range];
        if (![firstCharactor isEqualToString:subCharactor]) {
            isAllSame = NO;
            break;
        }
    }
    if (isAllSame) {
        NSLog(@"vin码位数全部相同");
        return NO;
    }
    
    if ([vinStr containsString:@"O"] || [vinStr containsString:@"Q"] || [vinStr containsString:@"I"]) {
        NSLog(@"包含O，P，I,错误vin码");
        return NO;
    }
    NSMutableArray *codes = [NSMutableArray array];
    for (int i = 0; i<upStr.length; i++) {
        NSRange range = {i,1};
        NSInteger conv = [self conversion:[upStr substringWithRange:range]];
        [codes addObject:@(conv)];
    }
    return [self calculate:codes upStr:upStr];
}

+ (BOOL)calculate:(NSArray *)codeArray upStr:(NSString *)upStr {
    NSArray *coefficients = @[@(8),@(7),@(6),@(5),@(4),@(3),@(2),@(10),@(0),@(9),@(8),@(7),@(6),@(5),@(4),@(3),@(2)];
    NSInteger total = 0;
    for (int i = 0; i<codeArray.count; i++) {
        total += [codeArray[i] integerValue] * [coefficients[i] integerValue];
    }
    NSInteger remainder = total % 11;
    NSLog(@"余数为＝%zd",remainder);
    if (remainder == 10) {
        NSRange range = {8,1};
        if ([[upStr substringWithRange:range] isEqualToString:@"X"]) {
            return YES;
        }
        return NO;
    }
    return remainder == [codeArray[8] integerValue];
}

+ (NSInteger)conversion:(NSString *)code {
    NSString *str0 = @"0";
    NSString *str1 = @"1AJ";
    NSString *str2 = @"2BKS";
    NSString *str3 = @"3CLT";
    NSString *str4 = @"4DMU";
    NSString *str5 = @"5ENV";
    NSString *str6 = @"6FW";
    NSString *str7 = @"7GPX";
    NSString *str8 = @"8HY";
    NSString *str9 = @"9RZ";
    
    if ([str0 containsString:code]) {
        return 0;
    }
    if ([str1 containsString:code]) {
        return 1;
    }
    if ([str2 containsString:code]) {
        return 2;
    }
    if ([str3 containsString:code]) {
        return 3;
    }
    if ([str4 containsString:code]) {
        return 4;
    }
    if ([str5 containsString:code]) {
        return 5;
    }
    if ([str6 containsString:code]) {
        return 6;
    }
    if ([str7 containsString:code]) {
        return 7;
    }
    if ([str8 containsString:code]) {
        return 8;
    }
    if ([str9 containsString:code]) {
        return 9;
    }
    return NO;
}
@end

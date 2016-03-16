//
//  ViewController.m
//  异或加密
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 cheny. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#define StringWithData(data) [[NSString alloc] initWithData:(data) encoding:NSUTF8StringEncoding]
#define DataWithString(str) [(str) dataUsingEncoding:NSUTF8StringEncoding]

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *str = @"iOS-简单的异或加密";
    
    NSData *originalData = DataWithString(str);
    NSString *encryptStr = StringWithData([self encrypt:originalData]);
    
    NSData *encryData = DataWithString(encryptStr);
    NSString *decryptStr = StringWithData([self encrypt:encryData]);
    
    NSLog(@"原始值：%@", str);
    NSLog(@"加密后：%@", encryptStr);
    NSLog(@"解密后：%@", decryptStr);
}

- (NSData *)encrypt:(NSData *)data {
    char *dataP = (char *)[data bytes];
    for (int i = 0; i < data.length; i++) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunsequenced"
        *dataP = *(++dataP) ^ 1;
#pragma clang diagnostic pop
    }
    return data;
}

@end

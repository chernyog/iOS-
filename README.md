# iOS-异或加密

## 原理
对待加密数据的每个二进制字节，做异或操作（就是把原来的0变成1，1变成0），从而达到加密的目的。

## 简单实现
### 宏定义（形式上简化代码）
``` objc
#define StringWithData(data) [[NSString alloc] initWithData:(data) encoding:NSUTF8StringEncoding]
#define DataWithString(str) [(str) dataUsingEncoding:NSUTF8StringEncoding]
```
### 核心方法
``` objc
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
```
### 测试一下
``` objc
NSString *str = @"iOS-简单的异或加密";
    
NSData *originalData = DataWithString(str);
NSString *encryptStr = StringWithData([self encrypt:originalData]);

NSData *encryData = DataWithString(encryptStr);
NSString *decryptStr = StringWithData([self encrypt:encryData]);

NSLog(@"原始值：%@", str);
NSLog(@"加密后：%@", encryptStr);
NSLog(@"解密后：%@", decryptStr);

// 输出
2016-03-16 11:54:10.191 异或加密[5756:143913] 原始值：iOS-简单的异或加密
2016-03-16 11:54:10.192 异或加密[5756:143913] 加密后：iNR,毁䌔曅佃牗䋡䮇
2016-03-16 11:54:10.192 异或加密[5756:143913] 解密后：iOS-简单的异或加密
```
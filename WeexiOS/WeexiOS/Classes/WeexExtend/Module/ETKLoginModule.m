//
//  ETKLoginModule.m
//  WeexiOS
//
//  Created by FallenK on 2016/11/18.
//  Copyright © 2016年 KFallen. All rights reserved.
//

#import "ETKLoginModule.h"

@implementation ETKLoginModule

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(login:withParam:callBack:))

- (void)login:(NSString *)apiURL withParam:(NSDictionary *)params callBack:(WXModuleCallback)callBack {
    if (![params[@"phone"] isEqualToString:@"135"]) {
        NSLog(@"phone is not equalTo 135");
        return;
    }
    NSDictionary *dict = @{
                           @"ss":@"haha",
                           @"kk":@"yy"
                           };
    //NSLog(@"%@",dict[@"ss"]);
    NSLog(@"%@",params[@"phone"]);
    NSString *newURL = apiURL;
    if ([apiURL hasPrefix:@"//"]) {
        newURL = [NSString stringWithFormat:@"http:%@", apiURL];
    } else if (![apiURL hasPrefix:@"//"]) {
        // relative path,weex路径下的url使用
        newURL = [NSURL URLWithString:apiURL relativeToURL:weexInstance.scriptURL].absoluteString;
    }
    
    ///URL跳转使用,使用module(两步操作：1.url获取，2.push跳转)

}

@end

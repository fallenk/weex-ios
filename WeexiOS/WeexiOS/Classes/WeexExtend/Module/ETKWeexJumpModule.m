//
//  ETKWeexJumpModule.m
//  WeexiOS
//
//  Created by FallenK on 2016/11/15.
//  Copyright © 2016年 KFallen. All rights reserved.
//

#import "ETKWeexJumpModule.h"
#import "ETKSkinCareBoardDetailControllerViewController.h"
#import "ETKLoginViewController.h"

@implementation ETKWeexJumpModule

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(call:withParam:callBack:))

- (void)call:(NSString *)apiURL withParam:(NSDictionary *)params callBack:(WXModuleCallback)callBack {
    NSString *newURL = apiURL;
    if ([apiURL hasPrefix:@"//"]) {
        newURL = [NSString stringWithFormat:@"http:%@", apiURL];
    } else if (![apiURL hasPrefix:@"//"]) {
        // relative path,weex路径下的url使用
        newURL = [NSURL URLWithString:apiURL relativeToURL:weexInstance.scriptURL].absoluteString;
    }
    
    ///URL跳转使用,使用module(两步操作：1.url获取，2.push跳转)
    UIViewController *vc = [[ETKSkinCareBoardDetailControllerViewController alloc] init];
    ((ETKSkinCareBoardDetailControllerViewController *)vc).URL = [NSURL URLWithString:newURL];
    ((ETKSkinCareBoardDetailControllerViewController *)vc).title = params[@"title"];
    [[weexInstance.viewController navigationController] pushViewController:vc animated:YES];
    callBack(@{@"result":@"fallenk_liu success"});
    
}

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
    [weexInstance.viewController dismissViewControllerAnimated:YES completion:nil];
    
}



@end

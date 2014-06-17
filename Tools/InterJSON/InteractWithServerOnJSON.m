//
//  InteractWithServerOnJSON.m
//  Account
//
//  Created by wang zhe on 7/25/13.
//
//

#import "InteractWithServerOnJSON.h"
#import "Common.h"
#import "SVProgressHUD.h"


@implementation InteractWithServerOnJSON


+(NSDictionary *)interactWithServerOnJSON:(NSString *)urlString
{
    NSUserDefaults *userInformation = [NSUserDefaults standardUserDefaults];
    NSString *internetStatus = [userInformation valueForKey:@"internetIsAvailable"];
    
    if([internetStatus isEqualToString:@"no"])
    {
        [SVProgressHUD showErrorWithStatus:@"当前网络不可用!"];
        sleep(1);
        [SVProgressHUD dismiss];
        return nil;
    }
    else
        return [self interactWithServer:urlString];
}

+(NSDictionary *)interactWithServer:(NSString *)urlString
{
    NSError *error;
    NSString *urlStringEncoding = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",urlStringEncoding);
    
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStringEncoding]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (response != nil && error == nil) {
        return [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    } else {
        return  nil;
    }
}



@end

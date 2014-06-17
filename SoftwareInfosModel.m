//
//  SoftwareInfosModel.m
//  Account
//
//  Created by dongway on 13-11-13.
//
//

#import "SoftwareInfosModel.h"
#import "InteractWithServerOnJSON.h"
#import "API.h"

@implementation SoftwareInfosModel

-(void)getAppStoreInfosWithAppStoreID:(NSString *)appStoreID
{
    NSString *url = [NSString stringWithFormat:APPStoreInfo_URL, appStoreID];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.softwares = [dictionary objectForKey:@"results"];
}
-(void)setPropertysWithDictionary:(NSDictionary *)dictionary
{
    self.version = [dictionary valueForKey:@"version"];
}


@end

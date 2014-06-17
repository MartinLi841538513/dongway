//
//  IndexDatasModel.m
//  Account
//
//  Created by dongway on 13-11-15.
//
//

#import "IndexDatasModel.h"
#import "InteractWithServerOnJSON.h"
#import "API.h"

@implementation IndexDatasModel


-(void)setIndexDatasWithBid:(NSString *)bid
{
    NSString *url = [NSString stringWithFormat:GetBannerInfos_URL, bid];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.IndexDatas = [dictionary objectForKey:@"indexDatas"];
}

-(void)setPropertysWithDictionary:(NSDictionary *)dictionary
{
    
    self.ID = [dictionary valueForKey:@"ID"];
    self.activityPeople = [dictionary valueForKey:@"activityPeople"];
    self.activityPlace = [dictionary valueForKey:@"activityPlace"];
    self.alt = [dictionary valueForKey:@"alt"];
    self.bid = [dictionary valueForKey:@"bid"];
    self.bookPeople = [dictionary valueForKey:@"bookPeople"];
    self.clickPeople = [dictionary valueForKey:@"clickPeople"];
    self.content = [dictionary valueForKey:@"content"];
    self.createTime = [dictionary valueForKey:@"createTime"];
    self.picUrl = [dictionary valueForKey:@"picUrl"];
    self.storeName = [dictionary valueForKey:@"storeName"];
    self.title = [dictionary valueForKey:@"title"];
    self.type = [dictionary valueForKey:@"type"];
    self.url = [dictionary valueForKey:@"url"];
    
}


@end

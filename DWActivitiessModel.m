//
//  DWActivitiessModel.m
//  Account
//
//  Created by wang zhe on 9/5/13.
//
//

#import "DWActivitiessModel.h"
#import "InteractWithServerOnJSON.h"
#import "API.h"

@implementation DWActivitiessModel

-(void)setDWActivitiesWithStatus:(NSString *)status
{
    NSString *url = [NSString stringWithFormat:GET_DWActivities_URL, status];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.DWActivities = [dictionary objectForKey:@"DWActivitiess"];
}

-(void)setPropertysWithDictionary:(NSDictionary *)dictionary
{
    self.BBSUrl = [dictionary valueForKey:@"BBSUrl"];
    self.ID = [dictionary valueForKey:@"ID"];
    self.address = [dictionary valueForKey:@"address"];
    self.content = [dictionary valueForKey:@"content"];
    self.createTime = [dictionary valueForKey:@"createTime"];
    self.imageUrl = [dictionary valueForKey:@"imageUrl"];
    self.note = [dictionary valueForKey:@"note"];
    self.peopleNum = [dictionary valueForKey:@"peopleNum"];
    self.status = [dictionary valueForKey:@"status"];
    self.time = [dictionary valueForKey:@"time"];
    self.title = [dictionary valueForKey:@"title"];

}

@end

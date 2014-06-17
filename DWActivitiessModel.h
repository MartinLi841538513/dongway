//
//  DWActivitiessModel.h
//  Account
//
//  Created by wang zhe on 9/5/13.
//
//

#import <Foundation/Foundation.h>

@interface DWActivitiessModel : NSObject

@property (copy, nonatomic) NSArray *DWActivities;

@property (copy, nonatomic) NSString *BBSUrl;
@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *imageUrl;
@property (copy, nonatomic) NSString *note;
@property (copy, nonatomic) NSString *peopleNum;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *title;

//活动
-(void)setDWActivitiesWithStatus:(NSString *)status;

-(void)setPropertysWithDictionary:(NSDictionary *)dictionary;

@end

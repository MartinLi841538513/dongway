//
//  SoftwareInfosModel.h
//  Account
//
//  Created by dongway on 13-11-13.
//
//

#import <Foundation/Foundation.h>

@interface SoftwareInfosModel : NSObject

@property (copy, nonatomic) NSArray *softwares;

@property (copy, nonatomic) NSString *version;


-(void)getAppStoreInfosWithAppStoreID:(NSString *)appStoreID;

-(void)setPropertysWithDictionary:(NSDictionary *)dictionary;


@end

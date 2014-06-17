
//
//  Address.m
//  Account
//
//  Created by wang zhe on 9/3/13.
//
//

#import "SearchModel.h"
#import "InteractWithServerOnJSON.h"
#import "API.h"

@implementation SearchModel

- (id)initGetAddressWithLatitude:(NSString *)latitude andLongitude:(NSString *)longitude
{
    if((self = [super init]))
    {
        NSString *locationUrl = [NSString stringWithFormat:GET_ADDRESS_DW, latitude, longitude];
        NSDictionary *locationDict = [InteractWithServerOnJSON interactWithServerOnJSON:locationUrl];
        self.locationString = [locationDict objectForKey:@"state"];
    }
    return self;
}

@end

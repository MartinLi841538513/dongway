
//
//  Address.h
//  Account
//
//  Created by wang zhe on 9/3/13.
//
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject

@property (copy, nonatomic) NSString *locationString;

- (id)initGetAddressWithLatitude:(NSString *)latitude andLongitude:(NSString *)longitude;
@end

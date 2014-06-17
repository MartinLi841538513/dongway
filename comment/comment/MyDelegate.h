//
//  SXPassValueDelegate.h
//  comment
//
//  Created by Sam Xie on 7/21/13.
//  Copyright (c) 2013 Sam Xie. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MyDelegate <NSObject>

//- (void)passValue:(NSString *)passValue;
@optional
- (void)passValue:(id)passValue;
- (void)passValue:(NSString *)passCat andLatitude:(NSString *)passLatitude andLongitude:(NSString *)passLongitude andRadius:(NSString *)passRadius andSort:(NSString *)passSort andPrice:(NSString *)passPrice andTerm:(NSString *)passTerm andIsAdvanedSearch:(BOOL)passIsAdvanedSearch andLocationName:(NSString *)locationName;

-(void)dosomething;

@end

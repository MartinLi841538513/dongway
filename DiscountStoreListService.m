//
//  DiscountStoreListService.m
//  Account
//
//  Created by wang zhe on 9/6/13.
//
//

#import "DiscountStoreListService.h"

@implementation DiscountStoreListService

-(void)mutableArray:(NSMutableArray *)mutableArray appendedByArray:(NSArray *)array
{
    for(int i = 0;i < [array count];i++)
    {
        [mutableArray addObject:[array objectAtIndex:i]];
    }
}

@end

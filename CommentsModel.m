//
//  CommentsModel.m
//  Account
//
//  Created by wang zhe on 9/4/13.
//
//

#import "CommentsModel.h"
#import "InteractWithServerOnJSON.h"
#import "API.h"

@implementation CommentsModel

-(void)setCommentsWithCat:(NSString *)cat andStoreID:(NSString *)storeID
{
    
    NSString *url = [NSString stringWithFormat:Get_Comment_URL, cat,storeID];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.comments = [dictionary objectForKey:@"comments"];
    
}

-(void)addCommentWithCat:(NSString *)cat andStoreID:(NSString *)storeID andCommentID:(NSString *)commentID andComment:(NSString *)comment andScore:(NSString *)score andUsername:(NSString *)userName andTaste:(NSString *)taste andEnvironment:(NSString *)environment andService:(NSString *)service andPrice:(NSString *)price
{
    NSString *url = [NSString stringWithFormat:ADD_Comment_URL,cat,storeID, commentID, comment, score, userName, taste, environment, service, price];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.comments = [dictionary objectForKey:@"comments"];
}

-(void)setPropertysWithDictionary:(NSDictionary *)dictionary
{
    
    self.ID = [dictionary valueForKey:@"ID"];
    self.comment = [dictionary valueForKey:@"comment"];
    self.commentID = [dictionary valueForKey:@"commentID"];
    self.environment = [dictionary valueForKey:@"environment"];
    self.lastUpdateTime = [dictionary valueForKey:@"lastUpdateTime"];
    self.price = [dictionary valueForKey:@"price"];
    self.score = [dictionary valueForKey:@"score"];
    self.service = [dictionary valueForKey:@"service"];
    self.source = [dictionary valueForKey:@"source"];
    self.taste = [dictionary valueForKey:@"taste"];
    self.userName = [dictionary valueForKey:@"userName"];
    
}

@end

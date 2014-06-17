//
//  CommentsModel.h
//  Account
//
//  Created by wang zhe on 9/4/13.
//
//

#import <Foundation/Foundation.h>

@interface CommentsModel : NSObject

@property (copy, nonatomic) NSArray *comments;

@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *comment;
@property (copy, nonatomic) NSString *commentID;
@property (copy, nonatomic) NSString *environment;
@property (copy, nonatomic) NSString *lastUpdateTime;
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSString *score;
@property (copy, nonatomic) NSString *service;
@property (copy, nonatomic) NSString *source;
@property (copy, nonatomic) NSString *taste;
@property (copy, nonatomic) NSString *userName;

-(void)setCommentsWithCat:(NSString *)cat andStoreID:(NSString *)storeID;
-(void)addCommentWithCat:(NSString *)cat andStoreID:(NSString *)storeID andCommentID:(NSString *)commentID andComment:(NSString *)comment andScore:(NSString *)score andUsername:(NSString *)userName andTaste:(NSString *)taste andEnvironment:(NSString *)environment andService:(NSString *)service andPrice:(NSString *)price;
-(void)setPropertysWithDictionary:(NSDictionary *)dictionary;

@end

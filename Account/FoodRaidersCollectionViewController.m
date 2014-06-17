//
//  FoodStrategyCollectionViewController.m
//  Account
//
//  Created by wang zhe on 7/18/13.
//
//

#import "FoodRaidersCollectionViewController.h"
#import "FoodRaidersCell.h"
#import "FoodRaiderDetailViewController.h"
#import "Common.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SVProgressHUD.h"
#import "FoodRaidersModel.h"
#import "StateModel.h"
#import "GlobalVariateModel.h"
#import "UserInfosModel.h"

@interface FoodRaidersCollectionViewController ()
{
    NSMutableArray *foodRaiderCollectionArray;
    NSInteger rowForDelete;
    NSIndexPath *indexPathForDelete;
    FoodRaidersModel *foodRaidersModel;
    StateModel *stateModel;
    GlobalVariateModel *globalVariateModel;
    UserInfosModel *userInfosModel;
    Common *common;
}

@end

@implementation FoodRaidersCollectionViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"美食攻略";
    
    common = [[Common alloc] init];
    foodRaidersModel = [[FoodRaidersModel alloc] init];
    stateModel = [[StateModel alloc] init];
    globalVariateModel = [[GlobalVariateModel alloc] init];
    userInfosModel = [[UserInfosModel alloc] init];
    [userInfosModel setPropertysWithDictionary:[globalVariateModel userInfos]];
    
    [common returnButton:self];
    NSString *userName = userInfosModel.userName;
    
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [foodRaidersModel setCollectedFoodRaidersWithUsername:userName];
        foodRaiderCollectionArray = [[NSMutableArray alloc] initWithArray:foodRaidersModel.foodRaiders];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [foodRaiderCollectionArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellTableIdentifier = @"CellTableIdentifier";
    NSUInteger section = [indexPath row];
    NSDictionary *foodRaiderDictionary = [foodRaiderCollectionArray objectAtIndex:section];
    [foodRaidersModel setPropertysWithDictionary:foodRaiderDictionary];
    // Configure the cell...
    
    BOOL nibsRegistered = NO;
    if(!nibsRegistered)
    {
        UINib *nib = [UINib nibWithNibName:@"FoodRaidersCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
        nibsRegistered = YES;
    }
    
    FoodRaidersCell *cell = (FoodRaidersCell *)[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    cell.title.text = foodRaidersModel.title;
    //用小图，节省流量
    NSString *imageUrlThumbs;
    imageUrlThumbs =[foodRaidersModel.imageUrl stringByReplacingOccurrencesOfString:@".jpg" withString:@".thumbs.jpg"];
    imageUrlThumbs =[foodRaidersModel.imageUrl stringByReplacingOccurrencesOfString:@".png" withString:@".thumbs.png"];
    [cell.imageUrl setImageWithURL:[NSURL URLWithString:imageUrlThumbs] placeholderImage:[UIImage imageNamed:@"logoLoading.jpg"]];
    cell.typeName.text = foodRaidersModel.typeName;
    cell.source.text = foodRaidersModel.source;
    
    NSString *tag = [NSString stringWithFormat:@"标签:%@",foodRaidersModel.tag];
    cell.tag1.text = tag;
    CGSize newContentInCellFrame1 = [tag sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(300.0f, 2000.0f) lineBreakMode:NSLineBreakByCharWrapping];
    cell.tag1.frame = CGRectMake(cell.tag1.frame.origin.x, cell.tag1.frame.origin.y, newContentInCellFrame1.width, newContentInCellFrame1.height+1);
    
    
    NSString *foodAbstract = [NSString stringWithFormat:@"摘要:%@",foodRaidersModel.foodAbstract];
    cell.foodAbstract.text = foodAbstract;
    CGSize newContentInCellFrame2 = [foodAbstract sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(300.0f, 2000.0f) lineBreakMode:NSLineBreakByCharWrapping];
    cell.foodAbstract.frame = CGRectMake(cell.tag1.frame.origin.x, cell.tag1.frame.origin.y+cell.tag1.frame.size.height+5, newContentInCellFrame2.width, newContentInCellFrame2.height+1);
   
    cell.createTime.text = [NSString stringWithFormat:@"发布时间:%@",foodRaidersModel.createTime];
    cell.createTime.frame = CGRectMake(cell.tag1.frame.origin.x, cell.foodAbstract.frame.origin.y+cell.foodAbstract.frame.size.height+3, 296, 21);
    
    UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(deleteCell:)];
    longPressGesture.minimumPressDuration = 1.0;
    [cell addGestureRecognizer:longPressGesture];
    
    cell.shareImageView.frame = CGRectMake(249, cell.foodAbstract.frame.origin.y+cell.foodAbstract.frame.size.height+11, 30, 13);
    cell.shareLabel.frame = CGRectMake(277, cell.foodAbstract.frame.origin.y+cell.foodAbstract.frame.size.height+2, 29, 31);
    cell.shareWith.frame = CGRectMake(230, cell.foodAbstract.frame.origin.y+cell.foodAbstract.frame.size.height-37, 76, 61);
    
    cell.shareImageView.userInteractionEnabled = YES;
    cell.shareLabel.userInteractionEnabled = YES;
    cell.shareWith.userInteractionEnabled = YES;
    
    cell.shareImageView.tag = section;
    cell.shareLabel.tag = section;
    cell.shareWith.tag = section;
    
    UITapGestureRecognizer *shareImageView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareAction:)];
    UITapGestureRecognizer *shareLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareAction:)];
    UITapGestureRecognizer *shareWith = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareAction:)];
    
    [cell.shareImageView addGestureRecognizer:shareImageView];
    [cell.shareLabel addGestureRecognizer:shareLabel];
    [cell.shareWith addGestureRecognizer:shareWith];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath row];
    NSDictionary *foodRaiderssInfoDictionary = [foodRaiderCollectionArray objectAtIndex:section];
    [foodRaidersModel setPropertysWithDictionary:foodRaiderssInfoDictionary];
    NSString *tag = [NSString stringWithFormat:@"标签:%@",foodRaidersModel.tag];
    CGSize newContentInCellFrame1 = [tag sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(300.0f, 2000.0f) lineBreakMode:NSLineBreakByCharWrapping];
    NSString *foodAbstract = [NSString stringWithFormat:@"摘要:%@",foodRaidersModel.foodAbstract];
    CGSize newContentInCellFrame2 = [foodAbstract sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(300.0f, 2000.0f) lineBreakMode:NSLineBreakByCharWrapping];
    
    return newContentInCellFrame1.height+newContentInCellFrame2.height+120;
}


-(void)deleteCell:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        CGPoint location = [gestureRecognizer locationInView:self.tableView];
        indexPathForDelete = [self.tableView indexPathForRowAtPoint:location];
        rowForDelete = [indexPathForDelete row];
        FoodRaidersCell *cell = (FoodRaidersCell *)gestureRecognizer.view;
        //这里把cell做为第一响应(cell默认是无法成为responder,需要重写canBecomeFirstResponder方法)
        [cell becomeFirstResponder];
        
        UIMenuItem *itCancel = [[UIMenuItem alloc] initWithTitle:@"取消" action:@selector(longHandleCancelCell:)];
        UIMenuItem *itDelete = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(longHandleDeleteCell:)];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuItems:[NSArray arrayWithObjects:itCancel, itDelete,  nil]];
        [menu setTargetRect:cell.frame inView:self.tableView];
        [menu setMenuVisible:YES animated:YES];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath row];
    FoodRaiderDetailViewController *foodRaiderDetailView = [[FoodRaiderDetailViewController alloc] init];
    [foodRaidersModel setPropertysWithDictionary:[foodRaiderCollectionArray objectAtIndex:section]];
    foodRaiderDetailView.foodRaidersModel = foodRaidersModel;
    [self.navigationController pushViewController:foodRaiderDetailView animated:YES];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self swipeHandleDeleteCell:indexPath];
    }
}

- (void)longHandleCancelCell:(id)sender
{
    //取消删除cell
    return;
}
//长按删除
- (void)longHandleDeleteCell:(id)sender
{
    [self handleDeleteCell:indexPathForDelete];
}
//滑动删除
-(void)swipeHandleDeleteCell:(NSIndexPath *)indexPath
{
    [self handleDeleteCell:indexPath];
}

-(void)handleDeleteCell:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSDictionary *foodRaiderCollectionForDelete = [foodRaiderCollectionArray objectAtIndex:row];

    [foodRaiderCollectionArray removeObjectAtIndex:row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [NSThread detachNewThreadSelector:@selector(handleDeleteData:) toTarget:self withObject:foodRaiderCollectionForDelete];
}
-(void)handleDeleteData:(NSDictionary *)foodRaiderCollectionForDelete
{
    //删除cell
    NSString *userName = userInfosModel.userName;
    [foodRaidersModel setPropertysWithDictionary:foodRaiderCollectionForDelete];
    NSString *foodRaidersID = foodRaidersModel.ID;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //线程安全
        @synchronized(stateModel)
        {
            [stateModel foodRaiderCollectionDeleteStateWithUsername:userName andFoodRaidersID:foodRaidersID];
        }


        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *state = stateModel.state;
            if(![state isEqualToString:@"1"])
            {
                [SVProgressHUD showErrorWithStatus:@"美食攻略收藏删除失败"];
            }
        });
    });
}

//分享
-(void)shareAction:(UITapGestureRecognizer *)sender
{
    NSUInteger row = sender.view.tag;
    NSDictionary *foodRaiderssInfoDictionary = [foodRaiderCollectionArray objectAtIndex:row];
    [foodRaidersModel setPropertysWithDictionary:foodRaiderssInfoDictionary];
    
    [common foodRaiderShareWithFoodRaiderModel:foodRaidersModel inViewController:self];
    
}

@end

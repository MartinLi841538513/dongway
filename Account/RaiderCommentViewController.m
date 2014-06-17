//
//  RaiderCommentViewController.m
//  Account
//
//  Created by wang zhe on 8/2/13.
//
//

#import "RaiderCommentViewController.h"
#import "RaiderCommetCell.h"
#import "SVProgressHUD.h"
#import "FoodRaiderCommentsModel.h"
#import "StateModel.h"
#import "GlobalVariateModel.h"
#import "UserInfosModel.h"
#import "Common.h"

@interface RaiderCommentViewController ()
{
    NSArray *raiderCommentArray;
    BOOL raiderCommemtIsSuccess;
    FoodRaiderCommentsModel *foodRaiderCommentsModel;
    StateModel *stateModel;
    GlobalVariateModel *globalVariateModel;
    UserInfosModel *userInfosModel;
    Common *common;
    UIKeyboardViewController *keyBoardController;
}

@end

@implementation RaiderCommentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    common = [[Common alloc] init];
    [common returnButton:self];
    
    self.title = @"用户评论";
    
    // Do any additional setup after loading the view from its nib.
    self.submitButton.enabled = NO;
    [self.submitButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

    keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
	[keyBoardController addToolbarToKeyboard];
    
    self.commentContent.delegate = self;
    
    foodRaiderCommentsModel = [[FoodRaiderCommentsModel alloc] init];
    stateModel = [[StateModel alloc] init];
    globalVariateModel = [[GlobalVariateModel alloc] init];
    userInfosModel = [[UserInfosModel alloc] init];
    [userInfosModel setPropertysWithDictionary:[globalVariateModel userInfos]];
    
    [self loadComments];
}

-(void)loadComments
{
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *raiderID = self.foodRaiderDetailModel.ID;
        [foodRaiderCommentsModel setFoodRaiderCommentsWithFoodRaiderID:raiderID];
        raiderCommentArray = foodRaiderCommentsModel.foodRaidersComments;
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            if([raiderCommentArray count]<1)
            {
                self.tableView.hidden = YES;
                self.tip.hidden = NO;
            }
            else
            {
                self.tableView.hidden = NO;
                self.tip.hidden = YES;
                if(raiderCommemtIsSuccess == YES)
                {
                    [SVProgressHUD showSuccessWithStatus:@"评论成功"];
                    raiderCommemtIsSuccess = NO;
                }
                [self.tableView reloadData];
            }
            
        });
    });

}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-170)];
    [self.commentContent setFrame:CGRectMake(9, self.tableView.frame.origin.y+self.tableView.frame.size.height+8, 302, 114)];
    [self.submitButton setFrame:CGRectMake(189, self.commentContent.frame.origin.y+self.commentContent.frame.size.height+8, 121, 32)];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [raiderCommentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    NSDictionary *raiderCommentDictionary = [raiderCommentArray objectAtIndex:row];
    [foodRaiderCommentsModel setPropertysWithDictionary:raiderCommentDictionary];
    static NSString *CellTableIdentifier = @"Cell";
    // Configure the cell...
    BOOL nibsRegistered = NO;
    if(!nibsRegistered)
    {
        UINib *nib = [UINib nibWithNibName:@"RaiderCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
        nibsRegistered = YES;
    }
    RaiderCommetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    NSString *userName = userInfosModel.userName;
    NSString *userTitle = userInfosModel.userTitle;
    NSString *commentContent = foodRaiderCommentsModel.commentInfo;
    NSString *createTime = [foodRaiderCommentsModel.createTime substringWithRange:NSMakeRange(0, 16)];
    
    cell.userName.text = userName;
    cell.userTitle.text = userTitle;
    cell.commentContent.text = commentContent;
    
    CGSize newCommentContentFrame = [cell.commentContent.text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(291.0f, 2000.0f) lineBreakMode:NSLineBreakByCharWrapping];
    cell.commentContent.frame = CGRectMake(cell.commentContent.frame.origin.x, cell.commentContent.frame.origin.y, 291, newCommentContentFrame.height+10);
    
    cell.createTime.text = createTime;
    cell.createTime.frame = CGRectMake(184.0f, newCommentContentFrame.height + 70, 270.0f, 15.0f);
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [foodRaiderCommentsModel setPropertysWithDictionary:[raiderCommentArray objectAtIndex:[indexPath row]]];
    NSString *string = foodRaiderCommentsModel.commentInfo;
    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(291.0f, 2000.0f) lineBreakMode:NSLineBreakByCharWrapping];
    return 90.0f + size.height;
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.commentContent.text = @"";
    self.submitButton.enabled = YES;
    return YES;
}


//提交评论  味道好极了
- (IBAction)submit:(id)sender {
    
    [self.commentContent resignFirstResponder];
    
    if([self.commentContent.text length] < 2)
    {
        [SVProgressHUD showErrorWithStatus:@"字数太少"];
        return;
    }
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *raiderID = self.foodRaiderDetailModel.ID;
        NSString *userID = userInfosModel.ID;
        NSString *parentID = @"0";
        NSString *commentInfo = self.commentContent.text;
        [stateModel foodRaiderCommentAddStateWithFoodRaiderDetailID:raiderID andUserID:userID andParentID:parentID andCommentInfo:commentInfo];
        NSString *state = stateModel.state;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            if([state isEqualToString:@"1"])
            {
                
                self.commentContent.text = @"请输入您要评论的内容......";
                [self loadComments];
                raiderCommemtIsSuccess = YES;
                self.submitButton.enabled = NO;
                
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"评论失败"];
            }
        });
    });
}

- (IBAction)backgroundTap:(id)sender {
    
    [self.commentContent resignFirstResponder];
}

@end

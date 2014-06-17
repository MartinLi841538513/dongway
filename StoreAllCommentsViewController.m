//
//  StoreAllCommentsViewController.m
//  Account
//
//  Created by dongway on 13-11-3.
//
//

#import "StoreAllCommentsViewController.h"
#import "StoreCommentCell.h"
#import "CommentsModel.h"
#import "Common.h"

@interface StoreAllCommentsViewController ()
{
    CommentsModel *commentsModel;
    Common *common;
}

@end

@implementation StoreAllCommentsViewController

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
    
    // Do any additional setup after loading the view from its nib.
    self.title = @"更多评论";
    commentsModel = [[CommentsModel alloc] init];
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
    return [self.comments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    
    static NSString *CellTableIdentifier = @"Cell";
    // Configure the cell...
    StoreCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"StoreCommentCell" owner:self options:nil] lastObject];
    }
    
    NSDictionary *commentDictionary = [self.comments objectAtIndex:row];
    [commentsModel setPropertysWithDictionary:commentDictionary];
    
    
    cell.commentContent.text = commentsModel.comment;
    CGSize newContentInCellFrame = [cell.commentContent.text sizeWithFont:cell.commentContent.font constrainedToSize:CGSizeMake(249.0f, 2000.0f) lineBreakMode:NSLineBreakByWordWrapping];
    cell.commentContent.frame = CGRectMake(cell.commentContent.frame.origin.x, cell.commentContent.frame.origin.y, newContentInCellFrame.width, newContentInCellFrame.height+7);
    
    cell.time.text = commentsModel.lastUpdateTime;
    if(newContentInCellFrame.height>0)
    {
        [cell.time setFrame:CGRectMake(cell.commentContent.frame.origin.x, cell.commentContent.frame.origin.y+cell.commentContent.frame.size.height+4, 130, 10)];
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSDictionary *commentDictionary = [self.comments objectAtIndex:row];
    [commentsModel setPropertysWithDictionary:commentDictionary];
    CGSize newContentInCellFrame = [commentsModel.comment sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(249.0f, 2000.0f) lineBreakMode:NSLineBreakByCharWrapping];
    if(newContentInCellFrame.height+40>45)
        return newContentInCellFrame.height+40;
    return 45.0f;
}


@end

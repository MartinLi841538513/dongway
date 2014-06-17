//
//  FoodRaiderViewController.m
//  Account
//
//  Created by wang zhe on 7/23/13.
//
//

#import "FoodRaiderViewController.h"
#import "FoodRaidersCell.h"
#import "FoodRaiderDetailViewController.h"
#import "Common.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SVProgressHUD.h"
#import "FoodRaidersModel.h"

@interface FoodRaiderViewController ()
{
    NSArray *foodRaiderssInfoArray;
    Common *common ;
    FoodRaidersModel *foodRaidersModel;
}

@end


@implementation FoodRaiderViewController

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
    
    // Do any additional setup after loading the view from its nib.
    [SVProgressHUD dismiss];
    [self.navigationItem setTitle:@"美食攻略"];
    
    self.raiderName.delegate = self;
//    [self.tableView setFrame:CGRectMake(0, 50, 320, self.view.frame.size.height-90)];
    foodRaidersModel = [[FoodRaidersModel alloc] init];
    //功能菜单
    common = [[Common alloc] init];
    [common returnButton:self];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.hidden = YES;
    self.tip.hidden = YES;
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] init];
    [activityIndicatorView stopAnimating];
    [SVProgressHUD addActivityView:activityIndicatorView toViewController:self];

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [foodRaidersModel setFoodRaiders];
        foodRaiderssInfoArray = foodRaidersModel.foodRaiders;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [activityIndicatorView stopAnimating];
            if([foodRaiderssInfoArray count]<1)
            {
                [SVProgressHUD showErrorWithStatus:@"没有获取到美食攻略"];
                self.tableView.hidden = YES;
                self.tip.hidden = NO;
                self.tip.text = @"没有获取到美食攻略";
            }
            else
            {
                self.tableView.hidden = NO;
                self.tip.hidden = YES;
                [self.tableView reloadData];
            }
            
        });
    });
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [self.raiderName setFrame:CGRectMake(16, self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height+10, 232, 30)];
        [self.searchButton setFrame:CGRectMake(256, self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height+13, 57, 29)];
        [self.tableView setFrame:CGRectMake(0, self.raiderName.frame.origin.y+self.raiderName.frame.size.height+5, 320, self.view.frame.size.height-108)];
    }
    else
    {
        [self.tableView setFrame:CGRectMake(0, self.raiderName.frame.origin.y+self.raiderName.frame.size.height+5, 320, self.view.frame.size.height-48)];
    }
    
    
}

-(void)viewDidAppear:(BOOL)animated
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
    return [foodRaiderssInfoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    NSDictionary *foodRaiderssInfoDictionary = [foodRaiderssInfoArray objectAtIndex:row];
    [foodRaidersModel setPropertysWithDictionary:foodRaiderssInfoDictionary];
    static NSString *CellTableIdentifier = @"CellTableIdentifier";
    // Configure the cell...
    BOOL nibsRegistered = NO;
    if(!nibsRegistered)
    {
        UINib *nib = [UINib nibWithNibName:@"FoodRaidersCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
        nibsRegistered = YES;
    }
    
    FoodRaidersCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    //用小图，节省流量
    NSString *imageUrlThumbs;
    imageUrlThumbs =[foodRaidersModel.imageUrl stringByReplacingOccurrencesOfString:@".jpg" withString:@".thumbs.jpg"];
    imageUrlThumbs =[foodRaidersModel.imageUrl stringByReplacingOccurrencesOfString:@".png" withString:@".thumbs.png"];
    [cell.imageUrl setImageWithURL:[NSURL URLWithString:imageUrlThumbs] placeholderImage:[UIImage imageNamed:@"logoLoading.jpg"]];
    
    cell.title.text = foodRaidersModel.title;
    cell.typeName.text = foodRaidersModel.typeName;
    cell.source.text = foodRaidersModel.source;
    
    NSString *tag = [NSString stringWithFormat:@"标签:%@",foodRaidersModel.tag];
    cell.tag1.text = tag;
    CGSize newContentInCellFrame1 = [tag sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(300.0f, 2000.0f) lineBreakMode:NSLineBreakByCharWrapping];
    cell.tag1.frame = CGRectMake(cell.tag1.frame.origin.x, cell.tag1.frame.origin.y, newContentInCellFrame1.width+1, newContentInCellFrame1.height+1);

    
    NSString *foodAbstract = [NSString stringWithFormat:@"摘要:%@",foodRaidersModel.foodAbstract];
    cell.foodAbstract.text = foodAbstract;
    CGSize newContentInCellFrame2 = [foodAbstract sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(300.0f, 2000.0f) lineBreakMode:NSLineBreakByCharWrapping];
    cell.foodAbstract.frame = CGRectMake(cell.tag1.frame.origin.x, cell.tag1.frame.origin.y+cell.tag1.frame.size.height+5, newContentInCellFrame2.width, newContentInCellFrame2.height+1);
    
    cell.createTime.text = [NSString stringWithFormat:@"发布时间:%@",[foodRaidersModel.createTime substringWithRange:NSMakeRange(0, 19)]];
    cell.createTime.frame = CGRectMake(cell.tag1.frame.origin.x, cell.foodAbstract.frame.origin.y+cell.foodAbstract.frame.size.height+3, 296, 21);
    
    cell.shareImageView.frame = CGRectMake(249, cell.foodAbstract.frame.origin.y+cell.foodAbstract.frame.size.height+11, 30, 13);
    cell.shareLabel.frame = CGRectMake(277, cell.foodAbstract.frame.origin.y+cell.foodAbstract.frame.size.height+2, 29, 31);
    cell.shareWith.frame = CGRectMake(230, cell.foodAbstract.frame.origin.y+cell.foodAbstract.frame.size.height-37, 76, 61);
    
    cell.shareImageView.userInteractionEnabled = YES;
    cell.shareLabel.userInteractionEnabled = YES;
    cell.shareWith.userInteractionEnabled = YES;
    
    cell.shareImageView.tag = row;
    cell.shareLabel.tag = row;
    cell.shareWith.tag = row;
    
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
    NSInteger row = [indexPath row];
    NSDictionary *foodRaiderssInfoDictionary = [foodRaiderssInfoArray objectAtIndex:row];
    [foodRaidersModel setPropertysWithDictionary:foodRaiderssInfoDictionary];
    NSString *tag = [NSString stringWithFormat:@"标签:%@",foodRaidersModel.tag];
    CGSize newContentInCellFrame1 = [tag sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(300.0f, 2000.0f) lineBreakMode:NSLineBreakByCharWrapping];
    NSString *foodAbstract = [NSString stringWithFormat:@"摘要:%@",foodRaidersModel.foodAbstract];
    CGSize newContentInCellFrame2 = [foodAbstract sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(300.0f, 2000.0f) lineBreakMode:NSLineBreakByCharWrapping];
    
    return newContentInCellFrame1.height+newContentInCellFrame2.height+120;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    NSDictionary *foodRaidersInfoDictionary = [foodRaiderssInfoArray objectAtIndex:row];
    FoodRaiderDetailViewController *foodRaiderDetailView = [[FoodRaiderDetailViewController alloc] init];
    [foodRaidersModel setPropertysWithDictionary:foodRaidersInfoDictionary];
    foodRaiderDetailView.foodRaidersModel =foodRaidersModel;
    foodRaiderDetailView.hidesBottomBarWhenPushed = YES;
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:foodRaiderDetailView animated:YES];
}

- (IBAction)backrgroundTap:(id)sender {
    [self.raiderName resignFirstResponder];
    self.tableView.userInteractionEnabled = YES;
}

- (IBAction)search:(id)sender {
    
    if(self.raiderName.text == nil)
    {
        self.raiderName.text = @"";
    }
    
    self.tableView.hidden = YES;
    self.tip.hidden = YES;
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] init];
    [activityIndicatorView stopAnimating];
    [SVProgressHUD addActivityView:activityIndicatorView toViewController:self];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        
        [foodRaidersModel setSearchFoodRaidersWithSearchText:self.raiderName.text];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            foodRaiderssInfoArray = foodRaidersModel.foodRaiders;
            if([foodRaiderssInfoArray count]<1)
            {
                self.tableView.hidden = YES;
                self.tip.hidden = NO;
                self.tip.text = @"没有获取到美食攻略";
                [SVProgressHUD showErrorWithStatus:@"没有获取到美食攻略"];
            }
            else
            {
                self.tableView.hidden = NO;
                self.tip.hidden = YES;
            }
            [self.raiderName resignFirstResponder];
            [self.tableView reloadData];
            [activityIndicatorView stopAnimating];
        });
    });

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.tableView.userInteractionEnabled = NO;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self search:nil];
    return YES;
}

//分享
-(void)shareAction:(UITapGestureRecognizer *)sender
{
    NSUInteger row = sender.view.tag;
    NSDictionary *foodRaiderssInfoDictionary = [foodRaiderssInfoArray objectAtIndex:row];
    [foodRaidersModel setPropertysWithDictionary:foodRaiderssInfoDictionary];
    
    [common foodRaiderShareWithFoodRaiderModel:foodRaidersModel inViewController:self];
}


@end

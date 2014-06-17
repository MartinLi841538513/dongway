//
//  ChoiceYourLocationViewController.m
//  Account
//
//  Created by dongway on 13-12-5.
//
//

#import "ChoiceYourLocationViewController.h"
#import "Common.h"
#import "GlobalVariateModel.h"
#import "SVProgressHUD.h"

@interface ChoiceYourLocationViewController ()
{
    Common *common;
    GlobalVariateModel *globalVariateModel;
}

@end

@implementation ChoiceYourLocationViewController

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
    //这是返回按钮用图片表示的一种做法
    common = [[Common alloc] init];
    [common returnButton:self];
    self.title = @"自选定位地点";
    
    globalVariateModel = [[GlobalVariateModel alloc]  init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUserLatitude:(NSString *)latitude andLongitude:(NSString *)longtitude andUserAddress:(NSString *)userAddress
{
    [globalVariateModel setLatitude:latitude];
    [globalVariateModel setLongitude:longtitude];
    [globalVariateModel setUserAddress:userAddress];
    [globalVariateModel setLocationIsAvailabelOnPhone:@"yes"];
    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"成功设置您在:%@",userAddress]];
    
}

- (IBAction)district1Action:(id)sender
{
    [self setUserLatitude:@"28.195279" andLongitude:@"112.976317" andUserAddress:@"五一广场"];
}
- (IBAction)district2Action:(id)sender {
    [self setUserLatitude:@"28.209953" andLongitude:@"112.912824" andUserAddress:@"汽车西站"];
}

- (IBAction)district3Action:(id)sender {
    [self setUserLatitude:@"28.201784" andLongitude:@"113.058672" andUserAddress:@"汽车东站"];
}

- (IBAction)district4Action:(id)sender {
    [self setUserLatitude:@"28.097462" andLongitude:@"113.013718" andUserAddress:@"汽车南站"];
}

- (IBAction)district5Action:(id)sender {
    [self setUserLatitude:@"28.196054" andLongitude:@"112.952371" andUserAddress:@"溁湾镇"];
}

- (IBAction)district6Action:(id)sender {
    [self setUserLatitude:@"28.194258" andLongitude:@"113.011572" andUserAddress:@"火车站"];
}

- (IBAction)district7Action:(id)sender {
    [self setUserLatitude:@"28.169348" andLongitude:@"112.994835" andUserAddress:@"东塘"];
}

- (IBAction)district8Action:(id)sender {
    [self setUserLatitude:@"28.234343" andLongitude:@"113.013139" andUserAddress:@"四方坪"];
}

- (IBAction)district9Action:(id)sender {
    [self setUserLatitude:@"28.261222" andLongitude:@"112.982798" andUserAddress:@"湘江世纪城"];
}

- (IBAction)district10Action:(id)sender {
    [self setUserLatitude:@"28.193766" andLongitude:@"113.01743" andUserAddress:@"景泰广场"];
}

- (IBAction)district11Action:(id)sender {
    [self setUserLatitude:@"28.135142" andLongitude:@"112.970438" andUserAddress:@"新开铺"];
}

- (IBAction)district12Action:(id)sender {
    [self setUserLatitude:@"28.244419" andLongitude:@"113.080237" andUserAddress:@"星沙通程广场"];
}

- (IBAction)district13Action:(id)sender {
    [self setUserLatitude:@"28.172091" andLongitude:@"112.985287" andUserAddress:@"侯家塘"];
}

- (IBAction)district14Action:(id)sender {
    [self setUserLatitude:@"28.124451" andLongitude:@"113.006058" andUserAddress:@"井湾子"];
}

- (IBAction)district15Action:(id)sender {
    [self setUserLatitude:@"28.228331" andLongitude:@"112.987518" andUserAddress:@"伍家岭"];
}

- (IBAction)district16Action:(id)sender {
    [self setUserLatitude:@"28.161895" andLongitude:@"112.926278" andUserAddress:@"王家湾"];
}

- (IBAction)district17Action:(id)sender {
    [self setUserLatitude:@"28.185747" andLongitude:@"112.997432" andUserAddress:@"窑岭"];
}

- (IBAction)district18Action:(id)sender {
     [self setUserLatitude:@"28.203448" andLongitude:@"112.986059" andUserAddress:@"松桂园"];
}

@end

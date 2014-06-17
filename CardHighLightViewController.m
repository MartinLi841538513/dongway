//
//  CardHighLightViewController.m
//  Account
//
//  Created by dongway on 13-11-21.
//
//

#import "CardHighLightViewController.h"
#import "UserInfosModel.h"
#import "Common.h"

@interface CardHighLightViewController ()
{
    Common *common;
}

@end

@implementation CardHighLightViewController

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
    common = [[Common alloc] init];
    [common returnButton:self];
    
    self.cardID.text = self.userInfosModel.cardID;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

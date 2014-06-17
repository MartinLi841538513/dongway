//
//  ReportStoreProblemViewController.m
//  Account
//
//  Created by wang zhe on 8/1/13.
//
//

#import "ReportStoreProblemViewController.h"
#import "SVProgressHUD.h"
#import "StateModel.h"
#import "Common.h"

@interface ReportStoreProblemViewController ()
{
//    UIBarButtonItem *submitProblemButton;
    StateModel *stateModel;
    Common *common;
}
@end

@implementation ReportStoreProblemViewController

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
    stateModel = [[StateModel alloc] init];
    // Do any additional setup after loading the view from its nib.

    self.title = @"纠错";
    [common returnButton:self];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    self.submitButton.enabled = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    self.storeProblemContent.text = @"";
    self.storeProblemContent.textColor = [UIColor blackColor];
    self.submitButton.enabled = YES;
    return YES;
}


-(void)submitProblemAction:(id)sender
{
    if([self.storeProblemContent.text length] < 4)
    {
        [SVProgressHUD showErrorWithStatus:@"字数太少了"];
        [self.storeProblemContent becomeFirstResponder];
        return;
    }
    [self.storeProblemContent resignFirstResponder];

    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *userName = self.userName;
        NSString *storeID = self.storesModel.storeId;
        NSString *latitude = self.storesModel.latitude;
        NSString *longitude = self.storesModel.longtitude;
        NSString *content = self.storeProblemContent.text;
        [stateModel storeErrorAddStateWithUsername:userName andStoreID:storeID andLatitude:latitude andLongitude:longitude andContent:content];
        NSString *state = stateModel.state;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            if([state isEqualToString:@"1"])
            {
                self.storeProblemContent.text = @"请输入您要报告的问题......";
                self.submitButton.enabled = NO;
                //报告成功，要有提示
                [SVProgressHUD showSuccessWithStatus:@"提交成功"];
            }
            else
            {
                //报错失败，要有提示
                [SVProgressHUD showErrorWithStatus:@"提交失败"];
            }
        });
    });
}

- (IBAction)backgroundTap:(id)sender
{
    [self.storeProblemContent resignFirstResponder];
}

- (IBAction)submit:(id)sender
{
    [self submitProblemAction:sender];
}
@end




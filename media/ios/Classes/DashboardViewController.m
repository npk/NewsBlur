//
//  DashboardViewController.m
//  NewsBlur
//
//  Created by Roy Yang on 7/10/12.
//  Copyright (c) 2012 NewsBlur. All rights reserved.
//

#import "DashboardViewController.h"
#import "NewsBlurAppDelegate.h"
#import "ActivityModule.h"
#import "InteractionsModule.h"
#import "UserProfileViewController.h"
#import "JSON.h"

@implementation DashboardViewController

@synthesize appDelegate;
@synthesize interactionsLabel;
@synthesize interactionsModule;
@synthesize activitesLabel;
@synthesize activitiesModule;
@synthesize header;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload {
    [self setAppDelegate:nil];
    [self setInteractionsLabel:nil];
    [self setInteractionsModule:nil];
    [self setActivitesLabel:nil];
    [self setActivitiesModule:nil];
    [self setHeader:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.16f green:0.36f blue:0.46 alpha:0.9];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:16.0];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = DASHBOARD_TITLE;
    self.navigationItem.titleView = label;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (IBAction)doLogout:(id)sender {
    [appDelegate confirmLogout];
}

# pragma mark
# pragma mark Interactions

- (void)refreshInteractions {
    
    if (self.interactionsModule == nil) {
        InteractionsModule *interactions = [[InteractionsModule alloc] init];
        interactions.frame = CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 40);
        self.interactionsModule = interactions;
        [self.view insertSubview:self.interactionsModule
                    belowSubview:self.header];
        
        self.interactionsModule.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    
    [self.interactionsModule fetchInteractionsDetail:1];    
}

- (void)requestFailed:(ASIHTTPRequest *)request {    
    NSLog(@"Error in finishLoadInteractions is %@", [request error]);
}

# pragma mark
# pragma mark Activities

- (void)refreshActivity {
    NSString *urlString = [NSString stringWithFormat:@"http://%@/social/activities?user_id=%@",
                           NEWSBLUR_URL,
                           [appDelegate.dictUserProfile objectForKey:@"user_id"]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDidFinishSelector:@selector(finishLoadActivities:)];
    [request setDidFailSelector:@selector(requestFailed:)];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)finishLoadActivities:(ASIHTTPRequest *)request {
    NSString *responseString = [request responseString];
    NSDictionary *results = [[NSDictionary alloc] 
                             initWithDictionary:[responseString JSONValue]];
    
    appDelegate.dictUserActivities = results;
    
    if (self.activitiesModule == nil) {
        ActivityModule *activity = [[ActivityModule alloc] init];
        activity.frame = CGRectMake(20, 510, 320, 320);
        self.activitiesModule = activity;
        [self.view addSubview:self.activitiesModule];
    }
    
    [self.activitiesModule refreshWithActivities:appDelegate.dictUserActivities];

}

@end

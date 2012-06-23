//
//  StoryDetailViewController.h
//  NewsBlur
//
//  Created by Samuel Clay on 6/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsBlurAppDelegate;

@interface StoryDetailViewController : UIViewController <UIPopoverControllerDelegate> {
    NewsBlurAppDelegate *appDelegate;
    
    NSString *activeStoryId;
    UIProgressView *progressView;
    UIWebView *webView;
    UIToolbar *toolbar;
    UIBarButtonItem *buttonPrevious;
    UIBarButtonItem *buttonNext;
    UIBarButtonItem *activity;
    UIActivityIndicatorView *loadingIndicator;
    IBOutlet UIPopoverController *popoverController;
}

@property (nonatomic, retain) UIActivityIndicatorView *loadingIndicator;
@property (nonatomic, retain) IBOutlet NewsBlurAppDelegate *appDelegate;
@property (nonatomic, retain) NSString *activeStoryId;
@property (nonatomic, retain) IBOutlet UIProgressView *progressView;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *buttonPrevious;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *buttonNext;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *activity;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *buttonAction;
@property (nonatomic, retain) IBOutlet UIView *feedTitleGradient;
@property (retain,nonatomic) UIPopoverController *popoverController;

- (void)showPopover;
- (void)setNextPreviousButtons;
- (void)markStoryAsRead;
- (void)showStory;
- (void)showOriginalSubview:(id)sender;
- (IBAction)doNextUnreadStory;
- (IBAction)doPreviousStory;
- (IBAction)toggleFontSize:(id)sender;
- (void)markedAsRead;
- (void)setActiveStory;
- (void)setFontSize:(float)fontSize;
- (NSString *)getComments;
- (NSString *)getReplies:(NSArray *)replies;
- (NSDictionary *)getUser:(int)user_id;
- (void)setFontStyle:(NSString *)fontStyle;
- (IBAction)doShareButton:(id)sender;

@end

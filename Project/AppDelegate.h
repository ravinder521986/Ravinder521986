//
//  AppDelegate.h
//  Project
//
//  Created by MAC on 11/07/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "LoginViewController.h"
#import "LoginViewController_ipad.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,ASIHTTPRequestDelegate>{
    
    UINavigationController *navController;
    ASIFormDataRequest *serverRequest;
    NSString *urlType;
    NSString *requestType;
    UIView *spinerView;
    UIActivityIndicatorView *activityView;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong)ASIFormDataRequest *serverRequest;
-(void)PostWebServer:(NSMutableDictionary *)dict type:(NSString *)webServive;
-(void)showView;
-(void)hideView;

@end


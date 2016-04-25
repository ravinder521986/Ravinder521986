//
//  AppDelegate.m
//  Project
//
//  Created by MAC on 11/07/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "AppDelegate.h"
#import "webViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


@synthesize serverRequest;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.backgroundColor = [UIColor whiteColor];
        LoginViewController_ipad *objectiphone=[[LoginViewController_ipad alloc] init];
        navController=[[UINavigationController alloc]initWithRootViewController:objectiphone];
        navController.navigationBar.hidden=YES;
        self.window.rootViewController = navController;
        [self.window makeKeyAndVisible];
        return YES;


    }
    else{
        
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.backgroundColor = [UIColor whiteColor];
        LoginViewController *objectiphone=[[LoginViewController alloc] init];
        navController=[[UINavigationController alloc]initWithRootViewController:objectiphone];
        navController.navigationBar.hidden=YES;
        self.window.rootViewController = navController;
        [self.window makeKeyAndVisible];
        return YES;

    }
    
    
}


#pragma mark This Function is used to Make Cal server APIS to get the response.
-(void)PostWebServer:(NSMutableDictionary *)dict type:(NSString *)webServive{
    urlType=webServive;
    if(serverRequest) {
        NSLog(@"CANCEL REQUEST");
        [self.serverRequest cancel];
        [self.serverRequest clearDelegatesAndCancel];
    }
    
    if ([webServive isEqualToString:@"loginUser"]) {
        
        NSString *strurl=[NSString stringWithFormat:@"http://staging.tkofinancialsolutions.com/api/users/sign_in"];
        NSURL *url=[NSURL URLWithString:strurl];
        serverRequest=[ASIFormDataRequest requestWithURL:url];
        [serverRequest setPostValue:[dict valueForKey:@"username"] forKey:@"user_login[email]"];
        [serverRequest setPostValue:[dict valueForKey:@"password"] forKey:@"user_login[password]"];
        [serverRequest setRequestMethod:@"POST"];
        [serverRequest setDelegate:self];
        [serverRequest startAsynchronous];
        }

    
    }


#pragma mark This Function used to Get the Server Response and pass to Partuclur Class..
-(void)requestFinished:(ASIHTTPRequest *)request{
    
    
    
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:urlType object:self userInfo:dict];
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    
    [self hideView];
    
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
    NSLog(@"dict----%@",dict);
    [[NSNotificationCenter defaultCenter]postNotificationName:urlType object:self userInfo:dict];
}

/// ravinder kuamr testing app verison

-(void)showView{
    
    spinerView=[[UIView alloc] initWithFrame:CGRectMake((self.window.frame.size.width-100)/2, self.window.frame.size.height/2, 100, 100)];
    spinerView.backgroundColor=[UIColor blackColor];
    spinerView.layer.cornerRadius=8;
    self.window.userInteractionEnabled=NO;
    [self.window addSubview:spinerView];
    activityView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityView.frame=CGRectMake(35, 30, 25, 25);
    
    
    UILabel *loading=[[UILabel alloc] initWithFrame:CGRectMake(15, 55, 100, 20)];
    loading.backgroundColor=[UIColor clearColor];
    loading.text=@"Loading";
    loading.textColor=[UIColor whiteColor];
    [spinerView addSubview:loading];
    [spinerView addSubview:activityView];
    [activityView startAnimating];
    
}


-(void)hideView
{
    self.window.userInteractionEnabled=YES;
    [spinerView removeFromSuperview];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

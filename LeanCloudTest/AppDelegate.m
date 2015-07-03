//
//  AppDelegate.m
//  LeanCloudTest
//
//  Created by zhougj on 15/6/9.
//  Copyright (c) 2015年 iiseeuu. All rights reserved.
//

#import "AppDelegate.h"
#import <AVOSCloud/AVOSCloud.h>
#import "Student.h"

#define LeanCloud_AppID         @"o8ws8bkbkqw388g4ftu1o8ta7xq72retft04qc32c1uen2a3"
#define LeanCloud_AppKey        @"dowmw8kqpvoixf08nljndi4k68z3my090odpe4fkbymgpvox"
#define LeanCloud_MasterKey     @"bqo9ctxwe5lq0e1hsr7r4vb59b0bbyeyt4hzdk7svq3i4uw0"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [AVOSCloud setApplicationId:LeanCloud_AppID clientKey:LeanCloud_AppKey];
    {
        [Student registerSubclass];
    }
    return YES;
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

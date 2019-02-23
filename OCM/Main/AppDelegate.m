//
//  AppDelegate.m
//  OCM
//
//  Created by 曹均华 on 2017/11/29.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginUserPWDViewController.h"
#import "MessageLoginViewController.h"
#import "OCMSplitViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <Bugly/Bugly.h>
#import "GestureLoginViewController.h"
#import "FingerLockViewController.h"

@interface AppDelegate ()
@property (nonatomic, assign) NSTimeInterval interval1;
@property (nonatomic, assign) NSTimeInterval interval2;
@property (nonatomic, strong) NSMutableDictionary *dictCache;
@property (nonatomic, strong) MessageLoginViewController *msgVC;
@property (nonatomic, strong) OCMSplitViewController *splitVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _dictCache = [NSMutableDictionary dictionary];
    [AMapServices sharedServices].apiKey = @"10bc5fcd41d431263fb8da27c005f453";
//    c67d74c450c322b112fd9a7a2c172141   -->对应bundle id --> com.asiainfo.DGOCM
//    [Bugly startWithAppId:@"fad690a580"];//暂时隐藏bugly
    self.window = [[UIWindow alloc] initWithFrame:screenBounds];
    self.window.rootViewController = [[MessageLoginViewController alloc] init];
    [self.window makeKeyWindow];
    return YES;
}
- (void)showSplitView { // 展示主界面
    if (self.window.rootViewController) {
        self.window.rootViewController = nil;
    }
    self.window.rootViewController = [[OCMSplitViewController alloc] init];
    [self.window makeKeyWindow];
}
- (void)showLoginView { // 展示登录界面
    if (self.window.rootViewController) {
        self.window.rootViewController = nil;
    }
    self.window.rootViewController = [[MessageLoginViewController alloc] init];
    [self.window makeKeyWindow];
}
- (void)showGesView { //展示手势界面
    GestureLoginViewController *gestVC = [_dictCache objectForKey:@"GestureLoginViewController"];
    if (!gestVC) {
        GestureLoginViewController *gestVC = [[GestureLoginViewController alloc] init];
        [_dictCache setObject:gestVC forKey:@"GestureLoginViewController"];
        self.window.rootViewController = gestVC;
        [self.window makeKeyWindow];
    } else {
        self.window.rootViewController = gestVC;
        [self.window makeKeyWindow];
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    self.interval1 = [[NSDate date] timeIntervalSince1970] * 1000;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    self.interval2 = [[NSDate date] timeIntervalSince1970] * 1000;
    
    NSDate *date1 = [NSDate dateWithTimeIntervalSinceNow:self.interval1];
    NSDate *date2 = [NSDate dateWithTimeIntervalSinceNow:self.interval2];
    NSTimeInterval sec = [date2 timeIntervalSinceDate:date1] / 1000;
    if (sec >= 5) { // 大于xx秒
        FingerLockViewController *fingerVC = [_dictCache objectForKey:@"FingerLockViewController"];
        if (!fingerVC) {
            FingerLockViewController *fingerVC = [[FingerLockViewController alloc] init];
            [_dictCache setObject:fingerVC forKey:@"FingerLockViewController"];
            self.window.rootViewController = fingerVC;
            [self.window makeKeyWindow];
        } else {
            self.window.rootViewController = fingerVC;
            [self.window makeKeyWindow];
        }
    }
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    OCMLog(@"applicationDidBecomeActive");
}
- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"OCM"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end

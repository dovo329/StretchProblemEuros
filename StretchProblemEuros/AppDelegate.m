//
//  AppDelegate.m
//  StretchProblemEuros
//
//  Created by Douglas Voss on 5/19/15.
//  Copyright (c) 2015 DougsApps. All rights reserved.
//

#import "AppDelegate.h"
#import "math.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (NSString *)getChange:(double) amount
{
    NSInteger left = roundf(amount*100.0);

    NSLog(@"2.00 left=%li", left);
    NSInteger coin2 = left/200;
    left = fmod(left, 200);
    
    NSLog(@"0.50 left=%li", left);
    NSInteger coinPt5 = left/50;
    left = fmod(left, 50);

    NSLog(@"0.10 left=%li", left);
    NSInteger coinPt1 = left/10;
    left = fmod(left, 10);

    NSLog(@"0.05 left=%li", left);
    NSInteger coinPt05 = left/5;
    left = fmod(left, 5);

    NSLog(@"0.02 left=%li", left);
    NSInteger coinPt02 = left/2;
    left = fmod(left, 2);

    NSLog(@"0.01 left=%li", left);
    NSInteger coinPt01 = left/1;
    
    return [NSString stringWithFormat:@"2.00: %li\n0.50: %li\n0.10: %li\n0.05: %li\n0.02: %li\n0.01: %li", coin2, coinPt5, coinPt1, coinPt05, coinPt02, coinPt01];
    
    /*double left = roundf(amount*100.0)/100.0;

    NSLog(@"2.00 left=%f", left);
    NSInteger coin2 = left/2.00;
    left = fmod(left, 2.00);
    
    NSLog(@"0.50 left=%f", left);
    NSInteger coinPt5 = left/0.50;
    left = fmod(left, 0.50);

    NSLog(@"0.10 left=%f", left);
    NSInteger coinPt1 = left/0.10;
    left = fmod(left, 0.10);

    NSLog(@"0.05 left=%f", left);
    NSInteger coinPt05 = left/0.05;
    left = fmod(left, 0.05);

    NSLog(@"0.02 left=%f", left);
    NSInteger coinPt02 = left/0.02;
    left = fmod(left, 0.019);

    NSLog(@"0.01 left=%f", left);
    NSInteger coinPt01 = left/0.01;
    
     return [NSString stringWithFormat:@"2.00: %li\n0.50: %li\n0.10: %li\n0.05: %li\n0.02: %li\n0.01: %li", coin2, coinPt5, coinPt1, coinPt05, coinPt02, coinPt01];*/
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    // Write a function that, given a Euro amount,  will return a string of the least amount of each coin to be given to match the amount passed in.
    // Inputs : 4.67
    // Output: 2  2coins,
    //          1 0.5 coin,
    //          1 0.1 coin,
    //          1 0.02 coin
    
    NSLog(@"4.67 change is \n%@", [self getChange:4.67]);
    
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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.dougsapps.StretchProblemEuros" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"StretchProblemEuros" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"StretchProblemEuros.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end

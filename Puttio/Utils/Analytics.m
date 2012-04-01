//
//  Analytics.m
//  Puttio
//
//  Created by orta therox on 01/04/2012.
//  Copyright (c) 2012 ortatherox.com. All rights reserved.
//

@implementation Analytics

#import "TestFlight.h"
#import "APP_SECRET.h"

+ (void)setup {
    [TestFlight takeOff: TESTFLIGHT_SECRET];
    
    #ifndef RELEASE 
    [TestFlight setDeviceIdentifier:[[UIDevice currentDevice] uniqueIdentifier]];
    #endif
}

+ (void)event:(NSString*)string, ...{
#ifndef TARGET_IPHONE_SIMULATOR
    if (string == nil) {
        NSLog(@"nil string in ARAnalytics::error");
        return;
    }
    va_list listOfArguments;
    va_start(listOfArguments, string);
    NSString* event = [[NSString alloc] initWithFormat:string arguments:listOfArguments];

    [TestFlight passCheckpoint:event];
#endif
}

+ (void)event:(NSString *)event withOptionString:(NSString *)message {
#ifndef TARGET_IPHONE_SIMULATOR
    [TestFlight passCheckpoint:[NSString stringWithFormat:@"%@ - %@", event, message]];
#endif
}

+ (void)error:(NSString*)string, ...{
#ifndef TARGET_IPHONE_SIMULATOR
    if (string == nil) {
        NSLog(@"nil string in ARAnalytics::error");
        return;
    }
    va_list listOfArguments;
    va_start(listOfArguments, string);
    NSString* error = [[NSString alloc] initWithFormat:string arguments:listOfArguments];
    
    [TestFlight passCheckpoint:error];
#endif
}

+ (void)addCustomValue:(NSString*)value forKey:(NSString*)key {
#ifndef TARGET_IPHONE_SIMULATOR
    [TestFlight addCustomEnvironmentInformation:value forKey:key];
#endif
}

@end

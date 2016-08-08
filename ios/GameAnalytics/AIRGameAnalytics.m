/**
 * Copyright 2016 Marcel Piestansky (http://marpies.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "AIRGameAnalytics.h"
#import "Functions/InitFunction.h"
#import "Functions/AddResourceEventFunction.h"
#import "Functions/AddProgressionEventFunction.h"
#import "Functions/AddDesignEventFunction.h"
#import "Functions/AddErrorEventFunction.h"
#import "Functions/AddBusinessEventFunction.h"
#import "Functions/SetDimensionFunction.h"
#import "Functions/GetAdvertisingIdFunction.h"
#import "Functions/GetLimitedAdTrackingFunction.h"

static BOOL GALogEnabled = NO;
FREContext GAExtensionContext = nil;

@implementation AIRGameAnalytics

+ (void) dispatchEvent:(const NSString*) eventName {
    [self dispatchEvent:eventName withMessage:@""];
}

+ (void) dispatchEvent:(const NSString*) eventName withMessage:(NSString*) message {
    NSString* messageText = message ? message : @"";
    FREDispatchStatusEventAsync( GAExtensionContext, (const uint8_t*) [eventName UTF8String], (const uint8_t*) [messageText UTF8String] );
}

+ (void) log:(const NSString*) message {
    if( GALogEnabled ) {
        NSLog( @"[iOS-GameAnalytics] %@", message );
    }
}

+ (void) showLogs:(BOOL) showLogs {
    GALogEnabled = showLogs;
}

@end

/**
 *
 *
 * Context initialization
 *
 *
 **/

FRENamedFunction AIRGameAnalytics_extFunctions[] = {
    { (const uint8_t*) "init",                 0, ga_init },
    { (const uint8_t*) "addResourceEvent",     0, ga_addResourceEvent },
    { (const uint8_t*) "addProgressionEvent",  0, ga_addProgressionEvent },
    { (const uint8_t*) "addDesignEvent",       0, ga_addDesignEvent },
    { (const uint8_t*) "addErrorEvent",        0, ga_addErrorEvent },
    { (const uint8_t*) "addBusinessEvent",     0, ga_addBusinessEvent },
    { (const uint8_t*) "setDimension",         0, ga_setDimension },
    { (const uint8_t*) "getAdvertisingId",     0, ga_getAdvertisingId },
    { (const uint8_t*) "getLimitedAdTracking", 0, ga_getLimitedAdTracking }
};

void GameAnalyticsContextInitializer( void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet ) {
    *numFunctionsToSet = sizeof( AIRGameAnalytics_extFunctions ) / sizeof( FRENamedFunction );
    
    *functionsToSet = AIRGameAnalytics_extFunctions;
    
    GAExtensionContext = ctx;
}

void GameAnalyticsContextFinalizer( FREContext ctx ) { }

void GameAnalyticsInitializer( void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet ) {
    *extDataToSet = NULL;
    *ctxInitializerToSet = &GameAnalyticsContextInitializer;
    *ctxFinalizerToSet = &GameAnalyticsContextFinalizer;
}

void GameAnalyticsFinalizer( void* extData ) { }








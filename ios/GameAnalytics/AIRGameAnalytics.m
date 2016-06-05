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

void GameAnalyticsAddFunction( FRENamedFunction* array, const char* name, FREFunction function, uint32_t* index ) {
    array[(*index)].name = (const uint8_t*) name;
    array[(*index)].functionData = NULL;
    array[(*index)].function = function;
    (*index)++;
}

void GameAnalyticsContextInitializer( void* extData,
                                  const uint8_t* ctxType,
                                  FREContext ctx,
                                  uint32_t* numFunctionsToSet,
                                  const FRENamedFunction** functionsToSet ) {
    uint32_t numFunctions = 7;
    *numFunctionsToSet = numFunctions;
    
    FRENamedFunction* functionArray = (FRENamedFunction*) malloc( sizeof( FRENamedFunction ) * numFunctions );
    
    uint32_t index = 0;
    GameAnalyticsAddFunction( functionArray, "init", &init, &index );
    GameAnalyticsAddFunction( functionArray, "addResourceEvent", &addResourceEvent, &index );
    GameAnalyticsAddFunction( functionArray, "addProgressionEvent", &addProgressionEvent, &index );
    GameAnalyticsAddFunction( functionArray, "addDesignEvent", &addDesignEvent, &index );
    GameAnalyticsAddFunction( functionArray, "addErrorEvent", &addErrorEvent, &index );
    GameAnalyticsAddFunction( functionArray, "addBusinessEvent", &addBusinessEvent, &index );
    GameAnalyticsAddFunction( functionArray, "setDimension", &setDimension, &index );
    
    *functionsToSet = functionArray;
    
    GAExtensionContext = ctx;
}

void GameAnalyticsContextFinalizer( FREContext ctx ) { }

void GameAnalyticsInitializer( void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet ) {
    *extDataToSet = NULL;
    *ctxInitializerToSet = &GameAnalyticsContextInitializer;
    *ctxFinalizerToSet = &GameAnalyticsContextFinalizer;
}

void GameAnalyticsFinalizer( void* extData ) { }








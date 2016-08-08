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

#import "AddResourceEventFunction.h"
#import <AIRExtHelpers/MPFREObjectUtils.h>
#import "GameAnalytics.h"

GAResourceFlowType ga_getFlowType( int flowType ) {
    if( flowType == 1 ) {
        return GAResourceFlowTypeSource;
    }
    return GAResourceFlowTypeSink;
}

FREObject ga_addResourceEvent( FREContext context, void* functionData, uint32_t argc, FREObject argv[] ) {
    GAResourceFlowType flowType = ga_getFlowType( [MPFREObjectUtils getInt:argv[0]] );
    NSString* currency = [MPFREObjectUtils getNSString:argv[1]];
    double amount = [MPFREObjectUtils getDouble:argv[2]];
    NSString* itemType = [MPFREObjectUtils getNSString:argv[3]];
    NSString* itemId = [MPFREObjectUtils getNSString:argv[4]];

    [GameAnalytics addResourceEventWithFlowType:flowType currency:currency amount:[NSNumber numberWithDouble:amount] itemType:itemType itemId:itemId];
    
    return nil;
}
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
#import "InitFunction.h"
#import <AIRExtHelpers/MPFREObjectUtils.h>
#import "GameAnalytics.h"
#import "GameAnalyticsConfigHelper.h"

FREObject ga_init( FREContext context, void* functionData, uint32_t argc, FREObject argv[] ) {
    FREObject config = argv[0];
    
    /* Get show logs */
    FREObject freShowLogs;
    if( FREGetObjectProperty( config, (const uint8_t*) "showLogs\0", &freShowLogs, NULL ) != FRE_OK ) {
        return [MPFREObjectUtils getFREObjectFromBOOL:NO];
    }
    BOOL showLogs = [MPFREObjectUtils getBOOL:freShowLogs];
    [AIRGameAnalytics showLogs:showLogs];
    [GameAnalytics setEnabledInfoLog:showLogs];
    
    /* Configure the native GameAnalytics */
    if( ![GameAnalyticsConfigHelper parseFREObject:config] ) {
        return [MPFREObjectUtils getFREObjectFromBOOL:NO];
    }
    
    [AIRGameAnalytics log:@"GameAnalytics init success"];
    
    [GameAnalytics initializeWithConfiguredGameKeyAndGameSecret];
    
    return [MPFREObjectUtils getFREObjectFromBOOL:YES];
}











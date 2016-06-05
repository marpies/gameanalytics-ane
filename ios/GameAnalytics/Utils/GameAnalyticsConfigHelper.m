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

#import "GameAnalyticsConfigHelper.h"
#import "GameAnalytics.h"
#import "AIRGameAnalytics.h"
#import <AIRExtHelpers/MPFREObjectUtils.h>

@implementation GameAnalyticsConfigHelper

+ (BOOL) parseFREObject:(FREObject) config {
    /* Get build */
    FREObject build;
    if( FREGetObjectProperty( config, (const uint8_t*) "buildiOS\0", &build, NULL ) != FRE_OK ) {
        return NO;
    }
    /* Get game key */
    FREObject gameKey;
    if( FREGetObjectProperty( config, (const uint8_t*) "gameKeyiOS\0", &gameKey, NULL ) != FRE_OK ) {
        return NO;
    }
    /* Get game secret */
    FREObject gameSecret;
    if( FREGetObjectProperty( config, (const uint8_t*) "gameSecretiOS\0", &gameSecret, NULL ) != FRE_OK ) {
        return NO;
    }
    
    /* Configure game analytics */
    [GameAnalytics configureBuild:[MPFREObjectUtils getNSString:build]];
    [GameAnalytics configureGameKey:[MPFREObjectUtils getNSString:gameKey] gameSecret:[MPFREObjectUtils getNSString:gameSecret]];
    
    /* Get resource currencies */
    FREObject resourceCurrencies;
    if( FREGetObjectProperty( config, (const uint8_t*) "resourceCurrencies\0", &resourceCurrencies, NULL ) != FRE_OK ) {
        return NO;
    }
    if( ![self isFRENull:resourceCurrencies] ) {
        [GameAnalytics configureAvailableResourceCurrencies:[MPFREObjectUtils getNSArray:resourceCurrencies]];
    }
    
    /* Get resource item types */
    FREObject resourceItemTypes;
    if( FREGetObjectProperty( config, (const uint8_t*) "resourceItemTypes\0", &resourceItemTypes, NULL ) != FRE_OK ) {
        return NO;
    }
    if( ![self isFRENull:resourceItemTypes] ) {
        [GameAnalytics configureAvailableResourceItemTypes:[MPFREObjectUtils getNSArray:resourceItemTypes]];
    }
    
    /* Get custom dimensions 01 */
    FREObject customDimensions01;
    if( FREGetObjectProperty( config, (const uint8_t*) "customDimensions01\0", &customDimensions01, NULL ) != FRE_OK ) {
        return NO;
    }
    if( ![self isFRENull:customDimensions01] ) {
        [GameAnalytics configureAvailableCustomDimensions01:[MPFREObjectUtils getNSArray:customDimensions01]];
    }
    
    /* Get custom dimensions 02 */
    FREObject customDimensions02;
    if( FREGetObjectProperty( config, (const uint8_t*) "customDimensions02\0", &customDimensions02, NULL ) != FRE_OK ) {
        return NO;
    }
    if( ![self isFRENull:customDimensions02] ) {
        [GameAnalytics configureAvailableCustomDimensions02:[MPFREObjectUtils getNSArray:customDimensions02]];
    }
    
    /* Get custom dimensions 03 */
    FREObject customDimensions03;
    if( FREGetObjectProperty( config, (const uint8_t*) "customDimensions03\0", &customDimensions03, NULL ) != FRE_OK ) {
        return NO;
    }
    if( ![self isFRENull:customDimensions03] ) {
        [GameAnalytics configureAvailableCustomDimensions03:[MPFREObjectUtils getNSArray:customDimensions03]];
    }
    
    return YES;
}

+ (BOOL) isFRENull:(FREObject) object {
    FREObjectType type;
    FREGetObjectType( object, &type );
    return type == FRE_TYPE_NULL;
}

@end

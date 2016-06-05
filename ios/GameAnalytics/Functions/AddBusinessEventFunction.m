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

#import "AddBusinessEventFunction.h"
#import <AIRExtHelpers/MPFREObjectUtils.h>
#import "GameAnalytics.h"

FREObject addBusinessEvent( FREContext context, void* functionData, uint32_t argc, FREObject argv[] ) {
    NSString* currency = [MPFREObjectUtils getNSString:argv[0]];
    int amount = [MPFREObjectUtils getInt:argv[1]];
    NSString* itemType = [MPFREObjectUtils getNSString:argv[2]];
    NSString* itemId = [MPFREObjectUtils getNSString:argv[3]];
    NSString* cartType = [MPFREObjectUtils getNSString:argv[4]];
    NSString* receipt = (argv[5] == nil) ? nil : [MPFREObjectUtils getNSString:argv[5]];
    // argv[6] is a signature, used on Android only
    BOOL autoFetchReceipt = [MPFREObjectUtils getBOOL:argv[7]];
    
    if( receipt == nil ) {
        [GameAnalytics addBusinessEventWithCurrency:currency amount:amount itemType:itemType itemId:itemId cartType:cartType autoFetchReceipt:autoFetchReceipt];
    } else {
        [GameAnalytics addBusinessEventWithCurrency:currency amount:amount itemType:itemType itemId:itemId cartType:cartType receipt:receipt];
    }
    
    return nil;
}
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

#import "AddProgressionEventFunction.h"
#import <AIRExtHelpers/MPFREObjectUtils.h>
#import "GameAnalytics.h"

GAProgressionStatus getProgressionStatus( int status ) {
    if( status == 2 ) {
        return GAProgressionStatusComplete;
    } else if( status == 1 ) {
        return GAProgressionStatusStart;
    }
    return GAProgressionStatusFail;
}

FREObject addProgressionEvent( FREContext context, void* functionData, uint32_t argc, FREObject argv[] ) {
    GAProgressionStatus status = getProgressionStatus( [MPFREObjectUtils getInt:argv[0]] );
    NSString* progression01 = [MPFREObjectUtils getNSString:argv[1]];
    NSString* progression02 = (argv[2] == nil) ? nil : [MPFREObjectUtils getNSString:argv[2]];
    NSString* progression03 = (argv[3] == nil) ? nil : [MPFREObjectUtils getNSString:argv[3]];
    int score = [MPFREObjectUtils getInt:argv[4]];
    
    /* Do not track score if the value is lte to zero */
    if( score <= 0 ) {
        [GameAnalytics addProgressionEventWithProgressionStatus:status progression01:progression01 progression02:progression02 progression03:progression03];
    } else {
        [GameAnalytics addProgressionEventWithProgressionStatus:status progression01:progression01 progression02:progression02 progression03:progression03 score:score];
    }
    
    
    
    return nil;
}
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

#import "AddErrorEventFunction.h"
#import <AIRExtHelpers/MPFREObjectUtils.h>
#import "GameAnalytics.h"

GAErrorSeverity getErrorSeverity( int severity ) {
    switch( severity ) {
        case 1:
            return GAErrorSeverityDebug;
        case 3:
            return GAErrorSeverityWarning;
        case 4:
            return GAErrorSeverityError;
        case 5:
            return GAErrorSeverityCritical;
        default:
            return GAErrorSeverityInfo;
    }
}

FREObject addErrorEvent( FREContext context, void* functionData, uint32_t argc, FREObject argv[] ) {
    GAErrorSeverity severity = getErrorSeverity( [MPFREObjectUtils getInt:argv[0]] );
    NSString* message = (argv[1] == nil) ? nil : [MPFREObjectUtils getNSString:argv[1]];
    
    [GameAnalytics addErrorEventWithSeverity:severity message:message];
    
    return nil;
}
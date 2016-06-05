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

#import "SetDimensionFunction.h"
#import <AIRExtHelpers/MPFREObjectUtils.h>
#import "GameAnalytics.h"

FREObject setDimension( FREContext context, void* functionData, uint32_t argc, FREObject argv[] ) {
    NSString* value = (argv[0] == nil) ? nil : [MPFREObjectUtils getNSString:argv[0]];
    int dimension = [MPFREObjectUtils getInt:argv[1]];
    
    switch( dimension ) {
        case 1:
            [GameAnalytics setCustomDimension01:value];
            break;
        case 2:
            [GameAnalytics setCustomDimension02:value];
            break;
        case 3:
            [GameAnalytics setCustomDimension03:value];
            break;
    }
    
    return nil;
}
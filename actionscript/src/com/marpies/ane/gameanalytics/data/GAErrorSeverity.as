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

package com.marpies.ane.gameanalytics.data {

    public class GAErrorSeverity {

        public static const DEBUG:int = 1;
        public static const INFO:int = 2;
        public static const WARNING:int = 3;
        public static const ERROR:int = 4;
        public static const CRITICAL:int = 5;

        /**
         * @private
         */
        public static function isValid( severity:int ):Boolean {
            switch( severity ) {
                case DEBUG:
                case INFO:
                case WARNING:
                case ERROR:
                case CRITICAL:
                    return true;
                default:
                    return false;
            }
        }

    }

}

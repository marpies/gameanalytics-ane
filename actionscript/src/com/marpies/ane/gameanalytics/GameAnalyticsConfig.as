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

package com.marpies.ane.gameanalytics {

    public class GameAnalyticsConfig {

        private var mShowLogs:Boolean;
        private var mBuildiOS:String;
        private var mBuildAndroid:String;
        private var mGameKeyiOS:String;
        private var mGameSecretiOS:String;
        private var mGameKeyAndroid:String;
        private var mGameSecretAndroid:String;
        private var mResourceCurrencies:Vector.<String>;
        private var mResourceItemTypes:Vector.<String>;
        private var mCustomDimensions01:Vector.<String>;
        private var mCustomDimensions02:Vector.<String>;
        private var mCustomDimensions03:Vector.<String>;

        public function GameAnalyticsConfig() {
        }

        /**
         *
         *
         * Getters / Setters
         *
         *
         */

         /**
          * @private
          */
        public function get showLogs():Boolean {
            return mShowLogs;
        }

        /**
         * Set to <code>true</code> to enable native logs.
         */
        public function setShowLogs( value:Boolean ):GameAnalyticsConfig {
            mShowLogs = value;
            return this;
        }

        /**
         * @private
         */
        public function get buildiOS():String {
            return mBuildiOS;
        }

        /**
         * <strong>Required (iOS only)</strong>: Build is used to specify the current version of your game.
         * Recommended to use a 3 digit version like [major].[minor].[patch].
         */
        public function setBuildiOS( value:String ):GameAnalyticsConfig {
            mBuildiOS = value;
            return this;
        }

        /**
         * @private
         */
        public function get buildAndroid():String {
            return mBuildAndroid;
        }

        /**
         * <strong>Required (Android only)</strong>: Build is used to specify the current version of your game.
         * Recommended to use a 3 digit version like [major].[minor].[patch].
         */
        public function setBuildAndroid( value:String ):GameAnalyticsConfig {
            mBuildAndroid = value;
            return this;
        }

        /**
         * @private
         */
        public function get gameKeyiOS():String {
            return mGameKeyiOS;
        }

        /**
         * <strong>Required (iOS only)</strong>: Game key for your iOS game.
         */
        public function setGameKeyiOS( value:String ):GameAnalyticsConfig {
            mGameKeyiOS = value;
            return this;
        }

        /**
         * @private
         */
        public function get gameSecretiOS():String {
            return mGameSecretiOS;
        }

        /**
         * <strong>Required (iOS only)</strong>: Game secret for your iOS game.
         */
        public function setGameSecretiOS( value:String ):GameAnalyticsConfig {
            mGameSecretiOS = value;
            return this;
        }

        /**
         * @private
         */
        public function get gameKeyAndroid():String {
            return mGameKeyAndroid;
        }

        /**
         * <strong>Required (Android only)</strong>: Game key for your Android game.
         */
        public function setGameKeyAndroid( value:String ):GameAnalyticsConfig {
            mGameKeyAndroid = value;
            return this;
        }

        /**
         * @private
         */
        public function get gameSecretAndroid():String {
            return mGameSecretAndroid;
        }

        /**
         * <strong>Required (Android only)</strong>: Game secret for your Android game.
         */
        public function setGameSecretAndroid( value:String ):GameAnalyticsConfig {
            mGameSecretAndroid = value;
            return this;
        }

        /**
         * @private
         */
        public function get resourceCurrencies():Vector.<String> {
            return mResourceCurrencies;
        }

        /**
         * Resource currencies available in your game, for example <code>gems</code>, <code>coins</code>...
         *
         * @see com.marpies.ane.gameanalytics.GameAnalytics#addResourceEvent
         */
        public function setResourceCurrencies( value:Vector.<String> ):GameAnalyticsConfig {
            mResourceCurrencies = value;
            return this;
        }

        /**
         * @private
         */
        public function get resourceItemTypes():Vector.<String> {
            return mResourceItemTypes;
        }

        /**
         * Resource item types available in your game, for example <code>boost</code>, <code>lives</code>...
         *
         * @see com.marpies.ane.gameanalytics.GameAnalytics#addResourceEvent
         */
        public function setResourceItemTypes( value:Vector.<String> ):GameAnalyticsConfig {
            mResourceItemTypes = value;
            return this;
        }

        /**
         * @private
         */
        public function get customDimensions01():Vector.<String> {
            return mCustomDimensions01;
        }

        /**
         * List of 'tags' which you can assign to each player.
         *
         * @see http://www.gameanalytics.com/docs/custom-dimensions
         */
        public function setCustomDimensions01( value:Vector.<String> ):GameAnalyticsConfig {
            mCustomDimensions01 = value;
            return this;
        }

        /**
         * @private
         */
        public function get customDimensions02():Vector.<String> {
            return mCustomDimensions02;
        }

        /**
         * List of 'tags' which you can assign to each player.
         *
         * @see http://www.gameanalytics.com/docs/custom-dimensions
         */
        public function setCustomDimensions02( value:Vector.<String> ):GameAnalyticsConfig {
            mCustomDimensions02 = value;
            return this;
        }

        /**
         * @private
         */
        public function get customDimensions03():Vector.<String> {
            return mCustomDimensions03;
        }

        /**
         * List of 'tags' which you can assign to each player.
         *
         * @see http://www.gameanalytics.com/docs/custom-dimensions
         */
        public function setCustomDimensions03( value:Vector.<String> ):GameAnalyticsConfig {
            mCustomDimensions03 = value;
            return this;
        }

        /**
         * @private
         */
        public function get isValid():Boolean {
            return (mBuildiOS !== null) && (((mGameKeyiOS !== null) && (mGameSecretiOS !== null)) || ((mGameKeyAndroid !== null) && (mGameSecretAndroid !== null)));
        }

    }

}

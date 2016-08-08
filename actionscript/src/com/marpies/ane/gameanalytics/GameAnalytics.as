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

    import com.marpies.ane.gameanalytics.data.GAErrorSeverity;
    import com.marpies.ane.gameanalytics.data.GAProgressionStatus;
    import com.marpies.ane.gameanalytics.data.GAResourceFlowType;

    import flash.desktop.NativeApplication;
    import flash.events.InvokeEvent;
    import flash.events.StatusEvent;
    import flash.external.ExtensionContext;
    import flash.system.Capabilities;
    import flash.utils.Dictionary;

    public class GameAnalytics {

        private static const TAG:String = "[GameAnalytics]";
        private static const EXTENSION_ID:String = "com.marpies.ane.gameanalytics";

        private static var mContext:ExtensionContext;

        /* Config */
        private static const CONFIG:GameAnalyticsConfig = new GameAnalyticsConfig();

        /* Misc */
        private static const iOS:Boolean = Capabilities.manufacturer.indexOf( "iOS" ) > -1;
        private static const Android:Boolean = Capabilities.manufacturer.indexOf( "Android" ) > -1;
        private static var mInitialized:Boolean;

        /**
         * @private
         * Do not use. GameAnalytics is a static class.
         */
        public function GameAnalytics() {
            throw Error( "GameAnalytics is static class." );
        }

        /**
         *
         *
         * Public API
         *
         *
         */

        /**
         * Initializes extension context and GameAnalytics native library.
         *
         * @return <code>true</code> if the analytics were successfully initialized, <code>false</code> otherwise.
         */
        public static function init():Boolean {
            if( !isSupported ) return false;
            if( mInitialized ) return true;

            if( !config.isValid ) throw new Error( "GameAnalytics is not configured correctly. Use GameAnalytics.config to set build, gameKey and gameSecret." );

            /* Initialize context */
            mContext = ExtensionContext.createExtensionContext( EXTENSION_ID, null );
            if( !mContext ) {
                log( "Error creating extension context for " + EXTENSION_ID );
                return false;
            }

            /* Call init */
            mInitialized = mContext.call( "init", config ) as Boolean;
            return mInitialized;
        }

        /**
         * Resource events are used to register the flow of your in-game economy (virtual currencies)
         * - the sink (subtract) and the source (add) for each virtual currency.
         *
         * <p>Before calling the resource event it is needed to specify what discrete values can be used
         * for currencies and item types in the config.</p>
         *
         * <p><strong>
         * Be careful to not call the resource event too often!
         * In a game where the user collect coins fairly fast you should not call a Source event on each pickup.
         * Instead you should count the coins and send a single Source event when the user either complete or fail the level.
         * </strong></p>
         *
         * @param flowType  A defined enum from <code>GAResourceFlowType</code> class for sourcing and sinking resources.
         * @param currency  The resource type/currency to track. Has to be one of the configured available
         *                  resource currencies. This string can only contain [A-Za-z] characters.
         * @param amount    Amount sourced or sinked. 0 or negative numbers are not allowed.
         * @param itemType  For sink events it can describe an item category you are buying (Weapons)
         *                  or a place (Gameplay) the currency was consumed. For source events it can describe
         *                  how the currency was gained. For example "IAP" (for in-app purchase) or from using
         *                  another currency (Gems). Has to be one of the configured available itemTypes.
         * @param itemId    For sink events it can describe the specific item (SwordOfFire) gained.
         *                  If consumed during Gameplay you can simply use "Consumed". For source events it
         *                  describes how the player got the added currency. This could be buying a pack (BoosterPack5)
         *                  or earned through Gameplay when completing a level (LevelEnd).
         *
         * @see com.marpies.ane.gameanalytics.data.GAResourceFlowType
         * @see http://www.gameanalytics.com/docs/ga-data#resource-event-ie-virtual-currencies
         */
        public static function addResourceEvent( flowType:int, currency:String, amount:Number, itemType:String, itemId:String ):void {
            if( !isSupported ) return;
            validateExtensionContext();

            if( !GAResourceFlowType.isValid( flowType ) ) throw new ArgumentError( "Parameter flowType must be one of the values defined in class GAResourceFlowType." );

            mContext.call( "addResourceEvent", flowType, currency, amount, itemType, itemId );
        }

        /**
         * Progression events are used to track attempts at completing some part of a game (level, area).
         * A defined area follow a 3 tier hierarchy structure (could be world:stage:level) to indicate
         * what part of the game the player is trying to complete.
         *
         * @param status        Status of added progression. One of the values defined in <code>GAProgressionStatus</code>.
         * @param progression01 Required progression location.
         * @param progression02 Optional progression location.
         * @param progression03 Optional progression location.
         * @param score         An optional score when a user <strong>completes</strong> or <strong>fails</strong> a progression attempt.
         *
         * @see com.marpies.ane.gameanalytics.data.GAProgressionStatus
         * @see http://www.gameanalytics.com/docs/ga-data#progression-event
         */
        public static function addProgressionEvent( status:int, progression01:String, progression02:String = null, progression03:String = null, score:int = 0 ):void {
            if( !isSupported ) return;
            validateExtensionContext();

            if( !GAProgressionStatus.isValid( status ) ) throw new ArgumentError( "Parameter status must be one of the values defined in class GAProgressionStatus." );

            if( progression01 === null ) throw new ArgumentError( "Parameter progression01 cannot be null." );

            mContext.call( "addProgressionEvent", status, progression01, progression02, progression03, score );
        }

        /**
         * The design event is available for you to add your own eventId hierarchy.
         *
         * @param eventId Hierarchy string that can consist of 1-5 segments separated by ':'.
         *                Each segment can have a max length of 32.
         * @param value   A float event tied to the eventId. Will result in sum and mean values being available.
         *
         * @see http://www.gameanalytics.com/docs/ga-data#design-event
         * @see http://www.gameanalytics.com/docs/custom-events
         */
        public static function addDesignEvent( eventId:String, value:Number = 0 ):void {
            if( !isSupported ) return;
            validateExtensionContext();

            if( eventId === null ) throw new ArgumentError( "Parameter eventId cannot be null." );

            mContext.call( "addDesignEvent", eventId, value );
        }

        /**
         * Used to track custom error events in the game. You can group the events by severity level and attach a message.
         *
         * @param severity Severity of error. One of the values defined in <code>GAErrorSeverity</code>.
         * @param message  Optional error message.
         *
         * @see com.marpies.ane.gameanalytics.data.GAErrorSeverity
         * @see http://www.gameanalytics.com/docs/ga-data#error-event
         */
        public static function addErrorEvent( severity:int, message:String = null ):void {
            if( !isSupported ) return;
            validateExtensionContext();

            if( !GAErrorSeverity.isValid( severity ) ) throw new ArgumentError( "Parameter severity must be one of the values defined in class GAErrorSeverity." );

            mContext.call( "addErrorEvent", severity, message );
        }

        /**
         * Business events are used to track in-game transactions using real money.
         * Trigger this event when an in-app purchase is completed.
         *
         * @param currency          Currency code in ISO 4217 format.
         * @param amount            Amount in <strong>cents</strong>.
         * @param itemType          The type / category of the item.
         * @param itemId            Specific item bought.
         * @param cartType          The game location of the purchase. Max 10 unique values.
         * @param receipt           The transaction receipt.
         * @param signature         <strong>Android only</strong>: If the signature is <code>null</code> then it will
         *                          be submitted to the GA server but will register as not validated.
         * @param autoFetchReceipt  <strong>iOS 7+ only</strong>: If the receipt is <code>null</code>, it is possible
         *                          to let the SDK retrieve the receipt automatically when called directly after
         *                          a successful in-app purchase.
         *
         * @see http://www.gameanalytics.com/docs/ga-data#business-event
         * @see http://www.gameanalytics.com/docs/purchase-validation
         * @see http://openexchangerates.org/currencies.json
         */
        public static function addBusinessEvent( currency:String, amount:int, itemType:String, itemId:String, cartType:String, receipt:String = null, signature:String = null, autoFetchReceipt:Boolean = true ):void {
            if( !isSupported ) return;
            validateExtensionContext();

            if( currency === null ) throw new ArgumentError( "Parameter currency cannot be null." );
            if( itemType === null ) throw new ArgumentError( "Parameter itemType cannot be null." );
            if( itemId === null ) throw new ArgumentError( "Parameter itemId cannot be null." );
            if( cartType === null ) throw new ArgumentError( "Parameter cartType cannot be null." );

            mContext.call( "addBusinessEvent", currency, amount, itemType, itemId, cartType, receipt, signature, autoFetchReceipt );
        }

        /**
         * You can tag your players with any piece of information that might help you in your analysis.
         *
         * @param value One of the available dimension values set in the config.
         *              Will persist cross session. Set to <code>null</code> to reset.
         *
         * @see http://www.gameanalytics.com/docs/custom-dimensions
         */
        public static function setDimension01( value:String ):void {
            setDimensionInternal( value, 1 );
        }

        /**
         * You can tag your players with any piece of information that might help you in your analysis.
         *
         * @param value One of the available dimension values set in the config.
         *              Will persist cross session. Set to <code>null</code> to reset.
         *
         * @see http://www.gameanalytics.com/docs/custom-dimensions
         */
        public static function setDimension02( value:String ):void {
            setDimensionInternal( value, 2 );
        }

        /**
         * You can tag your players with any piece of information that might help you in your analysis.
         *
         * @param value One of the available dimension values set in the config.
         *              Will persist cross session. Set to <code>null</code> to reset.
         *
         * @see http://www.gameanalytics.com/docs/custom-dimensions
         */
        public static function setDimension03( value:String ):void {
            setDimensionInternal( value, 3 );
        }

        /**
         * Disposes native extension context.
         */
        public static function dispose():void {
            if( !isSupported || !mInitialized ) return;

            mContext.dispose();
            mContext = null;
        }

        /**
         *
         *
         * Getters / Setters
         *
         *
         */

        /**
         * Config object to specify necessary GameAnalytics values. Corresponding values must
         * be set before calling <code>GameAnalytics.init()</code>.
         */
        public static function get config():GameAnalyticsConfig {
            return CONFIG;
        }

        /**
         * Version of the extension.
         */
        public static function get version():String {
            return "1.1.0";
        }

        /**
         * Supported on iOS and Android.
         */
        public static function get isSupported():Boolean {
            return iOS || Android;
        }

        /**
         * Boolean whether the GameAnalytics SDK is initialized.
         */
        public static function get isInitialized():Boolean {
            return mInitialized;
        }

        /**
         *
         *
         * Private API
         *
         *
         */

        private static function setDimensionInternal( value:String, dimension:int ):void {
            if( !isSupported ) return;
            validateExtensionContext();

            mContext.call( "setDimension", value, dimension );
        }

        private static function validateExtensionContext():void {
            if( !mInitialized ) throw new Error( "GameAnalytics extension was not initialized. Call init() first." );
        }

        private static function log( message:String ):void {
            if( config.showLogs ) {
                trace( TAG, message );
            }
        }

    }
}

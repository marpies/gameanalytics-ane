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

package com.marpies.ane.gameanalytics.functions;

import com.adobe.fre.*;
import com.gameanalytics.sdk.GameAnalytics;
import com.marpies.ane.gameanalytics.utils.AIR;
import com.marpies.ane.gameanalytics.utils.FREObjectUtils;

import java.util.List;

public class InitFunction extends BaseFunction {

	@Override
	public FREObject call( FREContext context, FREObject[] args ) {
		super.call( context, args );

		try {
			FREObject config = args[0];
			/* Logs */
			boolean showLogs = FREObjectUtils.getBoolean( config.getProperty( "showLogs" ) );
			AIR.setLogEnabled( showLogs );
			GameAnalytics.setEnabledInfoLog( showLogs );
			/* Get config properties */
			String build = FREObjectUtils.getString( config.getProperty( "buildAndroid" ) );
			String gameKey = FREObjectUtils.getString( config.getProperty( "gameKeyAndroid" ) );
			String gameSecret = FREObjectUtils.getString( config.getProperty( "gameSecretAndroid" ) );
			List<String> resourceCurrencies = FREObjectUtils.getListOfString( (FREArray) config.getProperty( "resourceCurrencies" ) );
			List<String> resourceItemTypes = FREObjectUtils.getListOfString( (FREArray) config.getProperty( "resourceItemTypes" ) );
			List<String> customDimensions01 = FREObjectUtils.getListOfString( (FREArray) config.getProperty( "customDimensions01" ) );
			List<String> customDimensions02 = FREObjectUtils.getListOfString( (FREArray) config.getProperty( "customDimensions02" ) );
			List<String> customDimensions03 = FREObjectUtils.getListOfString( (FREArray) config.getProperty( "customDimensions03" ) );
			/* Configure GameAnalytics */
			GameAnalytics.configureBuild( build );
			if( resourceCurrencies != null ) {
				GameAnalytics.configureAvailableResourceCurrencies( resourceCurrencies.toArray( new String[0] ) );
			}
			if( resourceItemTypes != null ) {
				GameAnalytics.configureAvailableResourceItemTypes( resourceItemTypes.toArray( new String[0] ) );
			}
			if( customDimensions01 != null ) {
				GameAnalytics.configureAvailableCustomDimensions01( customDimensions01.toArray( new String[0] ) );
			}
			if( customDimensions02 != null ) {
				GameAnalytics.configureAvailableCustomDimensions02( customDimensions02.toArray( new String[0] ) );
			}
			if( customDimensions03 != null ) {
				GameAnalytics.configureAvailableCustomDimensions03( customDimensions03.toArray( new String[0] ) );
			}
			GameAnalytics.initializeWithGameKey( AIR.getContext().getActivity(), gameKey, gameSecret );
			return FREObject.newObject( true );
		} catch( Exception e ) {
			e.printStackTrace();
			try {
				return FREObject.newObject( false );
			} catch( FREWrongThreadException e1 ) {
				e1.printStackTrace();
			}
		}

		return null;
	}

}

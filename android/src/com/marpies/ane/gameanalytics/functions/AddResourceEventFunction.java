/*
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

import com.adobe.fre.FREContext;
import com.adobe.fre.FREObject;
import com.gameanalytics.sdk.GAResourceFlowType;
import com.gameanalytics.sdk.GameAnalytics;
import com.marpies.ane.gameanalytics.utils.FREObjectUtils;

public class AddResourceEventFunction extends BaseFunction {

	@Override
	public FREObject call( FREContext context, FREObject[] args ) {
		super.call( context, args );

		GAResourceFlowType flowType = getFlowType( FREObjectUtils.getInt( args[0] ) );
		String currency = FREObjectUtils.getString( args[1] );
		float amount = FREObjectUtils.getDouble( args[2] ).floatValue();
		String itemType = FREObjectUtils.getString( args[3] );
		String itemId = FREObjectUtils.getString( args[4] );
		GameAnalytics.addResourceEventWithFlowType( flowType, currency, amount, itemType, itemId );

		return null;
	}

	private GAResourceFlowType getFlowType( int flowType ) {
		if( flowType == 1 ) {
			return GAResourceFlowType.Source;
		}
		return GAResourceFlowType.Sink;
	}

}


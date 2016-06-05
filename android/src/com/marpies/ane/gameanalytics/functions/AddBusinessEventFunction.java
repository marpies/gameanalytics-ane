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
import com.gameanalytics.sdk.GameAnalytics;
import com.marpies.ane.gameanalytics.utils.FREObjectUtils;

public class AddBusinessEventFunction extends BaseFunction {

	@Override
	public FREObject call( FREContext context, FREObject[] args ) {
		super.call( context, args );

		String currency = FREObjectUtils.getString( args[0] );
		int amount = FREObjectUtils.getInt( args[1] );
		String itemType = FREObjectUtils.getString( args[2] );
		String itemId = FREObjectUtils.getString( args[3] );
		String cartType = FREObjectUtils.getString( args[4] );
		String receipt = (args[5] == null) ? "" : FREObjectUtils.getString( args[5] );
		String signature = (args[6] == null) ? "" : FREObjectUtils.getString( args[6] );
		// args[7] is autoFetchReceipt used on iOS only

		GameAnalytics.addBusinessEventWithCurrency( currency, amount, itemType, itemId, cartType, receipt, "google_play", signature );

		return null;
	}

}


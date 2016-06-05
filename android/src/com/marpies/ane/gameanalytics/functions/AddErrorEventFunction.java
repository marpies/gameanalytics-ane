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
import com.gameanalytics.sdk.GAErrorSeverity;
import com.gameanalytics.sdk.GameAnalytics;
import com.marpies.ane.gameanalytics.utils.FREObjectUtils;

public class AddErrorEventFunction extends BaseFunction {

	@Override
	public FREObject call( FREContext context, FREObject[] args ) {
		super.call( context, args );

		GAErrorSeverity severity = getSeverity( FREObjectUtils.getInt( args[0] ) );
		String message = (args[1] == null) ? "" : FREObjectUtils.getString( args[1] );

		GameAnalytics.addErrorEventWithSeverity( severity, message );

		return null;
	}

	private GAErrorSeverity getSeverity( int severity ) {
		switch( severity ) {
			case 1:
				return GAErrorSeverity.Debug;
			case 3:
				return GAErrorSeverity.Warning;
			case 4:
				return GAErrorSeverity.Error;
			case 5:
				return GAErrorSeverity.Critical;
			default:
				return GAErrorSeverity.Info;
		}
	}

}


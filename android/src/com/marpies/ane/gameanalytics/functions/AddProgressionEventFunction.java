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
import com.gameanalytics.sdk.GAProgressionStatus;
import com.gameanalytics.sdk.GameAnalytics;
import com.marpies.ane.gameanalytics.utils.FREObjectUtils;

public class AddProgressionEventFunction extends BaseFunction {

	@Override
	public FREObject call( FREContext context, FREObject[] args ) {
		super.call( context, args );

		GAProgressionStatus status = getProgressionStatus( FREObjectUtils.getInt( args[0] ) );
		String progression01 = FREObjectUtils.getString( args[1] );
		String progression02 = (args[2] == null) ? "" : FREObjectUtils.getString( args[2] );
		String progression03 = (args[2] == null) ? "" : FREObjectUtils.getString( args[3] );
		int score = FREObjectUtils.getInt( args[4] );

		GameAnalytics.addProgressionEventWithProgressionStatus( status, progression01, progression02, progression03, score );

		return null;
	}

	private GAProgressionStatus getProgressionStatus( int status ) {
		if( status == 2 ) {
			return GAProgressionStatus.Complete;
		} else if( status == 1 ) {
			return GAProgressionStatus.Start;
		}
		return GAProgressionStatus.Fail;
	}

}


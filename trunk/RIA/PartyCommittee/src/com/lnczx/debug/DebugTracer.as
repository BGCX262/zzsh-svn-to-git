package com.lnczx.debug
{
	import mx.logging.Log;
	import com.lnczx.debug.MiniDebugTarget;
	
	/**
	 * Initializes the <code>MiniDebugTarget</code> log target.
	 * @author ivanchoo
	 * 
	 */
	public class DebugTracer {
		
		static public function initalize(level:int = 0, filters:Array = null):void {
			var target:MiniDebugTarget = new MiniDebugTarget();
			if (filters) {
				target.filters = filters;
			} else {
				target.filters=["*"];
			}
			target.level = level;
			target.includeDate = true;
			target.includeTime = true;
			target.includeCategory = true;
			target.includeLevel = true;
			// Begin logging.
			Log.addTarget(target);
		}
		
		public function DebugTracer() {
		}

	}
}
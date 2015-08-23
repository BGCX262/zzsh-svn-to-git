package com.lnczx.debug
{
	import flash.utils.getQualifiedClassName;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	/**
	 * Debug utility that provides an easy way to send debug messages.
	 * @author ivanchoo
	 * 
	 */
	public class Debugger {
		
		/**
		 * 
		 */
		static public var enabled:Boolean = false;
		
		/**
		 * Logs the specified data using the <code>LogEventLevel.DEBUG</code> level.
		 * 
		 * @param sender Object that is sending the debug message
		 * @param msg The information to log.
	     *  This string can contain special marker characters of the form {x},
	     *  where x is a zero based index that will be replaced with
	     *  the additional parameters found at that index if specified.
		 * @param rest Additional parameters that can be subsituted in the str
	     *  parameter at each "{<code>x</code>}" location, where <code>x</code>
	     *  is an integer (zero based) index value into the Array of values
	     *  specified.
		 */
		static public function debug(sender:Object, msg:String, ... rest):void {
			if (enabled) {
				var _log:ILogger = Log.getLogger(getCategory(sender));
				_log.debug.apply(_log, [msg].concat(rest));
			}
		}
		
		/**
		 * Logs the specified data using the <code>LogEventLevel.ERROR</code> level.
		 * 
		 * @param sender Object that is sending the debug message
		 * @param msg The information to log.
	     *  This string can contain special marker characters of the form {x},
	     *  where x is a zero based index that will be replaced with
	     *  the additional parameters found at that index if specified.
		 * @param rest Additional parameters that can be subsituted in the str
	     *  parameter at each "{<code>x</code>}" location, where <code>x</code>
	     *  is an integer (zero based) index value into the Array of values
	     *  specified.
		 */
		static public function error(sender:Object, msg:String, ... rest):void {
			if (enabled) {
				var _log:ILogger = Log.getLogger(getCategory(sender));
				_log.error.apply(_log, [msg].concat(rest));
			}
		}

		/**
		 * Logs the specified data using the <code>LogEventLevel.FATAL</code> level.
		 * 
		 * @param sender Object that is sending the debug message
		 * @param msg The information to log.
	     *  This string can contain special marker characters of the form {x},
	     *  where x is a zero based index that will be replaced with
	     *  the additional parameters found at that index if specified.
		 * @param rest Additional parameters that can be subsituted in the str
	     *  parameter at each "{<code>x</code>}" location, where <code>x</code>
	     *  is an integer (zero based) index value into the Array of values
	     *  specified.
		 */
		static public function fatal(sender:Object, msg:String, ... rest):void {
			if (enabled) {
				var _log:ILogger = Log.getLogger(getCategory(sender));
				_log.fatal.apply(_log, [msg].concat(rest));
			}
		}

		/**
		 * Logs the specified data using the <code>LogEventLevel.INFO</code> level.
		 * 
		 * @param sender Object that is sending the debug message
		 * @param msg The information to log.
	     *  This string can contain special marker characters of the form {x},
	     *  where x is a zero based index that will be replaced with
	     *  the additional parameters found at that index if specified.
		 * @param rest Additional parameters that can be subsituted in the str
	     *  parameter at each "{<code>x</code>}" location, where <code>x</code>
	     *  is an integer (zero based) index value into the Array of values
	     *  specified.
		 */
		static public function info(sender:Object, msg:String, ... rest):void {
			if (enabled) {
				var _log:ILogger = Log.getLogger(getCategory(sender));
				_log.info.apply(_log, [msg].concat(rest));
			}
		}

		/**
		 * Logs the specified data using the <code>LogEventLevel.WARN</code> level.
		 * 
		 * @param sender Object that is sending the debug message
		 * @param msg The information to log.
	     *  This string can contain special marker characters of the form {x},
	     *  where x is a zero based index that will be replaced with
	     *  the additional parameters found at that index if specified.
		 * @param rest Additional parameters that can be subsituted in the str
	     *  parameter at each "{<code>x</code>}" location, where <code>x</code>
	     *  is an integer (zero based) index value into the Array of values
	     *  specified.
		 */
		static public function warn(sender:Object, msg:String, ... rest):void {
			if (enabled) {
				var _log:ILogger = Log.getLogger(getCategory(sender));
				_log.warn.apply(_log, [msg].concat(rest));
			}
		}
		
		static protected function getCategory(obj:Object):String {
			var cat:String = getQualifiedClassName(obj);
			return cat.replace(/\:\:/g, '.');
			
		}
		
		public function Debugger() {
			
		}

	}
}
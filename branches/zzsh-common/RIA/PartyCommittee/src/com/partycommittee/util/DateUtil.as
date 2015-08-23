package com.partycommittee.util
{
	public class DateUtil {
		public function DateUtil() {
		}
		
		public static function before(sourceDate:Date, targetDate:Date):Boolean {
			if (!sourceDate || !targetDate) {
				return false;
			}
			return targetDate.getTime() < sourceDate.getTime();
		}
		
		public static function after(sourceDate:Date, targetDate:Date):Boolean {
			if (!sourceDate || !targetDate) {
				return false;
			}
			return targetDate.getTime() > sourceDate.getTime();
		}
		
		public static function equal(sourceDate:Date, targetDate:Date):Boolean {
			if (!sourceDate || !targetDate) {
				return false;
			}
			return targetDate.getTime() == sourceDate.getTime();
		}
		
		public static function toISOString(date:Date, isDateTime:Boolean = false):String {
			if (!date) {
				return "";
			}
			if (isDateTime) {
				return date.getFullYear() + "-" + 
					fixString((date.getMonth() + 1)) + "-" + 
					fixString(date.getDate()) + " " + 
					fixString(date.getHours()) + ":" + 
					fixString(date.getMinutes()) + ":" + 
					fixString(date.getSeconds());
			} else {
				return date.getFullYear() + "-" + 
					fixString((date.getMonth() + 1)) + "-" + 
					fixString(date.getDate());
			}
		}
		
		public static function toDailyISOString(date:Date):String {
			if (!date) {
				return "";
			}
			return fixString(date.getHours()) + ":" + 
				fixString(date.getMinutes()) + ":" + 
				fixString(date.getSeconds());
		}
		
		public static function fixString(value:Number):String {
			if (value < 10) {
				return "0" + value;
			}
			return value + "";
		}
	}
}
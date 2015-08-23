package com.lnczx.utils {

	import mx.controls.Alert;
	import mx.utils.*;
	
	/**
	 * Another utility class for Date, modeled after the PHP PEAR::Date class.
	 * 
	 * @author ivanchoo
	 * 
	 */
	public class DateUtilExt {
	
		/**
		 * Indicates the begining of the week.
		 * 
		 * <p>0 is sunday, 1 is monday ...</p>
		 */
		public static var BEGIN_WEEKDAY:int = 1;
		
		
		private static var timezoneOffset:Number;
		private static var localOffset:int = 0;
		private static var serverTimeOffset_milli:Number = 0;
		
		/**
		 * Set the server time offset 
		 * 
		 * @param offset_milli the milli second from the server .
		 * 
		 */
		public static function setServerTimeOffset(offset_milli:Number):void {
			serverTimeOffset_milli = offset_milli;
		}
		
		/**
		 * Get the server offset 
		 * 
		 */
		public static function getServerTimeOffset():Number {
			return serverTimeOffset_milli;
		}
		
		
		/**
		 * Add server time offset by given date.
		 * 
		 */
		public static function addServerTimeOffset(date:Date):Date {
			date.setTime(date.time + serverTimeOffset_milli);
			return date;
		}
		  
		/**
		 * Sets the timezone offset globally.
		 * 
		 * <p>The offset is represented in milliseconds.</p>
		 * 
		 * @param offset 
		 * 
		 */
		public static function setTimezoneOffset(offset:Number):void {
			timezoneOffset = offset;
			var dte:Date = new Date();
			//	getTimezoneOffset() returns in hours, we convert to milliseconds and calc the local offset
			localOffset = (dte.getTimezoneOffset() * 60 * 1000) - timezoneOffset;
		}
		
		/**
		 * Returns the timezone offset.
		 * 
		 * @return 
		 * 
		 */
		public static function getTimezoneOffset():Number {
			if (isNaN(timezoneOffset)) {
				var dte:Date = new Date();
				setTimezoneOffset(dte.getTimezoneOffset() * 60 * 1000);
			}
			return timezoneOffset;
		}
		
		/**
		 * Returns a new Date instance of the current time against the timezone offset.
		 * 
		 * <p>Use this method to create new date instances of the current time, which
		 * includes the timezone offset set by <code>setTimezoneOffset()</code>.</p>
		 * 
		 * @return Date instance.
		 * 
		 */
		public static function now():Date {
			return addServerTimeOffset(new Date());
		}
		
		/**
		 * Adds the timezone offset to the given date.
		 * 
		 * <p>Use this method to add the timezone offset set by <code>setTimezoneOffset()</code>.</p>
		 * 
		 * <p>Note that the dte parameter and the returned Date object is the same instance.</p>
		 * 
		 * @param dte
		 * @return 
		 * 
		 */
		public static function addTimezoneOffset(dte:Date):Date {
			if (!isNaN(timezoneOffset)) {
				dte.setTime(dte.getTime() + localOffset);
			}
			return dte;
		}

		/**
		 * Clones a date.
		 * 
		 * @param dte
		 * @return 
		 * 
		 */
		public static function clone(dte:Date):Date {
			var dte2:Date = new Date();
			DateUtilExt.copy(dte, dte2);
			return dte2;
		}
		
		/**
		 * Creates a new Date from an ISO datetime YYYY-MM-DD HH:MM:SS string.
		 * 
		 * @param str
		 * @return Date on success, null on failure.
		 * 
		 */
		public static function fromISODateTime(str:String):Date {
			//	YYYY-MM-DD HH:MM:SS
			var dateRegex:RegExp = /^(\d{4})\-(\d{2})\-(\d{2})/;
			var timeRegex:RegExp = /(\d{2})\:(\d{2})\:(\d{2})$/;
			var res:Object = dateRegex.exec(str);
			var fullYear:int = 0;
			var month:int = 0;
			var date:int = 0;
			var hour:int = 0;
			var minute:int = 0;
			var second:int = 0;
			var isOK:Boolean = false;
			if (res is Array && res[0].length) {
				fullYear = Number(res[1]);
				month = Number(res[2]) - 1;
				date = Number(res[3]);
				isOK = true;
			}
			res = timeRegex.exec(str);
			if (res is Array && res[0].length) {
				hour = Number(res[1]);
				minute = Number(res[2]);
				second = Number(res[3]);
				isOK = true;
			}
			if (isOK) {
				return new Date(fullYear, month, date, hour, minute, second);
			} else {
				return null;
			}
		}
	
		/**
		 * Creates an ISO datetime YYYY-MM-DD HH:MM:SS from a given date.
		 * 
		 * @param dte
		 * @return 
		 * 
		 */
		public static function toISODateTime(dte:Date):String {
			//	YYYY-MM-DD HH:MM:SS	
			var str:String = dte.fullYear+"-";
			str += (dte.month < 9 ? "0" : "")+(dte.month + 1)+"-";
			str += (dte.date < 10 ? "0" : "")+dte.date+" ";
			str += (dte.hours < 10 ? "0" : "")+dte.hours+":";
			str += (dte.minutes < 10 ? "0" : "")+dte.minutes+":";
			str += (dte.seconds < 10 ? "0" : "")+dte.seconds;
			return str;
		}

	
		/**
		 * Copy the date values from dte1 to dte2.
		 * 
		 * @param dte1 Date object to copy from.
		 * @param dte2 Date object to copy to.
		 * 
		 */
		public static function copy(dte1:Date, dte2:Date):void {
			dte2.setTime(dte1.getTime());
		}
		
		/**
		 * Calculates the differences in days.
		 * 
		 * <p>This method always return a positive value.</p>
		 * @param dte1
		 * @param dte2
		 * @return 
		 * 
		 */
		public static function diff(dte1:Date, dte2:Date):Number {
			return Math.abs(DateUtilExt.dateToDays(dte1) - DateUtilExt.dateToDays(dte2));
		}

		/**
		 * Compares 2 date object to see which is earlier.
		 * 
		 * <p>This method returns the result as:
		 * <ul>
		 * <li><code>1</code> if dte1 is greater (or after) than dte2.</li>
		 * <li><code>-1</code> if dte1 is smaller (or before) than dte2.</li>
 		 * <li><code>0</code> if dte1 and dte2 are the same.</li>
		 * </ul>
		 * </p>
		 * 
		 * @param dte1
		 * @param dte2
		 * @return 
		 * 
		 */
		public static function compare(dte1:Date, dte2:Date):Number {
			var days1:Number = DateUtilExt.dateToDays(dte1);
			var days2:Number = DateUtilExt.dateToDays(dte2);
			switch(true) {
				case (days1 < days2) : return -1;
				case (days1 > days2) : return 1;
				case (dte1.hours < dte2.hours) : return -1;
				case (dte1.hours > dte2.hours) : return 1;
				case (dte1.minutes < dte2.minutes) : return -1;
				case (dte1.minutes > dte2.minutes) : return 1;
				case (dte1.seconds < dte2.seconds) : return -1;
				case (dte1.seconds > dte2.seconds) : return 1;
				default : return 0;
			}
		}
		
		/**
		 * Tells if dte1 is before dte2.
		 * 
		 * @param dte1
		 * @param dte2
		 * @return 
		 * 
		 */
		public static function before(dte1:Date, dte2:Date):Boolean {
			return DateUtilExt.compare(dte1, dte2) == -1;
		}
	
		/**
		 * Tells if dte1 is after dte2
		 * 
		 * @param dte1
		 * @param dte2
		 * @return 
		 * 
		 */
		public static function after(dte1:Date, dte2:Date):Boolean {
			return DateUtilExt.compare(dte1, dte2) == 1;
		}
		
		/**
		 * Tells if dte1 and dte2 are of the same values.
		 * 
		 * @param dte1
		 * @param dte2
		 * @return 
		 * 
		 */		
		public static function equals(dte1:Date, dte2:Date):Boolean {
			return DateUtilExt.compare(dte1, dte2) == 0;
		}
	
		/**
		 * Tells if dte1 and dte2 are of the same hour on th same day.
		 * 
		 * @param dte1
		 * @param dte2
		 * @return 
		 * 
		 */
		public static function isSameHour(dte1:Date, dte2:Date):Boolean {
			return DateUtilExt.isSameDate(dte1, dte2) && (dte1.hours == dte2.hours);
		}
	
		/**
		 * Tells if dte1 and dte2 are on the same date.
		 * 
		 * @param dte1
		 * @param dte2
		 * @return 
		 * 
		 */
		public static function isSameDate(dte1:Date, dte2:Date):Boolean {
			return DateUtilExt.isSameMonth(dte1, dte2) && (dte1.date == dte2.date);
		}
		
		/**
		 * Tells if dte1 and dte2 are in the same week.
		 * 
		 * @param dte1
		 * @param dte2
		 * @return 
		 * 
		 */		
		public static function isSameWeek(dte1:Date, dte2:Date):Boolean {
			return DateUtilExt.isSameMonth(dte1, dte2) && (DateUtilExt.weekOfYear(dte1) == DateUtilExt.weekOfYear(dte1));
		}
		
		/**
		 * Tells if dte1 and dte2 are in the same month.
		 * 
		 * @param dte1
		 * @param dte2
		 * @return 
		 * 
		 */
		public static function isSameMonth(dte1:Date, dte2:Date):Boolean {
			return DateUtilExt.isSameYear(dte1, dte2) && (dte1.month == dte2.month);
		}
	
		/**
		 * Tells if dte1 and dte2 are in the same year.
		 * 
		 * @param dte1
		 * @param dte2
		 * @return 
		 * 
		 */
		public static function isSameYear(dte1:Date, dte2:Date):Boolean {
			return (dte1.fullYear == dte2.fullYear);
		}
	
		/**
		 * Tells if dte is in the past.
		 * 
		 * @param dte
		 * @return 
		 * 
		 */
		public static function isPast(dte:Date):Boolean {
			return DateUtilExt.before(dte, now());
		}
		
		/**
		 * Tells if dte is in the future.
		 * 
		 * @param dte
		 * @return 
		 * 
		 */
		public static function isFuture(dte:Date):Boolean {
			return DateUtilExt.after(dte, now());
		}
	
		/**
		 * Creates a Date object from dte and set to mid-night.
		 * 
		 * @param dte
		 * @return 
		 * 
		 */
		public static function toMidnight(dte:Date):Date {
			return new Date(dte.fullYear, dte.month, dte.date, 0, 0, 0, 0);
		}
		
		/**
		 * Creates a Date object from dte and set to the last hour, minutes and seconds.
		 * 
		 * @param dte
		 * @return 
		 * 
		 */
		public static function toLastSecondOfDay(dte:Date):Date {
			return new Date(dte.fullYear, dte.month, dte.date, 23, 59, 59, 999);
		}
		
		/**
		 * Creates a new Date based on the dte's next day.
		 * 
		 * <p>The hours, minutes and seconds are preserved.</p>
		 * 
		 * @param dte
		 * @return 
		 * 
		 */
		public static function nextDay(dte:Date):Date {
			var res:Date = DateUtilExt.daysToDate(DateUtilExt.dateToDays(dte) + 1);
			return new Date(res.fullYear, res.month, res.date, dte.hours, dte.minutes, dte.seconds, dte.milliseconds);
		}
		
		/**
		 * Creates a new Date based on the dte's some day.
		 * 
		 * <p>The hours, minutes and seconds are preserved.</p>
		 * 
		 * @param dte
		 * @return 
		 * 
		 */
		public static function nextSomeDay(dte:Date, day:int):Date {
			var res:Date = DateUtilExt.daysToDate(DateUtilExt.dateToDays(dte) + day);
			return new Date(res.fullYear, res.month, res.date, dte.hours, dte.minutes, dte.seconds, dte.milliseconds);
		}		
		
		/**
		 * Creates a new Date based on the dte's previous day.
		 * 
		 * <p>The hours, minutes and seconds are preserved.</p>
		 * 
		 * @param dte
		 * @return 
		 * 
		 */
		public static function prevDay(dte:Date):Date {
			var res:Date = DateUtilExt.daysToDate(DateUtilExt.dateToDays(dte) - 1);
			return new Date(res.fullYear, res.month, res.date, dte.hours, dte.minutes, dte.seconds, dte.milliseconds);
		}
		
		/**
		 * Creates a new Date based on the dte's some day.
		 * 
		 * <p>The hours, minutes and seconds are preserved.</p>
		 * 
		 * @param dte
		 * @return 
		 * 
		 */
		public static function preSomeDay(dte:Date, day:int):Date {
			var res:Date = DateUtilExt.daysToDate(DateUtilExt.dateToDays(dte) - day);
			return new Date(res.fullYear, res.month, res.date, dte.hours, dte.minutes, dte.seconds, dte.milliseconds);
		}				
		
		/**
		 * Creates a new Date based on the dte's beginning of week.
		 * 
		 * <p>Note that the constant BEGIN_WEEKDAY has a direct effect on the
		 * calculation of beginning of week.</p>
		 * 
		 * <p>The hours, minutes and seconds are preserved.</p>
		 * 
		 * @param dte
		 * @return 
		 * 
		 */
		public static function beginOfWeek(dte:Date):Date {
			//	NOTE: Can return weekday of prev month.
			var weekDay:Number = DateUtilExt.dayOfWeek(dte);
			//var delta:Number = (7 - DateUtilExt.BEGIN_WEEKDAY + weekDay) % 7;
			if(weekDay == 0){
			    weekDay = 7;
			}
			var res:Date = DateUtilExt.daysToDate(DateUtilExt.dateToDays(dte) - weekDay + 1);
			return new Date(res.fullYear, res.month, res.date, dte.hours, dte.minutes, dte.seconds, dte.milliseconds);
		
		}
		
		/**
		 * Creates a new Date based on dte's end of week.
		 * 
		 * <p>Note that the constant BEGIN_WEEKDAY has a direct effect on the
		 * calculation of end of week.</p>
		 * 
		 * <p>The hours, minutes and seconds are preserved.</p>
		 * 
		 * @param dte
		 * @return 
		 * 
		 */
		public static function endOfWeek(dte:Date):Date {
			//	NOTE: Can return weekday of next month.
			var weekDay:Number = DateUtilExt.dayOfWeek(dte);
			var res:Date = DateUtilExt.daysToDate(DateUtilExt.dateToDays(dte) + 7 - weekDay);
			return new Date(res.fullYear, res.month, res.date, dte.hours, dte.minutes, dte.seconds, dte.milliseconds);
		}
		
		/**
		 * Creates a new Date based on dte's beginning of the month.
		 * 
		 * <p>The hours, minutes and seconds are preserved.</p>
		 * 
		 * @param dte
		 * @return 
		 * 
		 */
		public static function beginOfMonth(dte:Date):Date {
			return new Date(dte.fullYear, dte.month, 1, dte.hours, dte.minutes, dte.seconds, dte.milliseconds);

		}
		
		/**
		 * Creates a new Date based on dte's end of the month.
		 * 
		 * <p>The hours, minutes and seconds are preserved.</p>
		 * 
		 * @param dte
		 * @return 
		 * 
		 */
		public static function endOfMonth(dte:Date):Date {
			return new Date(dte.fullYear, dte.month, daysInMonth(dte), dte.hours, dte.minutes, dte.seconds, dte.milliseconds);
		}
		
		/**
		 * Creates a new Date based on dte's beginning of the Quarter.
		 * 
		 * <p>The hours, minutes and seconds are preserved.</p>
		 * 
		 * @param dte
		 * @return 
		 * 
		 */
		public static function beginOfQuarter(y:Number, q:Number):Date {
			if (q == 1) return new Date(y, 0, 1);
			if (q == 2) return new Date(y, 3, 1);
			if (q == 3) return new Date(y, 6, 1);
			if (q == 4) return new Date(y, 9, 1);
			return new Date(y, 1, 1);
		}
		
		/**
		 * Creates a new Date based on dte's end of the Quarter.
		 * 
		 * <p>The hours, minutes and seconds are preserved.</p>
		 * 
		 * @param dte
		 * @return 
		 * 
		 */
		public static function endOfQuarter(y:Number, q:Number):Date {
			if (q == 1) return new Date(y, 2, 31);
			if (q == 2) return new Date(y, 5, 30);
			if (q == 3) return new Date(y, 8, 30);
			if (q == 4) return new Date(y, 11, 31);
			return new Date(y, 3, 31);
		}		
		
		/**
		 *  Converts a date to number of days since a distant unspecified epoch
		 * 
		 * @param dte
		 * @return 
		 * 
		 */
		public static function dateToDays(dte:Date):Number {
			var m:Number = dte.month + 1;	//	NOTE: Flash months are zero-based
			var y:Number = dte.fullYear;
			var d:Number = dte.date;
			
			var cty:Number = Number(String(y).substr(0, 2));
			y = Number(String(y).substr(2, 2));
			if (m > 2) {
				m -= 3;
			} else {
				m += 9;
				if (y) {
					y--;
				} else {
					y = 99;
					cty--;
				}
			}
	
			return (Math.floor((146097 * cty) / 4 ) +
					Math.floor((1461 * y) / 4 ) +
					Math.floor((153 * m + 2) / 5 ) +
					d + 1721119);
		}
		
		/**
		 * Converts number of days to a distant unspecified epoch and create a new Date.
		 * 
		 * @param days
		 * @return 
		 * 
		 */
		public static function daysToDate(days:Number):Date {
			days -= 1721119;
			var cty:Number = Math.floor((4 * days - 1) / 146097);
			days = Math.floor(4 * days - 1 - 146097 * cty);
			var d:Number = Math.floor(days / 4);
			var y:Number = Math.floor((4 * d + 3) / 1461);
			d = Math.floor(4 * d + 3 - 1461 * y);
			d = Math.floor((d + 4) / 4);
			var m:Number = Math.floor((5 * d - 3) / 153);
			d = Math.floor(5 * d - 3 - 153 * m);
			d = Math.floor((d + 5) / 5);
			if (m < 10) {
				m +=3;
			} else {
				m -=9;
				if (y++ == 99) {
					y = 0;
					cty++;
				}
			}
			return new Date((cty * 100) + y, m - 1, d, 0, 0, 0, 0);
		}
		
		/**
		 * Returns number of days since 31 December of year before given date.
		 * 
		 * @param dte
		 * @return 
		 * 
		 */
		public static function julianDate(dte:Date):Number {
			var m:Number = dte.month + 1;	//	NOTE: Flash months are zero-based
			var y:Number = dte.fullYear;
			var d:Number = dte.date;
			var ds:Array = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
			var j:Number = (ds[m - 1] + d);
			if (m > 2 && DateUtilExt.isLeapYear(dte)) {
				j++;
			}
			return j;
		}
		
		/**
		 * Tells if the dte is a leap year.
		 * 
		 * @param dte
		 * @return 
		 * 
		 */
		public static function isLeapYear(dte:Date):Boolean {
			return DateUtilExt.isYearLeapYear(dte.fullYear);
		}
	
		/**
		 * Tells if the given year is a leap year.
		 * 
		 * @param y
		 * @return 
		 * 
		 */
		public static function isYearLeapYear(y:Number):Boolean {
			switch(true) {
				case (y < 1000) : return false;
				case (y < 1582) : return (y % 4 == 0);	// pre Gregorio XIII - 1582
				default : return ((y % 4 == 0) && (y % 100 != 0)) || (y % 400 == 0);	// post Gregorio XIII - 1582
			}
		}
	

		/**
		 * Converts from Gregorian Year-Month-Day to ISO Year-WeekNumber-WeekDay.
		 * 
		 * <p>Uses ISO 8601 definitions.  Algorithm by Rick McCarty, 1999 at
		 *  http://personal.ecu.edu/mccartyr/ISOwdALG.txt .</p>
		 * 
		 * @param dte
		 * @return 
		 * 
		 */
		public static function gregorianToISO(dte:Date):String {
			var m:Number = dte.month + 1;	//	NOTE: Flash months are zero-based
			var y:Number = dte.fullYear;
			var d:Number = dte.date;
			var mnth:Array = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
			var isLeap:Boolean = DateUtilExt.isYearLeapYear(y);
			var y1isLeap:Boolean = DateUtilExt.isYearLeapYear(y - 1);
			var dayOfTheYear:Number = d + mnth[m - 1];
			if (isLeap && m > 2) {
				dayOfTheYear++;
			}
			// find Jan 1 weekday (monday = 1, sunday = 7)
			var yy:Number = (y - 1) % 100;
			var c:Number = (y - 1) - yy;
			var g:Number = yy + Math.floor(yy / 4);
			var jan1WeekDay:Number = 1 + Math.floor(((((c / 100) % 4) * 5) + g) % 7);
			// weekday for year-month-day
			var h:Number = dayOfTheYear + (jan1WeekDay - 1);
			var weekDay:Number = 1 + Math.floor((h - 1) % 7);
			var i:Number;
			var j:Number;
			var weekNum:Number;
			var yearNum:Number;
			// find if Y M D falls in YearNumber Y-1, WeekNumber 52 or
			if (dayOfTheYear <= (8 - jan1WeekDay) && jan1WeekDay > 4){
				yearNum = y - 1;
				if (jan1WeekDay == 5 || (jan1WeekDay == 6 && y1isLeap)) {
					weekNum = 53;
				} else {
					weekNum = 52;
				}
			} else {
				yearNum = y;
			}
			// find if Y M D falls in YearNumber Y+1, WeekNumber 1
			if (yearNum == y) {
				if (isLeap) {
					i = 366;
				} else {
					i = 365;
				}
				if ((i - dayOfTheYear) < (4 - weekDay)) {
					yearNum++;
					weekNum = 1;
				}
			}
			// find if Y M D falls in YearNumber Y, WeekNumber 1 through 53
			if (yearNum == y) {
				j = dayOfTheYear + (7 - weekDay) + (jan1WeekDay - 1);
				weekNum = Math.floor(j / 7);
				if (jan1WeekDay > 4) {
					weekNum--;
				}
			}
			return yearNum+"-W"+(weekNum < 10 ? '0'+weekNum : weekNum)+"-"+weekDay;
		}
		
		/**
		 * Tells the day number of dte in the current week.
		 * 
		 * @param dte
		 * @return 
		 * 
		 */
		public static function dayOfWeek(dte:Date):Number {
			var m:Number = dte.month + 1;	//	NOTE: Flash months are zero-based
			var y:Number = dte.fullYear;
			var d:Number = dte.date;
			if (m > 2) {
				m -= 2;
			} else {
				m += 10;
				y--;
			}
			d = (Math.floor((13 * m - 1) / 5) +
					d + (y % 100) +
					Math.floor((y % 100) / 4) +
					Math.floor((y / 100) / 4) - 2 *
					Math.floor(y / 100) + 77);
	
			return d - 7 * Math.floor(d / 7);
		
		}
		
		/**
		 * Tells the week number of dte in the current year.
		 * 
		 * @param dte
		 * @return 
		 * 
		 */
		public static function weekOfYear(dte:Date):Number {
			var iso:String = DateUtilExt.gregorianToISO(dte);
			var parts:Array = iso.split('-');
			return Number(parts[1].substr(1));
		}
		
		/**
		 * Tells the quarter of the dte in the current year.
		 * @param dte
		 * @return 
		 * 
		 */
		public static function quarterOfYear(dte:Date):Number {
			var m:Number = dte.month + 1;	//	NOTE: Flash months are zero-based
			var y:Number = dte.fullYear;
			var d:Number = dte.date;
			return Math.floor((m - 1) / 3 + 1);
		}
		
		/**
		 * Tells the number of days in the month of dte.
		 *
		 * @param dte
		 * @return 
		 * 
		 */
		public static function daysInMonth(dte:Date):Number {
			var m:Number = dte.month + 1;	//	NOTE: Flash months are zero-based
			var y:Number = dte.fullYear;
			var d:Number = dte.date;
			if (y == 1582 && m == 10) {
				return 21; // October 1582 only had 1st-4th and 15th-31st
			}
			if (m == 2) {
				if (DateUtilExt.isYearLeapYear(y)) {
					return 29;
				 } else {
					return 28;
				}
			} else if (m == 4 || m == 6 || m == 9 || m == 11) {
				return 30;
			} else {
				return 31;
			}
		}
		
		/**
		 * Tells the number of weeks in a month of dte.
		 * 
		 * @param dte
		 * @return 
		 * 
		 */
		public static function weeksInMonth(dte:Date):Number {
			var fdom:Number = DateUtilExt.firstDayOfMonth(dte);
			var first_week_days:Number;
			var weeks:Number;
			if (DateUtilExt.BEGIN_WEEKDAY == 1 && fdom == 0) {
				first_week_days = 7 - fdom + DateUtilExt.BEGIN_WEEKDAY;
				weeks = 1;
			} else if (DateUtilExt.BEGIN_WEEKDAY == 0 && fdom == 6) {
				first_week_days = 7 - fdom + DateUtilExt.BEGIN_WEEKDAY;
				weeks = 1;
			} else {
				first_week_days = DateUtilExt.BEGIN_WEEKDAY - fdom;
				weeks = 0;
			}
			first_week_days %= 7;
			return Math.ceil((DateUtilExt.daysInMonth(dte) - first_week_days) / 7) + weeks;
		}
		
		/**
		 * Tells the day of the first day of the month.
		 * 
		 * @param dte
		 * @return 
		 * 
		 */
		public static function firstDayOfMonth(dte:Date):Number {
			var dte2:Date = DateUtilExt.clone(dte);
			dte2.date = 1;
			return DateUtilExt.dayOfWeek(dte2);
		
		}
		
		
		public static function getNextMonth(currentDate:Date):Date  
		{  
			var returnDate:Date=new Date(currentDate.getTime());  
			returnDate.setMonth(returnDate.getMonth() + 1, returnDate.getDate());  
			return returnDate;  
		} 
		
		public static function getNextSomeMonth(currentDate:Date, month:int):Date  
		{  
			var returnDate:Date=new Date(currentDate.getTime());  
			returnDate.setMonth(returnDate.getMonth() + month, returnDate.getDate());  
			return returnDate;  
		}		

}
}
package com.partycommittee.util
{
	import flash.utils.ByteArray;
	
	import mx.utils.ObjectUtil;

	public class ObjectUtil {
		public function ObjectUtil() {
		}
		
		public static function clone(source:Object):* {
			var myBA:ByteArray = new ByteArray();
			myBA.writeObject(source);
			myBA.position = 0;
			return myBA.readObject();
		}
	}
}
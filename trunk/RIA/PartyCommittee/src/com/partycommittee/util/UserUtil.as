package com.partycommittee.util
{
	import mx.collections.ArrayCollection;

	public class UserUtil {
		public function UserUtil() {
		}
		
		public static function checkRole(roleId:Number, roles:ArrayCollection):Boolean {
			var i = roles.length;
			while(i--) {
				if ( int(roles.getItemAt(i)) == int(roleId)) {
					return true;
				}
			}
			return false;
		}
	}
}
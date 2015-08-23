package com.partycommittee.util
{
	public class SexCodeUtil {
		public function SexCodeUtil() {
		}
		
		public static function getSexCodeDes(codeId:Number):String {
			switch (codeId) {
				case PCConst.SEX_MALE:
					return "男";
				case PCConst.SEX_FEMALE:
					return "女";
				default:
					return null;
			}
		}
	}
}
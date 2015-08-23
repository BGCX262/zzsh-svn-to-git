package com.partycommittee.util
{
	public class AgencyCodeUtil {
		public function AgencyCodeUtil() {
		}
		
		public static function getAgencyCodeDes(codeId:Number):String {
			switch (codeId) {
				case PCConst.AGENCY_CODE_BASICCOMMITTEES:
					return "党委";
				case PCConst.AGENCY_CODE_BOARDCOMMITTEES:
					return "党的基层组织";
				case PCConst.AGENCY_CODE_BRANCH:
					return "党支部";
				case PCConst.AGENCY_CODE_FIRSTBRANCH:
					return "第一党支部";
				case PCConst.AGENCY_CODE_GANERALBRANCH:
					return "党总支部";
				case PCConst.AGENCY_CODE_TEAM:
					return "党小组";
				case PCConst.AGENCY_CODE_EJDW:
					return "二级党委";
				default:
					return null;
			}
		}
	}
}
package com.partycommittee.util
{
	import com.partycommittee.model.ModelLocator;
	import com.partycommittee.vo.PcAgencyVo;
	import com.partycommittee.vo.PcMeetingVo;
	import com.partycommittee.vo.PcMemberVo;
	import com.partycommittee.vo.PcRemindVo;
	import com.partycommittee.vo.PcUserVo;
	import com.partycommittee.vo.PcWorkPlanVo;
	
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;

	public class LblFunctionHelper {
		public function LblFunctionHelper() {
		}
		
		public static function dateLblFunc(item:Object, col:*):String {
			var date:Date = item[col.dataField] as Date;
			if (date) {
				return DateUtil.toISOString(date, false);
			}
			return "";
		}
		
		public static function dateTimeLblFunc(item:Object, col:*):String {
			var date:Date = item[col.dataField] as Date;
			if (date) {
				return DateUtil.toISOString(date, true);
			}
			return "";
		}
				
		
		public static function agencyCodeLblFunc(item:Object, col:*):String {
			if (item as PcAgencyVo) {
				return AgencyCodeUtil.getAgencyCodeDes((item as PcAgencyVo).codeId);
			}
			return "";
		}
		
		public static function memberSexLblFunc(item:Object, col:*):String {
			if (item as PcMemberVo) {
				return SexCodeUtil.getSexCodeDes((item as PcMemberVo).sexId);
			}
			return "";
		}
		
		public static function memberDutyLblFunc(item:Object, col:*):String {
			if (item as PcMemberVo) {
				return DutyCodeUtil.getDutyCodeDes((item as PcMemberVo).dutyId, ModelLocator.getInstance().dutyCodeCollection);
			}
			return "";
		}
		
		public static function memberEduLblFunc(item:Object, col:*):String {
			if (item as PcMemberVo) {
				return EduCodeUtil.getEduCodeDes((item as PcMemberVo).eduId);
			}
			return "";
		}
		
		public static function memberNationLblFunc(item:Object, col:*):String {
			if (item as PcMemberVo) {
				return NationCodeUtil.getNationDesById((item as PcMemberVo).nationId);
			}
			return "";
		}
		
		public static function userStatusLblFunc(item:Object, col:*):String {
			if (item as PcUserVo) {
				return (item as PcUserVo).status == 1 ? "启用" : "禁用";
			}
			return "";
		}
		
		public static function userAgencyLblFunc(item:Object, col:*):String {
			if (item as PcUserVo) {
				var userVo:PcUserVo = item as PcUserVo;
				if (userVo.agencyList && userVo.agencyList.length) {
					var agencyNameArry:Array = new Array();
					for each (var agency:PcAgencyVo in userVo.agencyList) {
						agencyNameArry.push(agency.name);
					}
					return agencyNameArry.join(", ");
				}
			}
			return "";
		}
		
		public static function userPrivilegeLblFunc(item:Object, col:*):String {
			if (item as PcUserVo) {
				var userVo:PcUserVo = item as PcUserVo;
				if (userVo.enableReport) {
					return "填报权";
				}
				return "浏览权";
			}
			return "";
		}
		
		public static function workPlanTypeLblFunc(item:Object, col:*):String {
			var typeId:Number;
			if (item is PcWorkPlanVo) {
				typeId = (item as PcWorkPlanVo).typeId;
			} else if (item is PcMeetingVo) {
				typeId = (item as PcMeetingVo).typeId;
			} else if (item is Object) {
				typeId = (item as Object).typeId;
			}
			switch (typeId) {
				case PCConst.WORKPLAN_TYPE_YEARLY:
					return "年度计划";
				case PCConst.WORKPLAN_TYPE_YEARLY_SUMMARY:
					return "年终总结";
				case PCConst.WORKPLAN_TYPE_QUARTER:
					return "季度计划";
				case PCConst.WORKPLAN_TYPE_QUARTER_SUMMARY:
					return "季度执行情况";
				case PCConst.WORKPLAN_TYPE_CLASS:
					return "党课";
				case PCConst.WORKPLAN_TYPE_MEETING_BRANCH_COMMITTEE:
					return "支部委员会";
				case PCConst.WORKPLAN_TYPE_MEETING_BRANCH_MEMBER:
					return "支部党员大会";
				case PCConst.WORKPLAN_TYPE_MEETING_BRANCH_LIFE:
					return "支部民主生活会";
				case PCConst.WORKPLAN_TYPE_MEETING_TEAM:
					return "党小组会";
				case PCConst.WORKPLAN_TYPE_MEETING_OTHER:
					return "其他";
			}
			return "";
		}
		
		public static function workPlanStatusLblFunc(item:Object, col:*):String {
			var statusId:Number;
			if (item is PcWorkPlanVo) {
				statusId = (item as PcWorkPlanVo).statusId;
			} else if (item is PcMeetingVo) {
				statusId = (item as PcMeetingVo).statusId;
			}
			return WorkPlanStatusUtil.getWorkPlanStatusDes(statusId);
		}
		
		public static function workPlanQuarterLblFunc(item:Object, col:*):String {
			var quarter:Number;
			if (item is PcWorkPlanVo) {
				quarter = (item as PcWorkPlanVo).quarter;
			} else if (item is PcMeetingVo) {
				quarter = (item as PcMeetingVo).quarter;
			}
			switch (quarter) {
				case 1:
					return "第一季度";
				case 2:
					return "第二季度";
				case 3:
					return "第三季度";
				case 4:
					return "第四季度";
			}
			return "";
		}
	}
}
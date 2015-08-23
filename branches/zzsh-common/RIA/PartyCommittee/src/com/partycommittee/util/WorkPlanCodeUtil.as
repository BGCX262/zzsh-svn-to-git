package com.partycommittee.util
{
	public class WorkPlanCodeUtil {
		public function WorkPlanCodeUtil() {
		}
		
		public static function getWorkPlanTypeDes(typeId:Number):String {
			switch (typeId) {
				case PCConst.WORKPLAN_TYPE_YEARLY:
					return "年度计划";
				case PCConst.WORKPLAN_TYPE_YEARLY_SUMMARY:
					return "年终总结";
				case PCConst.WORKPLAN_TYPE_QUARTER:
					return "季度工作安排";
				case PCConst.WORKPLAN_TYPE_QUARTER_SUMMARY:
					return "季度执行情况";
				case PCConst.WORKPLAN_TYPE_CLASS:
					return "党课";
				case PCConst.WORKPLAN_TYPE_MEETING_TEAM:
					return "党小组会";
				case PCConst.WORKPLAN_TYPE_MEETING_OTHER:
					return "其他";
				case PCConst.WORKPLAN_TYPE_MEETING_BRANCH_COMMITTEE:
					return "支部委员会";
				case PCConst.WORKPLAN_TYPE_MEETING_BRANCH_LIFE:
					return "支部民主生活会";
				case PCConst.WORKPLAN_TYPE_MEETING_BRANCH_MEMBER:
					return "支部党员大会";
			}
			return "";
		}
	}
}
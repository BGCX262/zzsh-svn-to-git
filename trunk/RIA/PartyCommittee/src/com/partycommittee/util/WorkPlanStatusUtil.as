package com.partycommittee.util
{
	public class WorkPlanStatusUtil {
		public function WorkPlanStatusUtil() {
		}
		
		public static function getWorkPlanStatusDes(statusId:Number):String {
			switch (statusId) {
				case 0:
					return "未报";
				case 1:
					return "未报";
				case 2:
					return "驳回";
				case 3:
					return "已报";
				case 4:
					return "已评语";
				case 5:
					return "已评价";
			}
			return "";
		}
	}
}
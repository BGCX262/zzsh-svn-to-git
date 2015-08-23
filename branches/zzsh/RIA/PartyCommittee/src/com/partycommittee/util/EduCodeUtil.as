package com.partycommittee.util
{
	import mx.collections.ArrayCollection;

	public class EduCodeUtil {
		public function EduCodeUtil() {
		}
		
		public static function getEduCodeDes(codeId:Number):String {
			switch (codeId) {
				case PCConst.EDU_GRADUATE:
					return "研究生教育";
				case PCConst.EDU_GRADUATE_AREA:
					return "省（区，市）委党校研究生";
				case PCConst.EDU_GRADUATE_CENTER:
					return "中央党校研究生";
				case PCConst.EDU_GRADUATE_CLASS:
					return "硕士生班";
				case PCConst.EDU_GRADUATE_DOCTOR:
					return "博士研究生";
				case PCConst.EDU_GRADUATE_MASTER:
					return "硕士研究生";
				case PCConst.EDU_SPECIALIST:
					return "本专科教育";
				case PCConst.EDU_SPECIALIST_COLLAGE:
					return "大专";
				case PCConst.EDU_SPECIALIST_COLLAGE_AREA:
					return "省（区，市）委党校大专";
				case PCConst.EDU_SPECIALIST_COLLAGE_CENTER:
					return "中央党校大专";
				case PCConst.EDU_SPECIALIST_SECONDE_BACHELOR:
					return "第二学士学位办";
				case PCConst.EDU_SPECIALIST_UNIVERSITY:
					return "大学";
				case PCConst.EDU_SPECIALIST_UNIVERSITY_AREA:
					return "省（区，市）委党校大学";
				case PCConst.EDU_SPECIALIST_UNIVERSITY_CENTER:
					return "中央党校大学";
				case PCConst.EDU_SPECIALIST_UNIVERSITY_NORMAL:
					return "大学普通版";
				case PCConst.EDU_SEC_VOCATIONAL:
					return "中等职业学校教育";
				case PCConst.EDU_SEC_VOCATIONAL_COLLAGE:
					return "中等专科";
				case PCConst.EDU_SEC_VOCATIONAL_HIGH_SCHOOL:
					return "职业高中";
				case PCConst.EDU_SEC_VOCATIONAL_MECHANIC_SCHOOL:
					return "技工学校";
				case PCConst.EDU_HIGH_SCHOOL:
					return "普通高中教育";
				case PCConst.EDU_HIGH_SCHOOL_NORMAL:
					return "普通高中";
				case PCConst.EDU_JUNIOR_SCHOOL:
					return "初中教育";
				case PCConst.EDU_JUNIOR_SCHOOL_NORMAL:
					return "初中";
				case PCConst.EDU_PRIMARY_SCHOOL:
					return "小学教育";
				case PCConst.EDU_PRIMARY_SCHOOL_NORMAL:
					return "小学";
				case PCConst.EDU_OTHER:
					return "其他";
				default:
					return null;
			}
			return null;
		}
		
		public static function getCatalogItem(eduId:Number):Number {
			switch (eduId) {
				case PCConst.EDU_GRADUATE_AREA:
				case PCConst.EDU_GRADUATE_CENTER:
				case PCConst.EDU_GRADUATE_CLASS:
				case PCConst.EDU_GRADUATE_DOCTOR:
				case PCConst.EDU_GRADUATE_MASTER:
					return PCConst.EDU_GRADUATE;
				case PCConst.EDU_SPECIALIST_COLLAGE:
				case PCConst.EDU_SPECIALIST_COLLAGE_AREA:
				case PCConst.EDU_SPECIALIST_COLLAGE_CENTER:
				case PCConst.EDU_SPECIALIST_SECONDE_BACHELOR:
				case PCConst.EDU_SPECIALIST_UNIVERSITY:
				case PCConst.EDU_SPECIALIST_UNIVERSITY_AREA:
				case PCConst.EDU_SPECIALIST_UNIVERSITY_CENTER:
				case PCConst.EDU_SPECIALIST_UNIVERSITY_NORMAL:
					return PCConst.EDU_SPECIALIST;
				case PCConst.EDU_SEC_VOCATIONAL_COLLAGE:
				case PCConst.EDU_SEC_VOCATIONAL_HIGH_SCHOOL:
				case PCConst.EDU_SEC_VOCATIONAL_MECHANIC_SCHOOL:
					return PCConst.EDU_SEC_VOCATIONAL;
				case PCConst.EDU_HIGH_SCHOOL_NORMAL:
					return PCConst.EDU_HIGH_SCHOOL;
				case PCConst.EDU_JUNIOR_SCHOOL_NORMAL:
					return PCConst.EDU_JUNIOR_SCHOOL;
				case PCConst.EDU_PRIMARY_SCHOOL_NORMAL:
					return PCConst.EDU_PRIMARY_SCHOOL;
			}
			return 0;
		}
		
		public static function getEduDp(eduId:Number):ArrayCollection {
			switch (eduId) {
				case PCConst.EDU_GRADUATE:
					return new ArrayCollection([PCConst.EDU_GRADUATE_DOCTOR,
							PCConst.EDU_GRADUATE_MASTER,
							PCConst.EDU_GRADUATE_CLASS,
							PCConst.EDU_GRADUATE_CENTER,
							PCConst.EDU_GRADUATE_AREA]);
				case PCConst.EDU_SPECIALIST:
					return new ArrayCollection([PCConst.EDU_SPECIALIST_UNIVERSITY,
							PCConst.EDU_SPECIALIST_COLLAGE,
							PCConst.EDU_SPECIALIST_UNIVERSITY_NORMAL,
							PCConst.EDU_SPECIALIST_SECONDE_BACHELOR,
							PCConst.EDU_SPECIALIST_UNIVERSITY_CENTER,
							PCConst.EDU_SPECIALIST_UNIVERSITY_AREA,
							PCConst.EDU_SPECIALIST_COLLAGE_CENTER,
							PCConst.EDU_SPECIALIST_COLLAGE_AREA]);
				case PCConst.EDU_SEC_VOCATIONAL:
					return new ArrayCollection([PCConst.EDU_SEC_VOCATIONAL_COLLAGE,
							PCConst.EDU_SEC_VOCATIONAL_HIGH_SCHOOL,
							PCConst.EDU_SEC_VOCATIONAL_MECHANIC_SCHOOL]);
				case PCConst.EDU_HIGH_SCHOOL:
					return new ArrayCollection([PCConst.EDU_HIGH_SCHOOL_NORMAL]);
				case PCConst.EDU_JUNIOR_SCHOOL:
					return new ArrayCollection([PCConst.EDU_JUNIOR_SCHOOL_NORMAL]);
				case PCConst.EDU_PRIMARY_SCHOOL:
					return new ArrayCollection([PCConst.EDU_PRIMARY_SCHOOL_NORMAL]);
			}
			return null;
		}
	}
}
package
{
	import com.partycommittee.manager.navigation.INavigationMgr;
	
	import mx.collections.ArrayCollection;

	// For const define.
	public class PCConst {
		public function PCConst() {
		}
		
		// Agency code define.
		public static const AGENCY_CODE_BOARDCOMMITTEES:int = 6;
		public static const AGENCY_CODE_BASICCOMMITTEES:int = 7;
		public static const AGENCY_CODE_GANERALBRANCH:int = 8;
		public static const AGENCY_CODE_FIRSTBRANCH:int = 9;
		public static const AGENCY_CODE_BRANCH:int = 10;
		public static const AGENCY_CODE_TEAM:int = 13;
		public static const AGENCY_CODE_EJDW:int = 15;
		
		// Duty code define.
		public static const dutyList:ArrayCollection = new ArrayCollection(
			[DUTY_SECRETARY,
			 DUTY_DEPUTY_SECRETARY,
			 DUTY_ORGNIZATION_MEMBER,
			 DUTY_PROPAGANDA_MEMBER,
			 DUTY_DISCIPLINE_MEMBER,
			 DUTY_YOUTH_MEMBER,
//			 DUTY_MASSES_MEMBER,
			 DUTY_SECRECY_MEMBER,
//			 DUTY_UNITEDFRONT_MEMBER,
			 DUTY_WOMEN_MEMBER,
			 DUTY_UNION_MEMBER,
//			 DUTY_PARTYCOMMITTEE_MEMBER,
//			 DUTY_TEAM_MEMBER,
			 DUTY_TEAM_LEADER,
			 DUTY_OTHER]
		);
		
		public static const DUTY_SECRETARY:int = 1;
		public static const DUTY_DEPUTY_SECRETARY:int = 2;
		public static const DUTY_ORGNIZATION_MEMBER:int = 3;
		public static const DUTY_PROPAGANDA_MEMBER:int = 4;
		public static const DUTY_DISCIPLINE_MEMBER:int = 5;
		public static const DUTY_YOUTH_MEMBER:int = 6;
		public static const DUTY_MASSES_MEMBER:int = 7;
		public static const DUTY_SECRECY_MEMBER:int = 8;
//		public static const DUTY_UNITEDFRONT_MEMBER:int = 9;
		public static const DUTY_WOMEN_MEMBER:int = 9;
		public static const DUTY_UNION_MEMBER:int = 11;
		public static const DUTY_PARTYCOMMITTEE_MEMBER:int = 12;
		public static const DUTY_TEAM_MEMBER:int = 13;
		public static const DUTY_TEAM_LEADER:int = 14;
		public static const DUTY_OTHER:int = 15;
		
		// Sex code define.
		public static const SexList:ArrayCollection = new ArrayCollection(
			[SEX_MALE, 
			 SEX_FEMALE]
		);
		
		public static const SEX_MALE:int = 1;
		public static const SEX_FEMALE:int = 2;
		
		// Edu code define.
		public static const EduList:ArrayCollection = new ArrayCollection([
			EDU_GRADUATE_DOCTOR,
			EDU_GRADUATE_MASTER,
			EDU_GRADUATE_CLASS,
			EDU_GRADUATE_CENTER,
			EDU_GRADUATE_AREA,
			EDU_SPECIALIST_UNIVERSITY,
			EDU_SPECIALIST_COLLAGE,
			EDU_SPECIALIST_UNIVERSITY_NORMAL,
			EDU_SPECIALIST_SECONDE_BACHELOR,
			EDU_SPECIALIST_UNIVERSITY_CENTER,
			EDU_SPECIALIST_UNIVERSITY_AREA,
			EDU_SPECIALIST_COLLAGE_CENTER,
			EDU_SPECIALIST_COLLAGE_AREA,
			EDU_SEC_VOCATIONAL_COLLAGE,
			EDU_SEC_VOCATIONAL_HIGH_SCHOOL,
			EDU_SEC_VOCATIONAL_MECHANIC_SCHOOL,
			EDU_HIGH_SCHOOL_NORMAL,
			EDU_JUNIOR_SCHOOL_NORMAL,
			EDU_PRIMARY_SCHOOL_NORMAL,
			EDU_OTHER
		]);
		
		public static const EduCatalogList:ArrayCollection = new ArrayCollection(
			[EDU_GRADUATE, 
			 EDU_SPECIALIST, 
			 EDU_SEC_VOCATIONAL, 
			 EDU_HIGH_SCHOOL, 
			 EDU_JUNIOR_SCHOOL, 
			 EDU_PRIMARY_SCHOOL, 
			 EDU_OTHER]
		);
		
		public static const EDU_GRADUATE:int = 1;
		public static const EDU_GRADUATE_DOCTOR:int = 2;
		public static const EDU_GRADUATE_MASTER:int = 3;
		public static const EDU_GRADUATE_CLASS:int = 4;
		public static const EDU_GRADUATE_CENTER:int = 5;
		public static const EDU_GRADUATE_AREA:int = 6;
		public static const EDU_SPECIALIST:int = 7;
		public static const EDU_SPECIALIST_UNIVERSITY:int = 8;
		public static const EDU_SPECIALIST_COLLAGE:int = 9;
		public static const EDU_SPECIALIST_UNIVERSITY_NORMAL:int = 10;
		public static const EDU_SPECIALIST_SECONDE_BACHELOR:int = 11;
		public static const EDU_SPECIALIST_UNIVERSITY_CENTER:int = 12;
		public static const EDU_SPECIALIST_UNIVERSITY_AREA:int = 13;
		public static const EDU_SPECIALIST_COLLAGE_CENTER:int = 14;
		public static const EDU_SPECIALIST_COLLAGE_AREA:int = 15;
		public static const EDU_SEC_VOCATIONAL:int = 16;
		public static const EDU_SEC_VOCATIONAL_COLLAGE:int = 17;
		public static const EDU_SEC_VOCATIONAL_HIGH_SCHOOL:int = 18;
		public static const EDU_SEC_VOCATIONAL_MECHANIC_SCHOOL:int = 19;
		public static const EDU_HIGH_SCHOOL:int = 20;
		public static const EDU_HIGH_SCHOOL_NORMAL:int = 21;
		public static const EDU_JUNIOR_SCHOOL:int = 22;
		public static const EDU_JUNIOR_SCHOOL_NORMAL:int = 23;
		public static const EDU_PRIMARY_SCHOOL:int = 24;
		public static const EDU_PRIMARY_SCHOOL_NORMAL:int = 25;
		public static const EDU_OTHER:int = 26;

		// WorkPlan type define.
		public static const WORKPLAN_TYPE_YEARLY:int = 1;
		public static const WORKPLAN_TYPE_QUARTER:int = 2;
		public static const WORKPLAN_TYPE_QUARTER_SUMMARY:int = 3;
		public static const WORKPLAN_TYPE_YEARLY_SUMMARY:int = 4;
		public static const WORKPLAN_TYPE_CLASS:int = 5;
		public static const WORKPLAN_TYPE_MEETING_BRANCH_MEMBER:int = 6;
		public static const WORKPLAN_TYPE_MEETING_BRANCH_LIFE:int = 7;
		public static const WORKPLAN_TYPE_MEETING_BRANCH_COMMITTEE:int = 8;
		public static const WORKPLAN_TYPE_MEETING_OTHER:int = 9;
		public static const WORKPLAN_TYPE_MEETING_TEAM:int = 10;
		
		// Workflow type define.
		public static const WORKFLOW_TYPE_REPORT:int = 1;
		public static const WORKFLOW_TYPE_APPROVAL:int = 2;
		public static const WORKFLOW_TYPE_EVALUATE:int = 3;
		
		// Nation define.
		public static const nationList:ArrayCollection = new ArrayCollection([
			1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
			11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
			21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
			31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
			41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
			51, 52, 53, 54, 55, 56, 57, 58
		]);
		
	}
}
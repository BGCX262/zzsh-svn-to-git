package com.partycommittee.util
{
	import mx.collections.ArrayCollection;

	public class DataproviderFactory {
		public function DataproviderFactory() {
		}
		
		public static const WORKPLAN_YEAR_LENGTH:Number = 20;
		
		public static function getYearDp():ArrayCollection {
			var yearCollection:ArrayCollection = new ArrayCollection();
			var currentYear:Number = new Date().getFullYear();
			for (var i:int = 0; i < WORKPLAN_YEAR_LENGTH; i++) {
				yearCollection.addItem(currentYear + i);
			}
			return yearCollection;
		}
		
		public static function createMonthDp():ArrayCollection {
			var monthCollection:ArrayCollection = new ArrayCollection();
			for (var i:Number = 1; i <= 12; i++) {
				monthCollection.addItem(i);
			}
			return monthCollection;
		}
		
		public static function createQuarterDp():ArrayCollection {
			var quarterCollection:ArrayCollection = new ArrayCollection();
			for (var i:Number = 1; i <= 4; i++) {
				quarterCollection.addItem(i);
			}
			return quarterCollection;
		}
		
		public static function createDayDp():ArrayCollection {
			var dateCollection:ArrayCollection = new ArrayCollection();
			for (var i:Number = 1; i <= 31; i++) {
				dateCollection.addItem(i);
			}
			return dateCollection;
		}
		
		public static function getRangeYearDp():ArrayCollection {
			var yearCollection:ArrayCollection = new ArrayCollection();
			var currentYear:Number = new Date().getFullYear();
			for (var i:int = 0; i < WORKPLAN_YEAR_LENGTH + 1; i++) {
				yearCollection.addItem(currentYear - i);
			}
			return yearCollection;
		}
		
		public static function getRangeYearForReport():ArrayCollection {
			var yearCollection:ArrayCollection = new ArrayCollection();
			var currentYear:Number = new Date().getFullYear();
			for (var i:int = -5; i < WORKPLAN_YEAR_LENGTH + 1; i++) {
				yearCollection.addItem(currentYear - i);
			}
			return yearCollection;
		}
		
		public static function createTypeDp():Array {
			var typeCollection:Array = new Array(
									 {typeId:1, label:'年度计划'},
									 {typeId:2, label:'季度计划'},
									 {typeId:3, label:'季度执行情况'},
									 {typeId:4, label:'年终总结'},
									 {typeId:5, label:'党课'},
									 {typeId:6, label:'党员大会'},
									 {typeId:7, label:'民主生活会'},
									 {typeId:8, label:'支部委员会'},
									 {typeId:9, label:'其他'}
									);
			return typeCollection;
		}	
		
		public static function createWorkPlanTypeDp():Array {
			var typeCollection:Array = new Array(
				{typeId:1, label:'年度计划'},
				{typeId:2, label:'季度计划'},
				{typeId:3, label:'季度执行情况'},
				{typeId:4, label:'年终总结'}
			);
			return typeCollection;
		}			
		
		public static function createMeetingTypeDp():Array {
			var typeCollection:Array = new Array(
				{typeId:5, label:'党课'},
				{typeId:6, label:'党员大会'},
				{typeId:7, label:'民主生活会'},
				{typeId:8, label:'支部委员会'},
				{typeId:9, label:'其他'}
			);
			return typeCollection;
		}		
		
		public static function createStatDateRange():Array {
			var typeCollection:Array = new Array(
				{data:0, label:'全部'},
				{data:1, label:'第一季度'},
				{data:2, label:'第二季度'},
				{data:3, label:'第三季度'},
				{data:4, label:'第四季度'},
				{data:12, label:'上半年'},
				{data:34, label:'下半年'}
			);
			return typeCollection;
		}		
		
	}
}
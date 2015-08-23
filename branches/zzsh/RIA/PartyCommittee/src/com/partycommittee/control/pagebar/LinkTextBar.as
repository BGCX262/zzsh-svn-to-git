package com.partycommittee.control.pagebar
{
	import com.partycommittee.vo.PageHelperVo;
	
	import mx.containers.HBox;

	public class LinkTextBar extends HBox {
		public function LinkTextBar() {
			super();
		}
		
		private var _maxNum:Number;
		[Bindable]
		public function get maxNum():Number {
			return this._maxNum;
		}
		public function set maxNum(value:Number):void {
			this._maxNum = value;
		}
		
		private var _pageHelper:PageHelperVo;
		[Bindable]
		public function get pageHelper():PageHelperVo {
			return this._pageHelper;
		}
		public function set pageHelper(value:PageHelperVo):void {
			this._pageHelper = value;
			if (value) {
				updateData();
			}
		}
		
		protected function updateData():void {
			
		}
	}
}
package com.partycommittee.control.pagebar
{
	import com.partycommittee.control.button.PcButton;
	import com.partycommittee.vo.PageHelperVo;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.containers.HBox;
	import mx.controls.NumericStepper;
	import mx.controls.TextInput;
	import mx.events.FlexEvent;
	
	import spark.effects.interpolation.NumberInterpolator;

	[Event(name="pageGoto", type="flash.events.Event")]
	
	public class GotoBox extends HBox {
		public function GotoBox() {
			super();
			
			this._btn = new PcButton();
			this._btn.label = "跳转到";
			this._btn.addEventListener(MouseEvent.CLICK, onBtnClick);
			this.addChild(this._btn);
			
			this._numStepper = new NumericStepper();
			this._numStepper.width = 50;
			this._numStepper.minimum = 1;
			this.addChild(this._numStepper);
		}
		
		private var _numStepper:NumericStepper;
		private var _btn:PcButton;
		
		private var _pageHelper:PageHelperVo;
		[Bindable]
		public function get pageHelper():PageHelperVo {
			return this._pageHelper = new PageHelperVo;
		}
		public function set pageHelper(value:PageHelperVo):void {
			this._pageHelper = value;
			updateControl();
		}
		
		public function get pageIndex():Number {
			return _numStepper.value;
		}
		
		private function updateControl():void {
			if (!this._pageHelper) {
				this._btn.enabled = false;
			}
			this._btn.enabled = true;
			this._numStepper.maximum = this._pageHelper.pageCount;
		}
		
		private function onBtnClick(event:MouseEvent):void {
			dispatchEvent(new Event("pageGoto"));
		}
	}
}
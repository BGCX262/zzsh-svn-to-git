package com.partycommittee.manager.popup
{
	import flash.display.DisplayObject;
	
	import mx.core.FlexGlobals;
	import mx.core.IFlexDisplayObject;
	import mx.effects.Blur;
	import mx.events.TweenEvent;
	import mx.managers.PopUpManager;

	public class PopupMgr {
		private static var _instance:PopupMgr;
		
		public function PopupMgr() {
			if (_instance) {
				throw Error("PopupMgr is singleton.");
			}
			_instance = this;
		}
		
		public static function get instance():PopupMgr {
			if (!_instance) {
				_instance = new PopupMgr();
			}
			return _instance;
		}
		
		public function popupWindow(win:IFlexDisplayObject):void {
			var mShowEffect:Blur = new Blur();
			mShowEffect.blurXFrom = 255;
			mShowEffect.blurYFrom = 255;
			mShowEffect.blurXTo = 0;
			mShowEffect.blurYTo = 0;
			mShowEffect.target = win;
			mShowEffect.duration = 300;
			PopUpManager.addPopUp(win, FlexGlobals.topLevelApplication.root, true);
			PopUpManager.centerPopUp(win);
			mShowEffect.play();
		}
		
		public function removeWindow(win:IFlexDisplayObject):void {
			var mHideEffect:Blur = new Blur();
			mHideEffect.blurXFrom = 0;
			mHideEffect.blurYFrom = 0;
			mHideEffect.blurXTo = 255;
			mHideEffect.blurYTo = 255;
			mHideEffect.addEventListener(TweenEvent.TWEEN_END, function():void {
				PopUpManager.removePopUp(win);
			});
			mHideEffect.duration = 300;
			mHideEffect.target = win;
			mHideEffect.play();
		}
	}
}
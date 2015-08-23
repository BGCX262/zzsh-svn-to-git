package com.partycommittee.manager.navigation
{
	import flash.events.Event;
	
	import mx.containers.Canvas;
	import mx.containers.ViewStack;
	import mx.effects.Fade;
	import mx.events.FlexEvent;

	public class NavigationView extends Canvas implements INavigationView {
		public function NavigationView() {
			super();
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationCompleted);
			this.addEventListener(FlexEvent.SHOW, onShow);
			this.addEventListener(FlexEvent.HIDE, onHide);
		}
		
		private function onShow(event:FlexEvent):void {
			onNavigateIn();
		}
		
		private function onHide(event:FlexEvent):void {
			onNavigateOut();
		}
		
		protected function onNavigateIn():void {
			// Extends me.
		}
		
		protected function onNavigateOut():void {
			// Extends me.
		}
		
		private function onCreationCompleted(event:FlexEvent):void {
			this._fadeIn = new Fade(this);
			this._fadeIn.alphaFrom = 0;
			this._fadeIn.alphaTo = 1;
			this._fadeIn.duration = 300;
			this.setStyle("showEffect", this._fadeIn);
			this._fadeOut = new Fade(this);
			this._fadeOut.alphaFrom = 1;
			this._fadeOut.alphaTo = 0;
			this._fadeOut.duration = 300;
			this.setStyle("hideEffect", this._fadeOut);
			
			// Register view.
			registerView();
		}
		
		private var _fadeIn:Fade;
		private var _fadeOut:Fade;
		
		private var _viewStack:ViewStack;
		public function get viewStack():ViewStack {
			return this._viewStack;
		}
		public function set viewStack(value:ViewStack):void {
			this._viewStack = value;
		}
		
		public function registerView():void {
			NavigationMgr.getInstance().registerView(this);
		}
	}
}
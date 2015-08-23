package com.partycommittee.manager.navigation
{
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.containers.ViewStack;

	public class NavigationMgr implements INavigationMgr {
		private static var instance:NavigationMgr;
		public function NavigationMgr() {
			if (instance) {
				throw new Error("NavigationMgr is singleton!");
			}
			instance = this;
		}
		
		public static function getInstance():NavigationMgr {
			if (instance == null) {
				instance = new NavigationMgr();
			}
			return instance;
		}
		
		private var _viewStackArry:Array;
		private var _viewDictionary:Dictionary;
		
		public function registerView(view:INavigationView):void {
			if (!this._viewStackArry) {
				this._viewStackArry = new Array();
			}
			if (view && view.viewStack) {
				this._viewStackArry.push(view);
				if (view["id"]) {
					if (!this._viewDictionary) {
						this._viewDictionary = new Dictionary();
					}
					this._viewDictionary[view["id"]] = view;
				}
			}
		}
		
		public function navigateToView(view:*):void {
			var viewStack:ViewStack;
			if (view is INavigationView) {
				viewStack = (view as INavigationView).viewStack;
				if (!viewStack) {
					return;
				}
				viewStack.selectedChild = view;
				return;
			}
			var viewId:String = view as String;
			if (!viewId || viewId == "") {
				return;
			}
			if (!this._viewDictionary || !this._viewDictionary[viewId]) {
				return;
			}
			viewStack = (this._viewDictionary[viewId] as INavigationView).viewStack;
			if (!viewStack) {
				return;
			}
			viewStack.selectedChild = this._viewDictionary[viewId];
		}
	}
}
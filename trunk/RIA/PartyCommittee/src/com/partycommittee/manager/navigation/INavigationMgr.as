package com.partycommittee.manager.navigation
{
	import mx.containers.ViewStack;
	import mx.core.UIComponent;

	public interface INavigationMgr {
		function registerView(view:INavigationView):void;
	}
}
package com.partycommittee.manager.navigation
{
	import mx.containers.ViewStack;

	public interface INavigationView {
		function set viewStack(value:ViewStack):void;
		
		function get viewStack():ViewStack;
		
		function registerView():void;
	}
}
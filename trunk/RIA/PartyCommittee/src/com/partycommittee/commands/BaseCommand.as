package com.partycommittee.commands
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.partycommittee.events.BaseEvent;
	import com.partycommittee.proxy.BaseProxy;

	public class BaseCommand implements Command {
		public function BaseCommand() {
		}
		
		protected var event:BaseEvent;
		
		public function execute(event:CairngormEvent):void {
			this.event = event as BaseEvent;
		}
		
		public function onSuccess(data:Object = null):void {
			var evt:BaseEvent = event ? event as BaseEvent : null;
			if (evt && evt.successCallback != null) {
				evt.successCallback(data, evt);
			}
		}
		
		public function onFailure(data:Object = null):void {
			var evt:BaseEvent = event ? event as BaseEvent : null;
			if (evt && evt.failureCallback != null) {
				evt.failureCallback(data, evt);
			}
		}
		
	}
}
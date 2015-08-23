package com.partycommittee.proxy
{
	import mx.rpc.Fault;
	import mx.rpc.IResponder;
	import mx.rpc.events.AbstractEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	public class BaseProxy {
		private var _responder:IResponder;
		protected function set responder(value:IResponder):void {
			this._responder = value;
		}
		
		private var _service:Object;
		protected function get service():Object {
			return this._service;
		}
		protected function set service(value:Object):void {
			this._service = value;
			if (this._service is RemoteObject) {
				this._service.addEventListener(FaultEvent.FAULT, onFault);
				this._service.addEventListener(ResultEvent.RESULT, onResult);
			}
		}
		
		protected function onFault(event:FaultEvent):void {
			if (!this._responder) {
				return;
			}
			this._responder.fault(event.fault);
			removeEventListener();
		}
		
		protected function onResult(event:ResultEvent):void {
			if (!this._responder) {
				return;
			}
			this._responder.result(event.result);
			removeEventListener();
		}
		
		private function removeEventListener():void {
			if (this._service is RemoteObject) {
				this._service.removeEventListener(FaultEvent.FAULT, onFault);
				this._service.removeEventListener(ResultEvent.RESULT, onResult);
			}
		}
	}
}
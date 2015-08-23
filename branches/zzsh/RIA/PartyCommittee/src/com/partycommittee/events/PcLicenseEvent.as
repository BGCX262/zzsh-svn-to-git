package com.partycommittee.events
{
	
	public class PcLicenseEvent extends BaseEvent {
		public static const PCLICENSE_EVENT:String = "com.partycommittee.events.PcLicenseEvent";
		
		public static const GET_LICENSE:String = "getLicense";
		
		public static const SET_LICENSE:String = "setLicense";
		
		private var _kind:String;

		public function get enstr():String
		{
			return _enstr;
		}
		
		private var _enstr:String;
		public function set enstr(value:String):void
		{
			_enstr = value;
		}

		public function set kind(value:String):void {
			this._kind = value;
		}
		public function get kind():String {
			return this._kind;
		}
		
		private var _licensetips:String;
		
		public function get licensetips():String
		{
			return _licensetips;
		}
		
		public function set licensetips(value:String):void
		{
			_licensetips = value;
		}		
		
		public function PcLicenseEvent(kind:String = "") {
			super(PCLICENSE_EVENT);
			this.kind = kind;
		}
	}
}
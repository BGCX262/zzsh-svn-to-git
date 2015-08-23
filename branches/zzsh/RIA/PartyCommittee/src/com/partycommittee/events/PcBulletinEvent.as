package com.partycommittee.events
{
	import com.partycommittee.vo.PcBulletinVo;
	import com.partycommittee.vo.page.PageHelperVo;
	
	public class PcBulletinEvent extends BaseEvent {
		public static const PCBULLETIN_EVENT:String = "com.partycommittee.events.PcBulletinEvent";
		
		public static const GET_BULLETIN_LIST:String = "getBulletinList";
		
		public static const GET_BULLETIN:String = "getBulletin";
		
		private var _bulletin:PcBulletinVo;
		
		private var _page:PageHelperVo;
		
		public function set bulletin(value:PcBulletinVo):void {
			this._bulletin = value;
		}
		public function get bulletin():PcBulletinVo {
			return this._bulletin;
		}
				
		private var _kind:String;
		public function set kind(value:String):void {
			this._kind = value;
		}
		public function get kind():String {
			return this._kind;
		}
		
		public function get page():PageHelperVo {
			return this._page;
		}
		public function set page(value:PageHelperVo):void {
			this._page = value;
		}				
		
		public function PcBulletinEvent(kind:String = "READ", bulletin:PcBulletinVo = null) {
			super(PCBULLETIN_EVENT);
			this.bulletin = bulletin;
			this.kind = kind;
		}
	}
}
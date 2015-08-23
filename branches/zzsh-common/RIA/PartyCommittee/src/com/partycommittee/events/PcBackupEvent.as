package com.partycommittee.events
{
	import com.partycommittee.vo.PcBackupVo;
	import com.partycommittee.vo.page.PageHelperVo;
	
	public class PcBackupEvent extends BaseEvent {
		public static const PCBACKUP_EVENT:String = "com.partycommittee.events.PcBackupEvent";
		
		public static const GET_BACKUP_LIST:String = "getBackupList";
				
		private var _backup:PcBackupVo;

		private var _page:PageHelperVo;
		
		private var _kind:String;
		
		public function get backup():PcBackupVo
		{
			return _backup;
		}
		
		public function set backup(value:PcBackupVo):void
		{
			_backup = value;
		}
		
		public function get page():PageHelperVo {
			return this._page;
		}
		public function set page(value:PageHelperVo):void {
			this._page = value;
		}				
				
				
		
		public function set kind(value:String):void {
			this._kind = value;
		}
		public function get kind():String {
			return this._kind;
		}
		

		public function PcBackupEvent(kind:String = "READ", backup:PcBackupVo = null) {
			super(PCBACKUP_EVENT);
			this.backup = backup;
			this.kind = kind;
		}
	}
}
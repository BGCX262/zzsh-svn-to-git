package com.partycommittee.renderers
{
	import com.partycommittee.model.ModelLocator;
	import com.partycommittee.util.DateUtil;
	
	import mx.controls.Alert;
	import mx.controls.Text;
	
	public class setupDateTimeRenderer extends Text  {
		
		public function setupDateTimeRenderer() {
			super();
		}
		
		override public function set text(txt:String):void {
			var datas:Object = data;
			if (datas.hasOwnProperty('setupDatetime')) {
				htmlText = DateUtil.toISOString(data.setupDatetime as Date);
			} else if (datas.hasOwnProperty('lastlogintime')) {
				htmlText = DateUtil.toISOString(data.lastlogintime as Date, true);
			} else if (datas.hasOwnProperty('createDatetime')) {
				htmlText = DateUtil.toISOString(data.createDatetime as Date, true);
			} 
				
		}
	}
}
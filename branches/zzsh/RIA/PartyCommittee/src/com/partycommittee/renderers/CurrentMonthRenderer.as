package com.partycommittee.renderers
{

	import com.lnczx.utils.DateUtilExt;
	
	import mx.controls.Alert;
	import mx.controls.Text;
	
	public class CurrentMonthRenderer extends Text  {
		
		public function CurrentMonthRenderer() {
			super();
		}
		
		override public function set text(txt:String):void {
			var num:Number = DateUtilExt.now().getMonth() + 1;
			htmlText = num.toString();
		}
	}
}
package com.partycommittee.renderers
{

	import mx.controls.Alert;
	import mx.controls.Text;
	
	public class CurrentMonthRenderer extends Text  {
		
		public function CurrentMonthRenderer() {
			super();
		}
		
		override public function set text(txt:String):void {
			var num:Number = new Date().getMonth() + 1;
			htmlText = num.toString();
		}
	}
}
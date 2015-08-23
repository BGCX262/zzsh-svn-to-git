package com.partycommittee.renderers
{
	import com.lnczx.utils.DateUtilExt;
	import com.partycommittee.model.ModelLocator;
	import com.partycommittee.vo.PcRemindConfigVo;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.controls.Text;
	import mx.utils.ObjectUtil;
	
	public class RemindDescriptRenderer extends Text  {
		
		
		public function RemindDescriptRenderer() {
			super();
		}
		
		
		override public function set text(txt:String):void {
			var datas:Object = data;
			var statusId:Number = parseFloat(datas.statusId);
			var tId = datas.typeId;
			var vo:PcRemindConfigVo = getRemindVo(tId);
			
			if (tId == 1) {
				htmlText = '上年'+ vo.startMonth +'月'+ vo.startDay +'日至本年' + vo.endMonth + '月 '+ vo.endDay +'日';
			}
			
			if (tId == 4) {
				htmlText = '本年'+ vo.startMonth +'月'+ vo.startDay +'日至次年' + vo.endMonth + '月 '+ vo.endDay +'日';
			}			
			
			if (tId == 2) {
				htmlText = '上季度末'+ vo.startDay +'日至本季度初'+ vo.endDay +'日';
			}	
			
			if (tId == 3) {
				htmlText = '本季度末'+ vo.startDay +'日至次季度初'+ vo.endDay +'日';
			}	
			
			if (tId > 4 && tId < 8) {
				htmlText = '每季度结束前';
			}
			
			if (tId == 8) {
				htmlText = '每月结束前';
			}
			
		}
		
		public function setValue(datas:Object):void {

			var y:Number = DateUtilExt.now().getFullYear();
			
			var cur_date:Date = DateUtilExt.now();
			var value:Number = 7;	
			var startDate:Date;
			var endDate:Date;

		}
		
		public function getRemindVo(typeId:Number):PcRemindConfigVo {
			var model:ModelLocator = ModelLocator.getInstance();
			var dd:ArrayCollection = model.remindConfigCollection;
			for(var i = 0; i < dd.length; i++ ) {
			   if ( (dd.getItemAt(i) as PcRemindConfigVo).typeId == typeId) {
				   return dd.getItemAt(i) as PcRemindConfigVo
			   }
			}
			return null;
		}
	}
}
package com.partycommittee.renderers
{
	import com.partycommittee.model.ModelLocator;
	
	import mx.controls.Alert;
	import mx.controls.Text;
	
	public class RemindStatusRenderer extends Text  {
		
		public function RemindStatusRenderer() {
			super();
		}
		
		override public function set text(txt:String):void {
			var datas:Object = data;
			var statusId:Number = parseFloat(datas.statusId);
			var typeId:Number = parseFloat(datas.typeId);
			var model:ModelLocator = ModelLocator.getInstance();
			switch (statusId) {
				case 0:
					htmlText = "未填";
					break;
				case 1:
					htmlText = "未报";
				case 2:
					htmlText  = "驳回";					
				case 3:
					//'<u><font color="#0000ff"><a href="event:getRemindList&typeId&'+datas.agencyId+'">'+datas.y1+'</a></font></u>';
					if (typeId == 1 || typeId == 2) {
						htmlText = '<u><font color="#0000ff"><a href="event:approval&'+typeId+'&'+datas.agencyId+'">未评</a></font></u>';
					} else {
						htmlText = "未评" 
						//htmlText = '<u><font color="#0000ff"><a href="event:evaluate&'+typeId+'&2&'+datas.agencyId+'">未评</a></font></u>';
					}
					break;				

					break;
				case 4:
					htmlText  = "已评语";		
					break;
				case 5:
					htmlText  = "已评价";		
					break;				
			}
		}
	}
}
package com.partycommittee.renderers
{
	import com.partycommittee.model.ModelLocator;
	import com.partycommittee.util.UserUtil;
	
	import mx.controls.Alert;
	import mx.controls.Text;
	
	public class WpStatusRenderer extends Text  {
		
		public function WpStatusRenderer() {
			super();
		}
		
		override public function set text(txt:String):void {
			var datas:Object = data;
			var statusId:Number = parseFloat(datas.statusId);
			var model:ModelLocator = ModelLocator.getInstance();
			var report:Boolean = UserUtil.checkRole(2, model.loginUser.roles);
			switch (statusId) {
				case 0:
					if (!report) {
						htmlText = "未填";
					} else {
						htmlText = '<u><font color="#0000ff"><a href="event:nowp">未填</a></font></u>';
					}
					break;
				case 1:
					if (!report) {
						htmlText = "未报";
					} else {
						htmlText = '<u><font color="#0000ff"><a href="event:nowp">未报</a></font></u>';	
					}
					break;
				case 2:
					if (!report) {
						htmlText = "驳回";
					} else {
						htmlText = '<u><font color="#0000ff"><a href="event:nowp">驳回</a></font></u>';	
					}
					break;				
				case 3:
					if (!report) {
						htmlText = "已报";
					} else {
						htmlText = '<u><font color="#0000ff"><a href="event:nowp">已报</a></font></u>';	
					}
					break;				
				case 4:
					if (!report) {
						htmlText = "已评语";
					} else {
						htmlText = '<u><font color="#0000ff"><a href="event:nowp">已评语</a></font></u>';	
					}	
					break;
				case 5:
					if (!report) {
						htmlText = "已评价";
					} else {
						htmlText = '<u><font color="#0000ff"><a href="event:nowp">已评价</a></font></u>';	
					}	
					break;				
				case 8:
					htmlText = "已解锁";	
					break;
				case 9:
					htmlText = "已锁定";
					break;
			}
		}
	}
}
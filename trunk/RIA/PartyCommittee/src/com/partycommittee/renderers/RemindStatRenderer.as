package com.partycommittee.renderers
{
	import com.partycommittee.model.ModelLocator;
	
	import mx.controls.Alert;
	import mx.controls.Text;
	import mx.controls.dataGridClasses.DataGridListData;
	import mx.controls.listClasses.BaseListData;
	
	import spark.components.mediaClasses.VolumeBar;
	
	public class RemindStatRenderer extends Text  {
		
		protected var _listData:DataGridListData;	
		protected var _snum:Number;
		
		public function RemindStatRenderer() {
			super();
		}

		override public function set data(value:Object):void {
			setIt(value);
		}
		
		override public function get listData():BaseListData	{
			return _listData;
		}
		
		override public function set listData(value:BaseListData):void	{
			_listData = DataGridListData(value);
			invalidateProperties();
		}
		
		private function setIt(value:Object):void	{
			if(value && _listData)	{
				if (value.q == 1) {
					setValueQ1(value);
				} else {
					setValueQ(value);
				}
			}
		}		
		
		private function setValueQ1(value:Object):void {
			var datas:Object = value;
			if (_listData.columnIndex == 0)	{
				//'<u><font color="#0000ff"><a href="event:getRemindList&typeId&statusId&'+datas.agencyId+'">'+datas.y1+'</a></font></u>';
			} else if(_listData.columnIndex == 1)	{
				if (datas.y1 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&1&1&'+datas.agencyId+'">'+datas.y1+'</a></font></u>';
				} else {
					htmlText = datas.y1;
				}
			} else if(_listData.columnIndex == 2)	{
				if (datas.y2 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&1&3&'+datas.agencyId+'">'+datas.y2+'</a></font></u>';
				} else {
					htmlText = datas.y2;
				}					
			} else if(_listData.columnIndex == 3)	{
				if (datas.lq1 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&3&1&'+datas.agencyId+'">'+datas.lq1+'</a></font></u>';
				} else {
					htmlText = datas.lq1;
				}					
			} else if(_listData.columnIndex == 4)	{
				if (datas.lq2 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&3&3&'+datas.agencyId+'">'+datas.lq2+'</a></font></u>';
				} else {
					htmlText = datas.lq2;
				}					
			} else if(_listData.columnIndex == 5)	{
				if (datas.ly1 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&4&1&'+datas.agencyId+'">'+datas.ly1+'</a></font></u>';
				} else {
					htmlText = datas.ly1;
				}					
			} else if(_listData.columnIndex == 6)	{
				if (datas.ly2 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&4&3&'+datas.agencyId+'">'+datas.ly2+'</a></font></u>';
				} else {
					htmlText = datas.ly2;
				}					
			} else if(_listData.columnIndex == 7)	{
				if (datas.q1 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&2&1&'+datas.agencyId+'">'+datas.q1+'</a></font></u>';
				} else {
					htmlText = datas.q1;
				}					
			} else if(_listData.columnIndex == 8)	{
				if (datas.q2 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&2&3&'+datas.agencyId+'">'+datas.q2+'</a></font></u>';
				} else {
					htmlText = datas.q2;
				}					
			} else if(_listData.columnIndex == 9)	{
				if (datas.dk1 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&5&1&'+datas.agencyId+'">'+datas.dk1+'</a></font></u>';
				} else {
					htmlText = datas.dk1;
				}	
				
			} else if(_listData.columnIndex == 10)	{
				if (datas.dk2 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&5&3&'+datas.agencyId+'">'+datas.dk2+'</a></font></u>';
				} else {
					htmlText = datas.dk2;
				}	
				
			} else if(_listData.columnIndex == 11)	{
				if (datas.dydh1 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&6&1&'+datas.agencyId+'">'+datas.dydh1+'</a></font></u>';
				} else {
					htmlText = datas.dydh1;
				}		
				
			} else if(_listData.columnIndex == 12)	{
				if (datas.dydh2 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&6&3&'+datas.agencyId+'">'+datas.dydh2+'</a></font></u>';
				} else {
					htmlText = datas.dydh2;
				}				
				
				
			} else if(_listData.columnIndex == 13)	{
				if (datas.mzshh1 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&7&1&'+datas.agencyId+'">'+datas.mzshh1+'</a></font></u>';
				} else {
					htmlText = datas.mzshh1;
				}	
				
			} else if(_listData.columnIndex == 14)	{
				if (datas.mzshh2 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&7&3&'+datas.agencyId+'">'+datas.mzshh2+'</a></font></u>';
				} else {
					htmlText = datas.mzshh2;
				}	
				
			} else if(_listData.columnIndex == 15)	{
				if (datas.zbwyh1 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&8&1&'+datas.agencyId+'">'+datas.zbwyh1+'</a></font></u>';
				} else {
					htmlText = datas.zbwyh1;
				}	
				
			} else if(_listData.columnIndex == 16)	{
				if (datas.zbwyh2 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&8&3&'+datas.agencyId+'">'+datas.zbwyh2+'</a></font></u>';
				} else {
					htmlText = datas.zbwyh2;
				}				
				
			}
		}
		
		private function setValueQ(value:Object):void {
			
			
			var datas:Object = value;
			if (_listData.columnIndex == 0)	{
				//'<u><font color="#0000ff"><a href="event:getRemindList&typeId&statusId&'+datas.agencyId+'">'+datas.y1+'</a></font></u>';
			} else if(_listData.columnIndex == 1)	{
				if (datas.y1 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&1&1&'+datas.agencyId+'">'+datas.y1+'</a></font></u>';
				} else {
					htmlText = datas.y1;
				}
			} else if(_listData.columnIndex == 2)	{
				if (datas.y2 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&1&3&'+datas.agencyId+'">'+datas.y2+'</a></font></u>';
				} else {
					htmlText = datas.y2;
				}					
			} else if(_listData.columnIndex == 3)	{
				if (datas.lq1 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&3&1&'+datas.agencyId+'">'+datas.lq1+'</a></font></u>';
				} else {
					htmlText = datas.lq1;
				}					
			} else if(_listData.columnIndex == 4)	{
				if (datas.lq2 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&3&3&'+datas.agencyId+'">'+datas.lq2+'</a></font></u>';
				} else {
					htmlText = datas.lq2;
				}					
					
			} else if(_listData.columnIndex == 5)	{
				if (datas.q1 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&2&1&'+datas.agencyId+'">'+datas.q1+'</a></font></u>';
				} else {
					htmlText = datas.q1;
				}					
			} else if(_listData.columnIndex == 6)	{
				if (datas.q2 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&2&3&'+datas.agencyId+'">'+datas.q2+'</a></font></u>';
				} else {
					htmlText = datas.q2;
				}					
			} else if(_listData.columnIndex == 7)	{
				if (datas.dk1 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&5&1&'+datas.agencyId+'">'+datas.dk1+'</a></font></u>';
				} else {
					htmlText = datas.dk1;
				}	
				
			} else if(_listData.columnIndex == 8)	{
				if (datas.dk2 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&5&3&'+datas.agencyId+'">'+datas.dk2+'</a></font></u>';
				} else {
					htmlText = datas.dk2;
				}	
				
			} else if(_listData.columnIndex == 9)	{
				if (datas.dydh1 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&6&1&'+datas.agencyId+'">'+datas.dydh1+'</a></font></u>';
				} else {
					htmlText = datas.dydh1;
				}		
				
			} else if(_listData.columnIndex == 10)	{
				if (datas.dydh2 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&6&3&'+datas.agencyId+'">'+datas.dydh2+'</a></font></u>';
				} else {
					htmlText = datas.dydh2;
				}				
				
				
			} else if(_listData.columnIndex == 11)	{
				if (datas.mzshh1 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&7&1&'+datas.agencyId+'">'+datas.mzshh1+'</a></font></u>';
				} else {
					htmlText = datas.mzshh1;
				}	
				
			} else if(_listData.columnIndex == 12)	{
				if (datas.mzshh1 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&7&3&'+datas.agencyId+'">'+datas.mzshh2+'</a></font></u>';
				} else {
					htmlText = datas.mzshh2;
				}	
				
			} else if(_listData.columnIndex == 13)	{
				if (datas.zbwyh1 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&8&1&'+datas.agencyId+'">'+datas.zbwyh1+'</a></font></u>';
				} else {
					htmlText = datas.zbwyh1;
				}	
				
			} else if(_listData.columnIndex == 14)	{
				if (datas.zbwyh2 > 0) {
					htmlText = '<u><font color="#0000ff"><a href="event:getRemindList&8&3&'+datas.agencyId+'">'+datas.zbwyh2+'</a></font></u>';
				} else {
					htmlText = datas.zbwyh2;
				}				
				
			}
		}
		
		
		
	}
}
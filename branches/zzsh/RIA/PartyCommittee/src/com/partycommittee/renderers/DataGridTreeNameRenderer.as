package com.partycommittee.renderers
{

	import mx.controls.Alert;
	import mx.controls.DataGrid;
	import mx.controls.Text;
	import mx.controls.dataGridClasses.DataGridListData;
	import mx.controls.listClasses.BaseListData;
	
	public class DataGridTreeNameRenderer extends Text  {
		
		public function DataGridTreeNameRenderer() {
			super();
		}
		
		protected var _listData:DataGridListData;	
		protected var _snum:Number;
		
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
				if (_listData.rowIndex == 0) {
					htmlText = value.name;
				} else {
					htmlText = "  " + value.name;
				}
			}
		}
	}
}
package com.lnczx.utils
{
	
	import flash.errors.*;
	import flash.events.*;
	import flash.external.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	
	import mx.controls.AdvancedDataGrid;
	import mx.controls.Alert;
	import mx.controls.DataGrid;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumnGroup;
	import mx.controls.dataGridClasses.DataGridColumn;
	
	public class ExportExcelExtend
	{
		public function ExportExcelExtend()
		{
		}
		/** 在导出数据的时候有可能出现单元格数据长度过长而导致Excel在显示时   
		 *  出现科学计数法或者#特殊符号，在此设置单元格宽度比例WIDTHSCALE，在   
		 *  代码中每个单元格的宽度扩展适当的比例值WIDTHSCALE。   
		 */   
		private static var WIDTHSCALE:Number=2.0;   
		
		/**   
		 * 将DataGrid转换为htmltable   
		 * @author rentao   
		 * @param: dg 需要转换成htmltable的DataGrid   
		 * @return: String   
		 */   
		private static function convertDGToHTMLTable(dg:DataGrid):String {   
			//设置默认的DataGrid样式   
			var font:String = dg.getStyle('fontFamily');   
			var size:String = dg.getStyle('fontSize');   
			var str:String = '';   
			var colors:String = '';   
			var style:String = 'style="font-family:'+font+';font-size:'+size+'pt;"';                   
			var hcolor:Array;   
			
			//检索DataGrid的 headercolor   
			if(dg.getStyle("headerColor") != undefined) {   
				hcolor = [dg.getStyle("headerColor")];   
			} else {   
				hcolor = dg.getStyle("headerColors");   
			}                  
			
			//   Alert.show(hcolor+"");
			var x :String = "" ;
			if(hcolor == null){
				x = "0x323232" ;
			}else{
				x = Number((hcolor[0])).toString(16);
			}
			str+="<style　type='text/css'>.format{mso-number-format:'\@';}</style>";
			//   str+= '<table width="'+dg.width+'" border="1"><thead><tr width="'+dg.width+'" style="background-color:#' +Number((hcolor[0])).toString(16)+'">';   
			str+= '<table align="center" width="'+dg.width+'" border="1"><thead><tr width="'+dg.width+'" style="background-color:#' +x+'">';  
			
			//设置tableheader数据(从datagrid的header检索headerText信息)                  
			for(var i:int = 0;i<dg.columns.length;i++) {   
				colors = dg.getStyle("themeColor");   
				
				if(dg.columns[i].dataField == null || dg.columns[i].dataField == ""){}else{ //表示不是操作列
					if(dg.columns[i].headerText != undefined) {   
						str+="<th "+style+">"+dg.columns[i].headerText+"</th>";   
					} else {   
						str+= "<th "+style+">"+dg.columns[i].dataField+"</th>";   
					} 
				}
				
			}   
			str += "</tr></thead>";   
			colors = dg.getStyle("alternatingRowColors");   
			
			for(var j:int =0;j<dg.dataProvider.length;j++) {                    
				str+="<tr width=\""+Math.ceil(dg.width)+"\">";   
				
				for(var k:int=0; k < dg.columns.length; k++) {   
					
					if(dg.dataProvider.getItemAt(j) != undefined && dg.dataProvider.getItemAt(j) != null) {   
						if((dg.columns[k] as DataGridColumn).dataField == null || (dg.columns[k] as DataGridColumn).dataField == ""){}else{   //表示的是字段列
							if((dg.columns[k] as DataGridColumn).labelFunction != undefined) { 
								var dataGridColumn:DataGridColumn = dg.columns[k] as DataGridColumn ;
								//       str += "<td width=\""+Math.ceil((dg.columns[k] as DataGridColumn).width*WIDTHSCALE)+"\" "+style+">"+(dg.columns[k] as DataGridColumn).labelFunction(dg.dataProvider.getItemAt(j),dg.columns[k].dataField)+"</td>"; 
								str += "<td align='center' width=\""+Math.ceil(dataGridColumn.width*WIDTHSCALE)+"\" "+style+ " Class='format'>"+dataGridColumn.labelFunction(dg.dataProvider.getItemAt(j),dataGridColumn)+"</td>";
								//       //"+dg.columns[k].labelFunction(dg.dataProvider.getItemAt(j),dg.columns[k].dataField)+"
							} else {   
								str += "<td align='center' width=\""+Math.ceil(dg.columns[k].width*WIDTHSCALE)+"\" "+style+ " Class='format'>"+(dg.dataProvider.getItemAt(j)[(dg.columns[k] as DataGridColumn).dataField] == null ?"":dg.dataProvider.getItemAt(j)[(dg.columns[k] as DataGridColumn).dataField])+"</td>";   
							}   
						}
					}   
				}   
				str += "</tr>";   
			}   
			str+="</table>";   
			
			return str;   
		}   
		
		
		/**
		 * AdvancedDataGrid木有合并单元格
		 * **/
		private static function getAdvancedDGColMergeCellsNot(dg:AdvancedDataGrid,style:String,str:String):String{
			var colors:String = '';
			for(var i:int = 0;i<dg.columns.length;i++) {
				colors = dg.getStyle("themeColor");
				if(dg.columns[i].headerText != undefined) {
					str+="<th "+style+">"+dg.columns[i].headerText+"</th>";
				} else {
					str+= "<th "+style+">"+dg.columns[i].dataField+"</th>";
				}
			}
			return str ;
		}
		
		/**
		 * AdvancedDataGrid合并单元格
		 * 1.支持标题合并列的情况
		 * **/
		private static function getAdvancedDGColMergeCellsYes(dg:AdvancedDataGrid,style:String,str:String,hcolor:Array):String{
			var colors:String = '';
			for(var i:int = 0;i<dg.groupedColumns.length;i++) {
				colors = dg.getStyle("themeColor");
				if( dg.groupedColumns[i].hasOwnProperty("children") ) { //表示有子列
					var len:int = 0;
					len = getColumnLength(dg.groupedColumns[i], len);
					str+= '<th '+style+' colspan='+len+'><table width="'+dg.width+'" border="1"><thead><tr width="'+dg.width+'" style="background-color:#' +Number((hcolor[0])).toString(16)+'">';
					//1.合并单元格
					if( (dg.groupedColumns[i].headerText!=undefined) && (dg.groupedColumns[i].children.length>0) ){
						str+="<th "+style+" colspan="+len+">"+dg.groupedColumns[i].headerText+"</th>";
					}else {
						str+="<th "+style+" >"+dg.groupedColumns[i].dataField+"</th>";
					}
					str+= '</tr><tr width="'+dg.width+'" style="background-color:#' +Number((hcolor[0])).toString(16)+'">';
					//2.合并单元格
					for(var j:int = 0;j<dg.groupedColumns[i].children.length; j++ ) {
						if(dg.groupedColumns[i].children[j].hasOwnProperty("children") ) { //表示有子列
							
							str = doAdvancedDGColMergeCellsYes(dg.groupedColumns[i].children[j], dg.width, style, str, hcolor);
						} else {
							if(dg.groupedColumns[i].children[j].headerText!=undefined){    
								str+="<th "+style+">"+dg.groupedColumns[i].children[j].headerText+"</th>";
							} else {
								str+= "<th "+style+">"+dg.groupedColumns[i].children[j].dataField+"</th>";
							}
						}
					}
					str += "</tr></thead></table></th>";//获取子列完成-------------------
				} else { //表示没有子列
					if(dg.groupedColumns[i].headerText != undefined) {  
						str+="<th "+style+">"+dg.groupedColumns[i].headerText+"</th>";
					} else {
						str+= "<th "+style+">"+dg.groupedColumns[i].dataField+"</th>";
					}
				}
			}
			return str ;
		}
		
		// 获取子列真正个数，包括子列还有子列的个数
		private static function getColumnLength(column:AdvancedDataGridColumnGroup, len:int):int {
			for(var j:int = 0;j<column.children.length; j++ ) {
				if( column.children[j].hasOwnProperty("children") ) { //表示有子列
					len = getColumnLength(column.children[j], len);
				} else {
					len++;
				}
			}
			return len;
		}
		
		// 处理有子列的情况
		private static function doAdvancedDGColMergeCellsYes(column:AdvancedDataGridColumnGroup, w:Number, style:String, str:String, hcolor:Array):String{
			if( column.hasOwnProperty("children") ) { //表示有子列
				
				var len:int = 0;
				len = getColumnLength(column, len);				
				
				str+= '<th '+style+' colspan='+len+'><table width="'+w+'" border="1"><thead><tr width="'+w+'" style="background-color:#' +Number((hcolor[0])).toString(16)+'">';
				//1.合并单元格
				if( (column.headerText!=undefined) && (column.children.length>0) ){
					str+="<th "+style+" colspan="+len+">"+column.headerText+"</th>";
				}else {
					str+="<th "+style+" >"+column.dataField+"</th>";
				}
				str+= '</tr><tr width="'+w+'" style="background-color:#' +Number((hcolor[0])).toString(16)+'">';
				//2.合并单元格
				for(var j:int = 0;j<column.children.length; j++ ) {
					if(column.children[j].hasOwnProperty("children") ) { //表示有子列
						str = doAdvancedDGColMergeCellsYes(column.children[j], w, style, str, hcolor);
					} else {
						if(column.children[j].headerText!=undefined){    
							str+="<th "+style+">"+column.children[j].headerText+"</th>";
						} else {
							str+= "<th "+style+">"+column.children[j].dataField+"</th>";
						}
					}
				}
				str += "</tr></thead></table></th>";//获取子列完成-------------------
			}
			return str; 
		}
		
		/**
		 * AdvancedDataGrid导出excel
		 * 1.支持不合并的情况
		 * 1.支持标题合并列的情况
		 * 
		 * **/
		public  static function convertAdvancedDGToHTMLTable(dg:AdvancedDataGrid,hStr:String):String {
			var font:String = dg.getStyle('fontFamily');
			var size:String = dg.getStyle('fontSize');
			var str:String = '';
			var colors:String = '';
			var style:String = 'style="font-family:'+font+';font-size:'+size+'pt;"';               
			var hcolor:Array;
			//Retrieve the headercolor
			if(dg.getStyle("headerColor") != undefined) {
				hcolor = [dg.getStyle("headerColor")];
			} else {
				hcolor = dg.getStyle("headerColors");
			}               
			//style="font-size:18pt;fontWeight=bold"
			//Set the htmltabel based upon knowlegde from the datagrid
			str+= '<table width="'+dg.width+'" border="1"><caption align=center ><span style="font-size:18pt;fontWeight=bold">'+hStr+'</span></caption><thead><tr width="'+dg.width+'" style="background-color:#' +Number((hcolor[0])).toString(16)+'">';
			//Set the tableheader data (retrieves information from the datagrid header        
			
			//获取AdvancedDataGrid的列
			if(dg.groupedColumns.length == dg.columns.length){ //表示没有合并单元格
				str = getAdvancedDGColMergeCellsNot(dg,style,str);
			} else { //表示合并了单元格
				str = getAdvancedDGColMergeCellsYes(dg,style,str,hcolor);
			}
			
			str += "</tr></thead><tbody>";
			colors = dg.getStyle("alternatingRowColors");
			//Loop through the records in the dataprovider and
			//insert the column information into the table
			for(var j:int =0;j<dg.dataProvider.length;j++) {                   
				str+="<tr width=\""+Math.ceil(dg.width)+"\">";
				for(var k:int=0; k < dg.columns.length; k++) {
					//Do we still have a valid item?                       
					if(dg.dataProvider.getItemAt(j) != undefined && dg.dataProvider.getItemAt(j) != null) {
						//Check to see if the user specified a labelfunction which we must
						//use instead of the dataField
						if(dg.columns[k].labelFunction != undefined) {
							str += "<td text-align='center' width=\""+Math.ceil(dg.columns[k].width)+"\" "+style+">"+dg.columns[k].labelFunction(dg.dataProvider.getItemAt(j),dg.columns[k])+"</td>";
						} else {
							//Our dataprovider contains the real data
							//We need the column information (dataField)
							//to specify which key to use.
							str += "<td text-align='center' width=\""+Math.ceil(dg.columns[k].width)+"\" "+style+">"+(dg.columns[k].dataField == null ? "" : dg.dataProvider.getItemAt(j)[dg.columns[k].dataField.toString()])+"</td>";
						}
					}
				}
				str += "</tr>";
			}
			str+="</tbody></table>";
			return str;
		} 
		
		/**   
		 * 将制定的DataGrid加载到Excel文件，此方法传入一个htmltable字符串参数到后台Script脚本，然后浏览器给用户提供一个Excel下载   
		 * @author Chenwenfeng   
		 * @params dg 需要导入的数据源DataGrid   
		 * @params url excel文件下载路径   
		 */   
		public static function loadDGInExcel(dg:*,url:String,title:String=''):void {   
			
			//设置URLVariables参数变量，动态增加属性htmltable   
			var variables:URLVariables = new URLVariables();
			
			if(dg is DataGrid){
				variables.htmltable = convertDGToHTMLTable(dg);   
			}else if (dg is AdvancedDataGrid) {
				variables.htmltable = convertAdvancedDGToHTMLTable(dg,title);  
			}
			if(title!=""){
				variables.title = encodeURIComponent(title);
			}
			
			var u:URLRequest = new URLRequest(url);   
			u.data = variables;   
			u.method = URLRequestMethod.POST;   
			
			navigateToURL(u,"_self");
			//"_self" 指定当前窗口中的当前帧。    
			//"_blank" 指定一个新窗口。    
			//"_parent" 指定当前帧的父级。    
			//"_top" 指定当前窗口中的顶级帧。   
		}  
		
	}
}
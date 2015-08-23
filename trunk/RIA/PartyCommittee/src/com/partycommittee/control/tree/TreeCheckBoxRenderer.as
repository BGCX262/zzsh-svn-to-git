package com.partycommittee.control.tree
{
	import com.partycommittee.control.tree.classes.ErrorNode;
	import com.partycommittee.control.tree.classes.LoadingNode;
	
	import flash.events.Event;
	
	import mx.controls.CheckBox;
	import mx.controls.treeClasses.TreeItemRenderer;
	import mx.controls.treeClasses.TreeListData;
	
	public class TreeCheckBoxRenderer extends TreeItemRenderer {
		public function TreeCheckBoxRenderer() {
			super();
		}
		
		private var _selectedField:String = "ckSelected";
		
		protected var checkBox:CheckBox;
		
		override protected function createChildren():void {
			super.createChildren();
			checkBox = new CheckBox();
			addChild(checkBox);
			checkBox.addEventListener(Event.CHANGE, changeHandler);
		}
		
		protected function changeHandler(event:Event):void {
			if (data && data[_selectedField] != undefined) {
				data[_selectedField] = checkBox.selected;
			}
		}
		
		override protected function commitProperties():void {
			super.commitProperties();
			if (data is LoadingNode || data is ErrorNode) {
				checkBox.visible = checkBox.includeInLayout = false;
			} else {
				checkBox.visible = checkBox.includeInLayout = true;
			}
			if (data && data.hasOwnProperty(_selectedField)) {
				checkBox.selected = data[_selectedField];
			} else {
				checkBox.selected = false;
			}
		}
		
		override protected function measure():void {
			super.measure();
			measuredWidth += checkBox.getExplicitOrMeasuredWidth();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			var startx:Number = data ? TreeListData(listData).indent : 0;
			if (disclosureIcon) {
				disclosureIcon.x = startx;
				startx = disclosureIcon.x + disclosureIcon.width +4;
				disclosureIcon.setActualSize(disclosureIcon.width,
					disclosureIcon.height);
				disclosureIcon.visible = data ?
					TreeListData(listData).hasChildren : false;
			}
			
			if (icon) {
				icon.x = startx + checkBox.getExplicitOrMeasuredWidth() + 4;
				icon.setActualSize(icon.measuredWidth, icon.measuredHeight);
				label.x = icon.x + icon.width +4;
			} else {
				label.x = startx + checkBox.getExplicitOrMeasuredWidth();
			}
			
			checkBox.move(startx, (unscaledHeight - checkBox.height) / 2);
		}
	}
}
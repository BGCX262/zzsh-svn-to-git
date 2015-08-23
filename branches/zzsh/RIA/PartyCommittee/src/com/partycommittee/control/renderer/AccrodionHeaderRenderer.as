package com.partycommittee.control.renderer
{
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	import mx.controls.Button;

	public class AccrodionHeaderRenderer extends Button {
		
		public static const selectedFilter:GlowFilter = new GlowFilter(0xFFFFFF, 0.1, 5, 5, 10, 1, false);
		public static const mouseOverFilter:GlowFilter = new GlowFilter(0xFFFFFF, 0.1, 5, 5, 10, 1, false);
		
		public function AccrodionHeaderRenderer() {
			super();
			this.styleName = "accrodionHeader";
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		protected function onMouseOver(event:MouseEvent):void {
			this.textField.filters = [mouseOverFilter];
		}
		
		protected function onMouseOut(event:MouseEvent):void {
			updateFilter();
		}
		
		override protected function clickHandler(event:MouseEvent):void {
			updateFilter();
		}
		
		private function updateFilter():void {
			if (selected) {
				this.textField.filters = [selectedFilter];
			} else {
				this.textField.filters = [];
			}
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			updateFilter();
		}
	}
}
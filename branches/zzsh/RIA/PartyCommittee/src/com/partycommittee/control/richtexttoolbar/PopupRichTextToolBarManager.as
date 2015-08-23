package com.partycommittee.control.richtexttoolbar
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import mx.controls.TextArea;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	import mx.managers.SystemManager;

	public class PopupRichTextToolBarManager
	{
		private static var _textAreaDic:Dictionary = new Dictionary();
		public static const DEFAULT_TIPS:String = "点击显示控制面板";
		
		public static function addTarget(textArea:TextArea):void
		{	
			textArea.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
			
		}
		
		public static function removeTarget(textArea:TextArea):void
		{
			textArea.removeEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
		}
		
		private static function stageMouseDownHandler(event:MouseEvent):void
		{			
			for each(var toolbar:PopupRichTextToolBar in _textAreaDic)
			{
				if(toolbar)
				{
					if(event.target is SystemManager)
					{
						toolbar.tryRemoveToolbar(event.target,new Point(event.localX,event.localY));
					}
					else
					{
						toolbar.tryRemoveToolbar(event.target);
					}
				}
			}		
		}
		
		private static function mouseUpHandler(event:Event):void
		{										
			popupToolbar(event.currentTarget as TextArea);
		}
		
		
		private static function focusOutHandler(event:FocusEvent):void
		{
			setTextAreaTips(event.currentTarget as TextArea);	
		}
		
		private static function setTextAreaTips(textArea:TextArea):void
		{
			if(textArea.text=="")
			{
				textArea.text = DEFAULT_TIPS;
			}
		}
		
		private static function clearTextAreaTips(textArea:TextArea):void
		{
			if(textArea.text == DEFAULT_TIPS)
			{
				textArea.text = "";
			}	
		}
		
		private static function popupToolbar(textArea:TextArea):void
		{			
			if(_textAreaDic[textArea] == null && textArea.stage)
			{						
				textArea.stage.addEventListener(MouseEvent.MOUSE_DOWN, stageMouseDownHandler);	
				var toolbar:PopupRichTextToolBar = PopUpManager.createPopUp(textArea.parent,PopupRichTextToolBar) as PopupRichTextToolBar;
				toolbar.target = textArea;			
				toolbar.addEventListener(CloseEvent.CLOSE,closeHandler);
				_textAreaDic[textArea] = toolbar;				
			}	
		}

		// remove reference for gc
		private static function closeHandler(event:CloseEvent):void
		{			
			var toolbar:PopupRichTextToolBar = event.currentTarget as PopupRichTextToolBar;
			toolbar.removeEventListener(CloseEvent.CLOSE,closeHandler);						

			if(toolbar.target.stage)
			{
				toolbar.target.stage.removeEventListener(MouseEvent.MOUSE_DOWN,stageMouseDownHandler);
			}
			
			_textAreaDic[toolbar.target] = null;
			PopUpManager.removePopUp(toolbar);										
		}
	}
}
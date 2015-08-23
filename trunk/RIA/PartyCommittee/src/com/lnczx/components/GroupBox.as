package com.lnczx.components
{  
	import spark.components.SkinnableContainer;  
	import spark.components.supportClasses.TextBase;  
	/**  
	 *  The alpha of the border for this component.  
	 *  
	 *  @default 0.5  
	 *   
	 *  @langversion 3.0  
	 *  @playerversion Flash 10  
	 *  @playerversion AIR 1.5  
	 *  @productversion Flex 4  
	 */  
	[Style(name="borderAlpha", type="Number", inherit="no", theme="spark")]  
	
	/**  
	 *  The color of the border for this component.  
	 *  
	 *  @default 0  
	 *   
	 *  @langversion 3.0  
	 *  @playerversion Flash 10  
	 *  @playerversion AIR 1.5  
	 *  @productversion Flex 4  
	 */  
	[Style(name="borderColor", type="uint", format="Color", inherit="no", theme="spark")]  
	/**  
	 *  The radius of the corners for this component.  
	 *  
	 *  @default 5  
	 *   
	 *  @langversion 3.0  
	 *  @playerversion Flash 10  
	 *  @playerversion AIR 1.5  
	 *  @productversion Flex 4  
	 */  
	[Style(name="cornerRadius", type="Number", format="Length", inherit="no", theme="spark")]  
	
	public class GroupBox extends SkinnableContainer  
	{  
		public function GroupBox()  
		{  
			super();  
		}  
		//----------------------------------  
		//  titleField  
		//----------------------------------   
		
		[SkinPart(required="false")]  
		
		/**  
		 *  定义容器中标题文本的外观的外观部件。  
		 *  
		 *  @see jx.skins.GroupBoxSkin  
		 *    
		 *  @langversion 3.0  
		 *  @playerversion Flash 10  
		 *  @playerversion AIR 1.5  
		 *  @productversion Flex 4  
		 */  
		public var titleDisplay:TextBase;  
		
		
		//----------------------------------  
		//  title  
		//----------------------------------  
		
		/**  
		 *  @private  
		 */  
		private var _title:String = "";  
		
		/**  
		 *  @private  
		 */  
		private var titleChanged:Boolean;  
		
		[Bindable]  
		
		/**  
		 *  标题或者说明。  
		 *  @default ""  
		 *  @langversion 3.0  
		 *  @playerversion Flash 10  
		 *  @playerversion AIR 1.5  
		 *  @productversion Flex 4  
		 */  
		public function get title():String   
		{  
			return _title;  
		}  
		
		/**  
		 *  @private  
		 */  
		public function set title(value:String):void   
		{  
			_title = value;  
			
			if (titleDisplay)  
				titleDisplay.text = title;  
		}  
		override protected function partAdded(partName:String, instance:Object):void  
		{  
			super.partAdded(partName, instance);  
			
			if (instance == titleDisplay)  
			{  
				titleDisplay.text = title;  
			}  
		}         
	}  
}  
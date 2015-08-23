package com.partycommittee.control.tree.classes
{
	import mx.collections.ArrayCollection;

   /**
    * The node with loading stat.
    */
	public class LoadingNode
	{
		private var _parentId:String;

		/**
		 * Default constructor
		 */
		public function LoadingNode() {
		}

		/**
		 * Will always return the 'loading' display string
		 */
		public function get label():String {
			return "loading...";
		}

		public function set label(value:String):void {
			// Do nothing
		}

		/**
		 * Node has no Id
		 */
		public function get id():String {
			return null;
		}
		public function set id(value:String):void {
			// Do nothing
		}

		/**
		 * Node has no inventoryNodeSpecId
		 */
		public function get inventoryNodeSpecId():String {
			return null;
		}
		public function set inventoryNodeSpecId(value:String):void {
			// Do nothing
		}

		/**
		 * Node consumer should set the parent node as it cannot be
		 * automatically inferred
		 */
		public function get parentId():String {
			return _parentId;
		}
		public function set parentId(value:String):void {
			_parentId = value;
		}

		public function get icon():Class {
			return null;
		}

	}
}

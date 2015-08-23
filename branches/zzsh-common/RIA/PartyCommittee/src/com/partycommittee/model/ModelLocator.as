package com.partycommittee.model 
{
	import com.partycommittee.control.tree.LoadingTree;
	import com.partycommittee.vo.PcAgencyVo;
	import com.partycommittee.vo.PcUserVo;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.containers.ViewStack;
	
    [Bindable]
	public final class ModelLocator extends EventDispatcher {
		private static var instance:ModelLocator;

		public function ModelLocator(access:Private) {
			if (access == null) {
			    throw new Error("ModelLocator is singleton!");
			}
			instance = this;
		}
		
		private var _remindConfigCollection:ArrayCollection;		 
		public function get remindConfigCollection():ArrayCollection
		{
			return _remindConfigCollection;
		}

		public function set remindConfigCollection(value:ArrayCollection):void
		{
			_remindConfigCollection = value;
		}

		public static function getInstance():ModelLocator {
			if (instance == null) {
				instance = new ModelLocator(new Private());
			}
			return instance;
		}
		
		private var _treeCollection:ArrayCollection;
		public function get treeCollection():ArrayCollection {
			return this._treeCollection;
		}
		public function set treeCollection(value:ArrayCollection):void {
			this._treeCollection = value;
		}
		

		
		
		private var _tree:LoadingTree;
		public function get tree():LoadingTree {
			return this._tree;
		}
		public function set tree(value:LoadingTree):void {
			this._tree = value;
		}
	 	
		public var loginUser:PcUserVo;
		public var focusAgencyVo:PcAgencyVo;
		
		public var LOGIN_PAGE:String;
		public var INDEX_PAGE:String;
		
		public var selectedMenu:Object;
		
		public var isTreeInitialized:Boolean = false;
		
		public var reportYear:Number;
		
		public var isLeafUser:Boolean = false;
		public var leafAgency:PcAgencyVo;
		
		private var _roleCollection:ArrayCollection;

		public function get roleCollection():ArrayCollection
		{
			return _roleCollection;
		}

		public function set roleCollection(value:ArrayCollection):void
		{
			_roleCollection = value;
		}
		
		private var _dutyCodeCollection:ArrayCollection;

		public function get dutyCodeCollection():ArrayCollection
		{
			return _dutyCodeCollection;
		}

		public function set dutyCodeCollection(value:ArrayCollection):void
		{
			_dutyCodeCollection = value;
		}
		private var _bulletinCollection:ArrayCollection;

		public function get bulletinCollection():ArrayCollection
		{
			return _bulletinCollection;
		}

		public function set bulletinCollection(value:ArrayCollection):void
		{
			_bulletinCollection = value;
		}

		
	}
}

/**
 * Inner class which restricts constructor access to Private
 */
class Private {}

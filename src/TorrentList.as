package
{
	import flash.events.EventDispatcher;
	
	import mx.collections.IList;

	
	
	public class TorrentList extends EventDispatcher implements IList
	{
		private var internalList:Vector.<Torrent>; 
		public function TorrentList()
		{
			internalList = new Vector.<Torrent>();
		}
		
		public function addItem(item:Object): void {
			internalList.push(makeTorrentForObject(item));
		}
		private function makeTorrentForObject(item:Object) : Torrent {
			var torrent:Torrent = new Torrent();
			torrent.jsonRepresentation = item;
			return torrent;
		}
		
		private function getObjectFromTorrent(torrent:Torrent) : Object {
			return torrent.jsonRepresentation;
		}
		
		public function addItemAt(item:Object, index:int) :void {
			internalList.splice(index,0,makeTorrentForObject(item));
		}
		
		public function get length():int {
			return internalList.length;
		}
		
		public function getItemAt(index:int, prefetch:int = 0) : Object {
			return getObjectFromTorrent(internalList[index]);
		}
		
		public function getItemIndex(torrent:Object):int {
			return internalList.indexOf(torrent);
		}
		
		public function itemUpdated(item:Object,property:Object=null,oldValue:Object = null,newValue:Object = null):void {
			
		}
		
		public function toArray():Array {
			var ary:Array = new Array();
			for each (var item:Torrent in internalList)  {
				ary.push(item.jsonRepresentation);
			}
			return ary;
		}
		
		public function setItemAt(item:Object, index:int): Object {
			internalList[index] = makeTorrentForObject(item);
			return internalList[index]
		}
		
		public function removeAll() :void {
			internalList = new Vector.<Torrent>();
		}
		
		public function removeItemAt(index:int) : Object {
			return internalList.splice(index,1);	
		}
	}
}
package org.mellen.transmissionair.view
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	import org.mellen.transmissionair.events.TorrentRPCEvent;
	
	public class TorrentListMediator extends Mediator implements IMediator
	{
		[Inject]
		public var rpc:BitTorrentFullRPCService;
		
		[Inject]
		public var torrentList:TorrentList;
		
		
		private var _torrents:ArrayCollection = new ArrayCollection();
		
		private var pollTorrents:Timer = new Timer(500);
		
		private var torrentFileStream:FileStream = new FileStream();
		
		override public function onRegister():void
		{
			//adding an event listener to the Context for framework events
			eventMap.mapListener( eventDispatcher, TorrentRPCEvent.TORRENT_LIST_RECEIVED, updateTorrentList );
			eventMap.mapListener( eventDispatcher, TorrentRPCEvent.SESSION_ID_RECEIVED, startPolling);
			eventMap.mapListener( eventDispatcher, TorrentRPCEvent.TORRENT_DROPPED, loadTorrentFile);
			eventMap.mapListener( torrentList, TorrentRPCEvent.TORRENT_PAUSE, pauseTorrent);
			eventMap.mapListener( torrentList, TorrentRPCEvent.TORRENT_START, startTorrent);
			eventMap.mapListener( torrentList, TorrentRPCEvent.TORRENT_REMOVE, removeTorrent);
			//BindingUtils.bindProperty(torrentList,"dataProvider",this,"torrents");
			torrentList.dataProvider = torrents;
			//torrentList.dataProvider = _torrentList;
			//adding an event listener to the view component being mediated
			//eventMap.mapListener( myCustomComponent, MyCustomEvent.DID_SOME_STUFF, handleDidSomeStuff)
		}
		
		
		public function pauseTorrent(e: TorrentRPCEvent) :void {
			rpc.pauseTorrent(e.id);
		}
		
		public function startTorrent(e: TorrentRPCEvent) :void {
			rpc.startTorrent(e.id);
		}

		public function removeTorrent(e: TorrentRPCEvent) :void {
			rpc.removeTorrent(e.id);
		}		
		
		public function get torrents() : ArrayCollection {
			return _torrents;
		}
		
		private function addTorrentFile(e:Event):void {
			var torrentFileData:ByteArray = new ByteArray();
			torrentFileStream.readBytes(torrentFileData);
			
			rpc.addTorrentByMetainfo(torrentFileData);
		}
		
		
		
		private function loadTorrentFile(e:TorrentRPCEvent) {
			torrentFileStream.addEventListener(Event.COMPLETE,addTorrentFile);
			torrentFileStream.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			torrentFileStream.openAsync(e.torrentFile,FileMode.READ);								
		}
		
		private function ioErrorHandler(e:IOErrorEvent):void {
			trace(e);
		}
		
		private function updateTorrentList(e: TorrentRPCEvent): void {
			var torrents:Array = e.torrentList;
			if (_torrents.length == 0) {
				for (var index:int = 0; index < torrents.length; index++) {						
					_torrents.addItem(torrents[index]);
				}
			}
			else {
				
				var length:int = (_torrents.length > torrents.length) ? _torrents.length : torrents.length;
				var index:int = 0;
				while(index < length) {
					
					if (index > torrents.length-1) {							
						_torrents.removeItemAt(index);	
						length -= 1;
					}
					else if(index > _torrents.length-1) {
						_torrents.addItem(torrents[index]);
						index += 2;
						length += 1;
					}
					else if(_torrents[index].id != torrents[index].id) {
						if(index < (torrents.length-1)) {
							if(torrents[index+1].id == _torrents[index].id) {
								
								_torrents.addItemAt(torrents[index],index-1);
								index += 2;
								length += 1;
							} 
							else if (torrents[index].id == _torrents[index+1].id) {
								_torrents.removeItemAt(index);
								length -= 1;
							}
						}
					}
					else {
						updateJSONRepresentation(index, torrents[index]);
						index++;
					}
				}	
			}
			
		}
		
		private function updateJSONRepresentation(index, item) : void {
			_torrents[index].updateValues(item);
			
		}
		
		
		private function fetchTorrentList(e:TimerEvent):void {
			rpc.listAllTorrents();
		}
		
		private function startPolling(e: TorrentRPCEvent): void {
			pollTorrents.addEventListener(TimerEvent.TIMER,fetchTorrentList);
			pollTorrents.start();
		}
	}
}
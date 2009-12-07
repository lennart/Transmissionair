package org.mellen.transmissionair.events
{
	import flash.events.Event;
	import flash.filesystem.File;
	
	public class TorrentRPCEvent extends Event
	{
		public static const TORRENT_ADDED="torrentAdded";
		public static const TORRENT_REMOVE="torrentRemove";
		public static const TORRENT_START="torrentStart";
		public static const TORRENT_PAUSE="torrentPause";
		public static const TORRENT_LIST_RECEIVED="torrentListReceived";
		public static const TORRENT_DROPPED="torrentDropped";
		public static const SESSION_ID_RECEIVED="sessionIDReceived";
		
		public var jsonRepresentation:Object;
		public var torrentList:Array;
		public var torrentFile:File;
		public var index:int;
		public var id:String;
		public function TorrentRPCEvent(type:String,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
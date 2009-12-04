package
{
	import flash.events.Event;
	
	public class TorrentRPCEvent extends Event
	{
		public static const TORRENT_ADDED="torrentAdded";
		public static const TORRENT_REMOVED="torrentRemoved";
		public static const TORRENT_START="torrentStart";
		public static const TORRENT_PAUSE="torrentPause";
		
		public var jsonRepresentation:Object;
		public var index:int;
		public function TorrentRPCEvent(type:String,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
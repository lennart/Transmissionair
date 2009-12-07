package org.mellen.transmissionair.events
{
	import flash.events.Event;
	
	public class ConfigEvent extends Event
	{
		public static const READY:String = "ready";
		public static const ACCEPTED:String = "accepted";
		public static const SAVE:String = "save";
		public static const QUIT:String = "quit";
		public static const UPDATED:String = "updated";
		
		public var selectionIndex:uint;
		public var ip:String;
		public var port:Number;
		
		public function ConfigEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
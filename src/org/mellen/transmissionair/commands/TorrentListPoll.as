package org.mellen.transmissionair.commands
{
	import org.mellen.transmissionair.events.TorrentRPCEvent;
	import org.robotlegs.mvcs.Command;
	
	public class TorrentListPoll extends Command
	{
		[Inject]
		public var event:TorrentRPCEvent;
		
		
		
		override public function execute():void
		{
			//EventMap torrentListMediator
			trace("called");
			(contextView as Transmissionair).currentState = "torrentList";
		}
	
	}
}
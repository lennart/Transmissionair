package org.mellen.transmissionair.commands
{
	import org.mellen.transmissionair.view.TorrentListMediator;
	import org.robotlegs.base.EventMap;
	import org.robotlegs.mvcs.Command;
	import org.mellen.transmissionair.events.TorrentRPCEvent;
	
	public class TorrentListPoll extends Command
	{
		[Inject]
		public var event:TorrentRPCEvent;
		
		[Inject]
		public var torrentListMediator:TorrentListMediator;
		
		override public function execute():void
		{
			//EventMap torrentListMediator
			
		}
	
	}
}
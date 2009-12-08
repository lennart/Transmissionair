package org.mellen.transmissionair.commands
{
	import org.mellen.transmissionair.models.RPCServerConfiguration;
	import org.mellen.transmissionair.services.BitTorrentFullRPCService;
	import org.mellen.transmissionair.view.TorrentListMediator;
	import org.robotlegs.mvcs.Command;
	
	public class StartupCompleteCommand extends Command
	{
		[Inject]
		public var rpc:BitTorrentFullRPCService; 
		
		[Inject]
		public var config:RPCServerConfiguration;
		
		override public function execute():void
		{			
			rpc.connectToServer(config.host,config.port);
		}
	}
}
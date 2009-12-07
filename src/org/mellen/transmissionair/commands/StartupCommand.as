package org.mellen.transmissionair.commands
{
	import org.mellen.transmissionair.events.ConfigEvent;
	import org.mellen.transmissionair.models.RPCServerConfiguration;
	import org.mellen.transmissionair.services.TransmissionRPCService;
	import org.mellen.transmissionair.view.RPCServerConfig;
	import org.mellen.transmissionair.view.TorrentList;
	import org.mellen.transmissionair.view.TorrentListMediator;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Command;
	
	public class StartupCommand extends Command
	{
		[Inject]
		public var event:ContextEvent;
		
		[Inject]
		public var config:RPCServerConfiguration;
		
		
		
		override public function execute():void
		{
			//trace(event);
			commandMap.mapEvent( ContextEvent.STARTUP_COMPLETE, StartupCompleteCommand, ContextEvent, true);
			commandMap.mapEvent( ConfigEvent.READY, SpawnServerConfigurator, ConfigEvent, true);
			
			injector.mapSingletonOf(BitTorrentFullRPCService, TransmissionRPCService);
			
			mediatorMap.mapView(TorrentList,TorrentListMediator);
			
			
			
		}
		
	}
}
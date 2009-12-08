package org.mellen.transmissionair
{
	import flash.display.DisplayObjectContainer;
	
	import org.mellen.transmissionair.commands.SpawnServerConfigurator;
	import org.mellen.transmissionair.commands.StartupCommand;
	import org.mellen.transmissionair.commands.StartupCompleteCommand;
	import org.mellen.transmissionair.commands.TorrentListPoll;
	import org.mellen.transmissionair.events.ConfigEvent;
	import org.mellen.transmissionair.events.TorrentRPCEvent;
	import org.mellen.transmissionair.models.RPCServerConfiguration;
	import org.mellen.transmissionair.services.BitTorrentFullRPCService;
	import org.mellen.transmissionair.services.TransmissionRPCService;
	import org.mellen.transmissionair.view.RPCServerConfig;
	import org.mellen.transmissionair.view.RPCServerConfigMediator;
	import org.mellen.transmissionair.view.TorrentList;
	import org.mellen.transmissionair.view.TorrentListMediator;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.core.IContext;
	import org.robotlegs.mvcs.Context;
	
	public class TransmissionAirContext extends Context implements IContext
	{
		public function TransmissionAirContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
			
		}
		
		
		override public function startup():void
		{
			//This Context is mapping a single command to the ContextEvent.STARTUP
			//The StartupCommand will map additional commands, mediators, services,
			//and models for use in the application.
			commandMap.mapEvent( ContextEvent.STARTUP, StartupCommand, ContextEvent, true );
			commandMap.mapEvent( ContextEvent.STARTUP_COMPLETE, StartupCompleteCommand, ContextEvent, true);
			commandMap.mapEvent( ConfigEvent.READY, SpawnServerConfigurator, ConfigEvent, true);
			commandMap.mapEvent( TorrentRPCEvent.SESSION_ID_RECEIVED, TorrentListPoll, TorrentRPCEvent, true);
			
			injector.mapSingletonOf(BitTorrentFullRPCService, TransmissionRPCService);
			injector.mapSingleton(TorrentListMediator);
			injector.mapSingleton(RPCServerConfiguration);
			
			mediatorMap.mapView(RPCServerConfig,RPCServerConfigMediator);
			mediatorMap.mapView(TorrentList,TorrentListMediator);
			
			
			dispatchEvent(new ContextEvent(ContextEvent.STARTUP));
			
		}
	}
}
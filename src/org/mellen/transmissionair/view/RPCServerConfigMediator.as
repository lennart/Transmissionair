package org.mellen.transmissionair.view
{
	import org.mellen.transmissionair.events.ConfigEvent;
	import org.mellen.transmissionair.models.RPCServerConfiguration;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.Mediator;
	
	public class RPCServerConfigMediator extends Mediator implements IMediator
	{
		[Inject]
		public var dialog:RPCServerConfig;
		
		[Inject]
		public var config:RPCServerConfiguration;
		
		[Bindable]
		public var servers:XMLList = new XMLList();
		
		public function RPCServerConfigMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			//adding an event listener to the Context for framework events
			
			eventMap.mapListener( dialog, ConfigEvent.ACCEPTED, proceed);
			eventMap.mapListener( dialog, ConfigEvent.SAVE, save);
			eventMap.mapListener( dialog, ConfigEvent.QUIT, cancel);
			eventMap.mapListener( eventDispatcher, ConfigEvent.UPDATED, updateServerList);
			
			dialog.serverList.dataProvider = config.serverList;
		}
		
		protected function updateServerList(e:ConfigEvent) :void {
			dialog.serverList.dataProvider = config.serverList;
		}
		
		protected function proceed(e: ConfigEvent):void {
			var startupCompleteEvent:ContextEvent = new ContextEvent(ContextEvent.STARTUP_COMPLETE);
			config.selectedServer = e.selectionIndex;
			
			dispatch(startupCompleteEvent);
		}
		
		protected function save(e: ConfigEvent) :void {
			config.addServer(e.ip, e.port);
		}
		
		protected function cancel(e: ConfigEvent):void {
			
		}
		
	}
}
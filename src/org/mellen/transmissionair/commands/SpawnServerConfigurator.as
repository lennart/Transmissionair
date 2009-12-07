package org.mellen.transmissionair.commands
{
	import org.mellen.transmissionair.events.ConfigEvent;
	import org.mellen.transmissionair.view.RPCServerConfig;
	import org.mellen.transmissionair.view.RPCServerConfigMediator;
	import org.robotlegs.mvcs.Command;
	
	import spark.components.SkinnableContainer;
	
	public class SpawnServerConfigurator extends Command
	{
		[Inject]
		public var event:ConfigEvent;
		
		
		override public function execute():void {
			
			mediatorMap.mapView(RPCServerConfig,RPCServerConfigMediator);
			(contextView as SkinnableContainer).addElement(new RPCServerConfig());
		}
	}
}
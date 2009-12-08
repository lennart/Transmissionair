package org.mellen.transmissionair.commands
{
	import org.mellen.transmissionair.events.ConfigEvent;
	import org.robotlegs.mvcs.Command;
	
	public class SpawnServerConfigurator extends Command
	{
		[Inject]
		public var event:ConfigEvent;
		
		
		override public function execute():void {
			
			
			(contextView as Transmissionair).currentState = "serverConfig";
		}
	}
}
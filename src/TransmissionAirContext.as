package
{
	import flash.display.DisplayObjectContainer;
	
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
			
			//Start the Application (triggers the StartupCommand)
			dispatch(new ContextEvent(ContextEvent.STARTUP));
		}
	}
}
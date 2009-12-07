package org.mellen.transmissionair.models
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import org.mellen.transmissionair.events.ConfigEvent;
	import org.robotlegs.mvcs.Actor;
	
	public class RPCServerConfiguration extends Actor
	{
		private var configFile:String = "ServerConfigurations.xml";
		private var configXML:XML;
		private var loader:URLLoader;
		private var _selectedHost;
		private var _selectedPort;
		private var _stream:FileStream;
		
		public function RPCServerConfiguration()
		{
			super();
			loader = new URLLoader();
			
			var configFileXML:File = File.applicationStorageDirectory.resolvePath(configFile);
			if(!configFileXML.exists) {
				var originalFile:File = File.applicationDirectory.resolvePath(configFile);
				originalFile.copyTo(configFileXML);
			}
			var req:URLRequest = new URLRequest(configFileXML.url);
				
			loader.addEventListener(Event.COMPLETE,XMLLoaded);
			loader.load(req);
		}
		
		protected function XMLLoaded(e:Event):void {
			configXML = new XML(e.currentTarget.data);
			dispatch(new ConfigEvent(ConfigEvent.READY));
		}
		
		public function set selectedServer(index:uint):void {
			var server:XML = serverList[index]; 				
			_selectedHost = server.ip;
			_selectedPort = server.port;
		}
		
		public function addServer(ip:String, port:Number) :void {
			var server:XML = 
				<server>
					<ip/>
					<port/>
				</server>;
			server.ip = ip;
			server.port = port
			configXML.appendChild(server);
			save();
		}
		
		public function get host():String {
			return _selectedHost;
		}
		
		public function get port():Number {
			return _selectedPort;
		}
		
		public function get serverList():XMLList {
			return configXML.children();
		}
		
		private function save(): void {
			var file:File = File.applicationStorageDirectory.resolvePath(configFile);
			_stream = new FileStream();
			_stream.open(file,FileMode.WRITE);		
			_stream.writeUTFBytes(configXML.toString());
			_stream.close();
			dispatch(new ConfigEvent(ConfigEvent.UPDATED));
		}

	}
}
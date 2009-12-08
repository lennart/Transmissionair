package org.mellen.transmissionair.services
{
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import mx.utils.Base64Encoder;
	
	import org.mellen.transmissionair.events.TorrentRPCEvent;
	import org.mellen.transmissionair.models.TorrentInfo;
	import org.robotlegs.mvcs.Actor;
	
	public class TransmissionRPCService extends Actor implements BitTorrentFullRPCService
	{
		private var urlLoader:URLLoader = new URLLoader();
		private var sessionID:String;
		//private const HOST:String = "http://localhost:9091";
		private const RPC_ROOT:String = "/transmission/rpc";
		private var _host:String;
		private var _port:uint;
		private const SESSION_HEADER_KEY:String = "X-Transmission-Session-Id";
		private var tagCounter:uint = 0;
		private var requestTable:Dictionary = new Dictionary();
		//private var listening:Boolean = false;
		
		public function TransmissionRPCService()
		{			
			super();
					
		}
		
		public function connectToServer(host:String, port:uint):void {
			var req:URLRequest = new URLRequest();
			_host = host;
			_port = port;
			req.url = hostURL+RPC_ROOT;
			req.method = URLRequestMethod.GET;
			urlLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS,sessionIdReceived);
			urlLoader.load(req);
		}
		
		public function addTorrentByMetainfo(metainfo:ByteArray):void
		{
			var arguments:Object = new Object();
			var enc:Base64Encoder = new Base64Encoder();
			enc.encodeBytes(metainfo);
			arguments.metainfo = enc.toString();
			sendRequest(arguments,"torrent-add",torrentAdded);
		}
		
		public function addTorrentByURL(url:String):void
		{
			
		}
		
		public function removeTorrent(id:String):void
		{
			sendRequest({"ids" : int(id)}, "torrent-remove", function (response:Object) {
				trace(response["success"]);
			});	
		}
		
		public function pauseTorrent(id:String):void
		{
			sendRequest({"ids" : int(id) }, "torrent-stop", torrentPaused);
		}
		
		public function startTorrent(id:String):void
		{
			sendRequest({"ids" : int(id) }, "torrent-start", torrentStarted);
		}
		
		public function setUploadRate(id:String, rate:Number):void
		{
			
		}
		
		public function setDownloadRate(id:String, rate:Number):void
		{
			
		}
		
		public function setMaximumSeedRatio(id:String, ratio:Number):void
		{
			
		}
		
		public function setPriority(id:String, priority:String):void
		{
			
		}
		
		public function setDownloadDirectory(id:String, directory:String):void
		{
			
		}
		
		public function setGlobalUploadRate(rate:Number):void
		{
			
		}
		
		public function setGlobalDownloadRate(rate:Number):void
		{
			
		}
		
		public function setGlobalMaximumSeedRation(ratio:Number):void
		{
			
		}
		
		public function pauseAllTorrents():void
		{
			
		}
		
		public function startAllTorrents():void
		{
			
		}
		
		public function getTorrentInfo(id:String):void
		{
			
		}
		
		public function sessionInfo():void
		{
			
		}
		
		public function listAllTorrents():void
		{
			var arguments:Object = new Object();
			arguments.fields = ["id","name","totalSize", "percentDone", "status", "rateDownload", "rateUpload"];
			sendRequest(arguments,"torrent-get",torrentListReceived);	
		}
		
		private function sendRequest(arguments:Object, method:String, callback:Function): void {
			var req:URLRequest = new URLRequest();	
			var reqData:Object = new Object();
			var reqDataBA:ByteArray = new ByteArray();
			var loader:URLLoader = new URLLoader();
			reqData.arguments = arguments
			reqData.method = method;
			reqData.tag = nextTag;
			req.requestHeaders.push(new URLRequestHeader(SESSION_HEADER_KEY,sessionID));
			req.requestHeaders.push(new URLRequestHeader("Accept","application/json"));
			req.url = hostURL+RPC_ROOT;
			reqDataBA.writeUTFBytes(JSON.encode(reqData));
			reqDataBA.position = 0;
			req.data =  reqDataBA;
			req.method = URLRequestMethod.POST;
			
			requestTable[reqData.tag] = {"callback" : callback, "loader" : loader };
			
			loader.addEventListener(Event.COMPLETE,handleResponse);
			loader.addEventListener(IOErrorEvent.IO_ERROR,handleIOError);
			
			loader.load(req);
		}
		
		private function get hostURL() : String {
			return "http://"+_host+":"+_port.toString();
		}
		
		private function get nextTag() : uint {
			if(tagCounter < /*uint.MAX_VALUE*/ 100) {
				return ++tagCounter;
			}
			else {
				tagCounter = 0
				return tagCounter;
			}		
		}
		
		private function torrentListReceived(response:Object):void {
			if(response.result == "success") {
				var event:TorrentRPCEvent = new TorrentRPCEvent(TorrentRPCEvent.TORRENT_LIST_RECEIVED);
				var list:Array = new Array;
				for each (var torrent in response.arguments.torrents) {
					list.push(new TorrentInfo(torrent));
				}
				event.torrentList = list;
				dispatch(event);
			}
			else {
				throw new Error("Failed to fetch Torrents");	
			}	
		}
		
		private function torrentPaused(response:Object) :void {
			trace("Torrent Paused");
		}
		
		private function torrentStarted(response:Object) :void {
			trace("Torrent Started");
			trace(response);
		}
		
		private function torrentAdded(response:Object) :void {
			trace("Torrent Added");	
		}
		
		private function handleResponse(e:Event) :void {			
			var response:Object = JSON.decode(e.currentTarget.data);
			var metadata:Object = requestTable[response["tag"]];
			(metadata["loader"] as URLLoader).removeEventListener(Event.COMPLETE,handleResponse);
			metadata["callback"](response);
			requestTable[response["tag"]] = null;
		}
		
		private function handleIOError(e: IOErrorEvent) :void {
			trace(e);
		}
		
		private function sessionIdReceived(e:HTTPStatusEvent):void {
			urlLoader.removeEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS,sessionIdReceived);
			for each (var header:Object in e.responseHeaders) {
				if(header["name"] == SESSION_HEADER_KEY) {
					sessionID = header["value"];
					dispatch(new TorrentRPCEvent(TorrentRPCEvent.SESSION_ID_RECEIVED));
					//
					//pollTorrents.addEventListener(TimerEvent.TIMER,fetchTorrentList);
					//pollTorrents.start();
				}
			}
		}
		
	}
}
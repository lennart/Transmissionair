package org.mellen.transmissionair.services
{
	import flash.utils.ByteArray;

	public interface BitTorrentPublicRPCService
	{		
		function connectToServer(host:String, port:uint):void;
		function getTorrentInfo(id:String) : void;
		function sessionInfo() : void;
		function listAllTorrents() : void;
	}
}
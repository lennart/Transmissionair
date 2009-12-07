package
{
	import flash.utils.ByteArray;

	public interface BitTorrentPrivateRPCService
	{
		function addTorrentByMetainfo(metainfo:ByteArray) : void;
		function addTorrentByURL(url:String) : void;
		
		function removeTorrent(id:String) : void;
		function pauseTorrent(id:String) : void;
		function startTorrent(id:String) : void;
		function setUploadRate(id:String, rate:Number) : void;
		function setDownloadRate(id:String, rate:Number) : void;
		function setMaximumSeedRatio(id:String, ratio:Number) : void;
		function setPriority(id:String, priority:String) : void;
		function setDownloadDirectory(id:String, directory:String) : void;	

		function setGlobalUploadRate(rate:Number) : void;
		function setGlobalDownloadRate(rate:Number) : void;
		function setGlobalMaximumSeedRation(ratio : Number): void;
		function pauseAllTorrents() : void;
		function startAllTorrents() : void;
	}
}
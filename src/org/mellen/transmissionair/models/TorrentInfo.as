package org.mellen.transmissionair.models
{
	import org.robotlegs.mvcs.Actor;
	[Bindable]
	public class TorrentInfo extends Actor
	{
		public var percentDone:String;
		public var id:String;
		public var name:String;
		public var totalSize:String;
		public var rateDownload:String;
		public var rateUpload:String;
		public var _status:String;
		public var namedStatus:String;
		
		public function TorrentInfo(jsonRepresentation:Object)
		{
			super();
			updateValues(jsonRepresentation);
		}
		
		public function set status(newStatus:String):void {
			if(newStatus != status) {
				switch(newStatus) {
					case "4":
						namedStatus = "running";
						break;
					case "8":
						namedStatus = "seeding";
						break;
					case "16":
						namedStatus = "paused";
						break;
					default:
						namedStatus = "paused";
				}
			}
			
		}
		
		public function get status() :String {
			return _status;
		}
		
		
		
		public function updateValues(jsonRepresentation:Object) {
			percentDone = jsonRepresentation.percentDone;
			id = jsonRepresentation.id;
			name = jsonRepresentation.name;
			totalSize = jsonRepresentation.totalSize;
			rateDownload = jsonRepresentation.rateDownload;
			rateUpload = jsonRepresentation.rateUpload;
			status = jsonRepresentation.status;
		}
	}
}
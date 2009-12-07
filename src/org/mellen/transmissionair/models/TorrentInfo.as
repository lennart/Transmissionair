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
		public var status:String;
		
		[Bindable]
		public function get state():String {
			if(status) {
				switch(status) {
					case "4":
						return "running";
						break;
					case "8":
						return "seeding";
						break;
					case "16":
						return "paused";
						break;
					default:
						return "paused";
				}
			}
			else{
				return "paused";
			}
		}
		
		public function TorrentInfo(jsonRepresentation:Object)
		{
			super();
			updateValues(jsonRepresentation);
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
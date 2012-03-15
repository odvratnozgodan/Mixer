package components {
	import flash.events.Event;
	
	public class VolumeEvent extends Event {
		
		public static const VOLUME_CHANGE:String = "volumeChange";
		public var id:int;
		public var volume:Number;
		
		public function VolumeEvent(type:String, id:int, volume:Number) {
			this.id = id;
			this.volume = volume;
			super(type, false, false);
		}
		override public function clone():Event {
			return new VolumeEvent(VolumeEvent.VOLUME_CHANGE, this.id, this.volume);
		}
		
	}
	
}
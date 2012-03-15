package components {
	import flash.events.Event;
	
	public class PanningEvent extends Event {
		
		public static const PANNING_CHANGE:String = "panningChange";
		public var id:int;
		public var panning:Number;
		
		public function PanningEvent(type:String, id:int, panning:Number) {
			this.id = id;
			this.panning = panning;
			super(type, false, false);
		}
		override public function clone():Event {
			return new PanningEvent(PanningEvent.PANNING_CHANGE, this.id, this.panning);
		}
		
	}
	
}
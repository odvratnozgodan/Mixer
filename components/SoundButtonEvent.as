package components {
	import flash.events.Event;
	
	public class SoundButtonEvent extends Event {
		
		public static const MOUSE_DOWN:String = "mouseDown_";
		public var id:int;
		
		public function SoundButtonEvent(type:String, id:int) {
			this.id = id;
			super(type, false, false);
		}
		override public function clone():Event {
			return new SoundButtonEvent(SoundButtonEvent.MOUSE_DOWN, this.id);
			
		}
		
	}
	
}
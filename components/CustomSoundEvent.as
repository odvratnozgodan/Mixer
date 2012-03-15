package components{
	
	import flash.events.Event;
	
	public class CustomSoundEvent extends Event {
		public static const COMPLETE:String = "Complete_";
		public static const STOPED:String = "Stoped_";
		public var id:int;
		public var _type:String;
		
		public function CustomSoundEvent(type:String, id:int){
			this.id = id;
			this._type=type;
			super(type, false, false);
		}
		
		override public function clone():Event {
			if(_type==COMPLETE){
				return new CustomSoundEvent(CustomSoundEvent.COMPLETE, this.id);
			}else{
				return new CustomSoundEvent(CustomSoundEvent.STOPED, this.id);
			}
			
		}
	}
}
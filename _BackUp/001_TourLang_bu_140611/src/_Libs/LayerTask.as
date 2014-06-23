package
{
	import core.IWrap;
	import flash.display.MovieClip;
	import hb.utils.DebugUtil;
	import hb.utils.MovieClipUtil;
	
	/**
	 * ...
	 * @author HobisJung
	 */
	public class LayerTask
	{
		// :: 생성자
		public function LayerTask() 
		{
		}
		
		
		// - 이름
		public var name:String = null;
		// - 타이틀
		public var title:String = null;
		// - 레이어 타입
		public var layerType:String = null;
		
		// - 아이템 배열
		private var _items:Array = null;
		// ::
		public function get_items():Array
		{
			return this._items;
		}
		
		// -
		public var isNew:Boolean = false;
		
		
		// :: 준비
		public function prepare():void
		{
			this._items = [];		
			
			for
			(
				var
					t_la:uint = uint(this.layerType),
					i:uint = 0;
					
				i < t_la; i++
			)
			{
				this._items.push({name: ''});
			}
			
			this.p_reset();
			this.isNew = true;
			this.p_checkGoto();

			
			DebugUtil.test('this.name: ' + this.name);
			DebugUtil.test('this.title: ' + this.title);
			DebugUtil.test('this.layerType: ' + this.layerType);
			DebugUtil.test('this.get_items(): ' + this.get_items());
		}
		
		// :: 초기화
		private function p_reset():void
		{			
		}
		
		// :: Layer 모듈 체크후 화면표시 잠시후 실행
		private function p_checkGoto_after():void
		{
		}		
		
		// :: 체크하고 시작
		private function p_checkGoto():void
		{
			var t_label:String = null;

			switch (this.layerType)
			{
				case '32':
				{
					t_label = '#_4';

					break;
				}

				case '16':
				{
					t_label = '#_3';

					break;
				}

				case '8':
				{
					t_label = '#_2';

					break;
				}

				case '4':
				{
					t_label = '#_1';

					break;
				}
			}

			this._owner.gotoAndStop(t_label);
			MovieClipUtil.delayExcute(this, this.p_checkGoto_after);
		}
	}
}

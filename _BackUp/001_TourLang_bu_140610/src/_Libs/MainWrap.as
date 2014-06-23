package 
{
	import core.IWrap;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	/**
	 * ...
	 * @author HobisJung
	 */
	public final class MainWrap implements IWrap
	{
		// :: 생성자
		public function MainWrap(owner:MovieClip) 
		{
			this._owner = owner;
			this.p_init_once();
		}
		
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		//// # 초기화 설정 부분
		////////////////////////////////////////////////////////////////////////////////////////////////////
		// -
		private var _owner:MovieClip = null;
		
		// :: 참고한 객체 반환
		public function get_owner():MovieClip
		{
			return this._owner;
		}
		
		
		// -
		private var _onCallBack:Function = null;
		
		// :: 콜백 함수 반환
		public function get_onCallBack():Function
		{
			return this._onCallBack;
		}
		
		// :: 콜백 함수 설정
		public function set_onCallBack(onCallBack:Function):void
		{
			this._onCallBack = onCallBack;
		}
		
		// :: 콜백 함수 호출
		public function dispatchCallBack(eventObj:Object):void
		{
			if (this._onCallBack != null)
			{
				this._onCallBack(eventObj);
			}
		}
		
		
		// :: 객체 비움
		public function clear():void
		{
			this._owner = null;
		}
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		// - PopUpWrap
		private var _popUpWrap:PopUpWrap = null;
		// - TopUiWrap
		private var _topUiWrap:TopUiWrap = null;
		// -
		private var _dataObj:Object = null;
		
		// :: PopUpWrap 콜백 함수
		private function p_popUpWrap_onCallBack(eventObj:Object):void
		{
			switch (eventObj.type)
			{
				case 'popUpOpen':
				{
					trace('eventObj.frameType: ' + eventObj.frameType);
					
					break;
				}
			}
		}		
		
		// :: TopUiWrap 콜백 함수
		private function p_topUiWrap_onCallBack(eventObj:Object):void
		{
			switch (eventObj.type)
			{
				case 'popUpOpen':
				{
					trace('eventObj.frameType: ' + eventObj.frameType);
					
					break;
				}
			}
		}
		
		// :: 한번만 초기화
		private function p_init_once():void
		{
			var t_stage:Stage = this._owner.stage;
			//t_stage.scaleMode = StageScaleMode.NO_SCALE;
			t_stage.scaleMode = StageScaleMode.SHOW_ALL;
			//t_stage.align = StageAlign.TOP_LEFT;
			
			this._popUpWrap = new PopUpWrap(this._owner.popUp_mc);
			this._topUiWrap = new TopUiWrap(this._owner.topUiBar_mc);
			this._topUiWrap.set_onCallBack(this.p_topUiWrap_onCallBack);
		}
	}

}
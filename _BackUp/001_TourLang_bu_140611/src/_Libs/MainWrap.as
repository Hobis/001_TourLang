package 
{
	import core.IWrap;
	import flash.display.MovieClip;
	import flash.display.NativeWindow;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	import flash.text.TextField;
	import hb.utils.DebugUtil;
	
	/**
	 * ...
	 * @author HobisJung
	 */
	public class MainWrap implements IWrap
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
		
		// - Layer Task (핵심클래스)
		private var _layerTask:LayerTask = null;
		// ::
		public function clear_layerTask():void
		{
			if (this._layerTask != null)
			{
				this._layerTask.clear();
				this._layerTask = null;
			}
		}
		
		
		// - File
		private var _file:File = null;
		// - FileStream
		private var _fileStream:FileStream = null;
		// - File Use Type
		private var _fileUseType:String = null;
		
		
		// :: File Choosing Handler
		private function p_file_select(event:Event):void
		{
		}
		
		// :: FileStream Close Handler
		private function p_fileStream_close(event:Event):void
		{
		}
		
		// :: FileStream Complete Handler
		private function p_fileStream_complete(event:Event):void
		{
		}
		
		
		// - PopUpWrap
		private var _popUpWrap:PopUpWrap = null;
		// - TopUiWrap
		private var _topUiWrap:TopUiWrap = null;
		
		
		// :: PopUpWrap 콜백 함수
		private function p_popUpWrap_onCallBack(eventObj:Object):void
		{			
			switch (eventObj.type)
			{
				case 'new_confirm':
				{
					// 새로만들기 때문에 기존에 LayerTask객체는 제거
					this._layerTask = new LayerTask(this._owner.mapLayer_mc);
					var t_dObj:Object = eventObj.dObj;
					this._layerTask.name = t_dObj.name;
					this._layerTask.title = t_dObj.title;
					this._layerTask.layerType = t_dObj.layerType;
					this._layerTask.prepare();

					
					var t_str:String =
						this._file.parent.nativePath + File.separator +
						this._layerTask.name + '.' + MainProxy.FILE_EX_NAME;
					this._file = new File(t_str);
					this._file.addEventListener(Event.SELECT, this.p_file_select);
					
					break;
				}
			}
		}		
		
		// :: TopUiWrap 콜백 함수
		private function p_topUiWrap_onCallBack(eventObj:Object):void
		{
			switch (eventObj.type)
			{
				// 아이템 클릭
				case 'itemClick':
				{					
					switch (eventObj.num)
					{
						// 새로시작
						case 1:
						{
							this._popUpWrap.open('#_2');
							
							break;
						}
						
						// 불러오기
						case 2:
						{							
							this._fileUseType = MainProxy.FILE_USE_TYPE_OPEN;
							this._file.browseForOpen('open', [MainProxy.FILE_USE_FILTER]);
							
							break;
						}
						
						// 저장하기
						case 3:
						{
							
							break;
						}
						
						// 스크린샷
						case 4:
						{
							
							break;
						}
						
						// 뒤섞기
						case 5:
						{
							
							break;
						}
						
						// 초기화
						case 6:
						{
							
							break;
						}
						
						// 정보
						case 7:
						{
							
							break;
						}
						
						// 창 초기화
						case 8:
						{
							
							break;
						}
					}
					
					break;
				}
			}
		}
		
		// :: 타이틀 인포 초기화
		private function p_init_once():void
		{
			var t_tf:TextField = null;
			
			t_tf = this.titleInfo_mc.tf_1;
		}
		
		// :: 한번만 초기화
		private function p_init_once():void
		{
			//
			var t_stage:Stage = this._owner.stage;
			//t_stage.scaleMode = StageScaleMode.NO_SCALE;
			t_stage.scaleMode = StageScaleMode.SHOW_ALL;
			//t_stage.align = StageAlign.TOP_LEFT;
			
			// AIR Native Setting
			var t_win:NativeWindow = t_stage.nativeWindow;
			t_win.title = MainProxy.NAME;
			
			//
			this._popUpWrap = new PopUpWrap(this._owner.popUp_mc);
			this._popUpWrap.set_onCallBack(this.p_popUpWrap_onCallBack);
			//this._popUpWrap.open('#_4', {msg: 'aaaa'});
			
			//
			this._topUiWrap = new TopUiWrap(this._owner.topUiBar_mc);
			this._topUiWrap.set_onCallBack(this.p_topUiWrap_onCallBack);

			//
			var t_str:String =
				File.applicationDirectory.nativePath +
				File.separator + MainProxy.FILE_DATA_FOLDER +
				File.separator + MainProxy.FILE_DEFAULT_NAME;
			this._file = new File(t_str);
			this._file.addEventListener(Event.SELECT, this.p_file_select);
			this._fileStream = new FileStream();
			this._fileStream.addEventListener(Event.CLOSE, this.p_fileStream_close);
			this._fileStream.addEventListener(Event.COMPLETE, this.p_fileStream_complete);
			
			DebugUtil.test('메인 초기화 완료');
		}
	}

}
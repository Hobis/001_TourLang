package 
{
	import com.greensock.easing.Quint;
	import com.greensock.TweenLite;
	import core.IWrap;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.text.TextField;
	import hb.utils.MovieClipUtil;
	import hbworks.uilogics.ButtonLogic;
	
	/**
	 * ...
	 * @author HobisJung
	 */
	public final class TopUiWrap implements IWrap
	{
		// :: 생성자
		public function TopUiWrap(owner:MovieClip) 
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
		
		
		// - Default Height
		private var _dh:Number;
		// - File
		private var _file:File = null;
		// - FileStream
		private var _fileStream:FileStream = null;
		
		// -
		private const _FILE_OPEN_TYPE_OPEN:String = 'open';
		// -
		private const _FILE_OPEN_TYPE_SAVE:String = 'save';
		// - FileOpenType
		private var _fileOpenType:String = null;
		
		// - This Visiblity
		private var _visible:Boolean = false;
		// - This is EditMode
		private var _isEditMode:Boolean = false;
		// - This Auto Close
		private var _isAutoClose:Boolean = false;
		
		// :: File Choosing Handler
		private function p_check_close():void
		{
			if (this._isAutoClose)
			{				
				this.p_close_click(null);
			}
		}
		
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
		
		// :: This Closing Handler
		private function p_close_click(event:MouseEvent):void
		{
			if (this._visible)
			{
				this.p_pin_click(null);
			}
		}		
		
		// :: EditMode Click Handler
		private function p_editMode_click(event:MouseEvent):void
		{
			var t_bl:ButtonLogic = ButtonLogic(event.currentTarget);
			this._isEditMode = t_bl.selected;
		}
		
		// :: AutoClose Click Handler
		private function p_autoClose_click(event:MouseEvent):void
		{
			var t_bl:ButtonLogic = ButtonLogic(event.currentTarget);
			this._isAutoClose = t_bl.selected;
		}
		
		// :: Pin Click Handler
		private function p_pin_click(event:MouseEvent):void
		{
			if (this._visible)
			{
				TweenLite.to(this._owner, .3,
					{y: -(this._dh - 11), ease: Quint.easeOut});

				this._visible = false;
			}
			else
			{
				TweenLite.to(this._owner, .3,
					{y: 0, ease: Quint.easeOut});

				this._visible = true;
			}
		}		
		
		// :: New Click Handler
		private function p_new_click(event:MouseEvent):void
		{
			this.p_check_close();
			
			this.dispatchCallBack({type: 'popUpOpen', frameType: '#_1'});
		}

		// :: Open Click Handler
		private function p_open_click(event:MouseEvent):void
		{
			this.p_check_close();
			
			this._fileOpenType = _FILE_OPEN_TYPE_OPEN;
			const t_FILTER_COMMENT:String = 'TourLang Binary Data: ';
			var t_ff:FileFilter = new FileFilter(t_FILTER_COMMENT, '*.' + MainProxy.EX_NAME + ';');
			this._file.browseForOpen('Open', [t_ff]);
		}

		// :: Save Click Handler
		private function p_save_click(event:MouseEvent):void
		{
			this.p_check_close();
			
			
		}

		// :: ScreenShot File Select Handler
		private function p_shot_click_select(event:Event):void
		{
			this.p_check_close();
			
			
		}

		// :: ScreenShot Click Handler
		private function p_shot_click(event:MouseEvent):void
		{
			this.p_check_close();
			
			
		}

		// :: Shuffling After
		private function p_shuffling_click_after():void
		{
			this.p_check_close();
			
			
		}

		// :: Shuffling Click Handler
		private function p_shuffling_click(event:MouseEvent):void
		{
			this.p_check_close();
			
			
		}

		// :: Reset After
		private function p_reset_click_after():void
		{
			this.p_check_close();
			
			
		}

		// :: Reset Click Handler
		private function p_reset_click(event:MouseEvent):void
		{
			this.p_check_close();
			
			
		}

		// :: Info Click Handler
		private function p_info_click(event:MouseEvent):void
		{
			this.p_check_close();
			
			
		}
		
		// :: Initialize Once
		private function p_init_once():void
		{
			this._dh = this._owner.height;
			
			var t_tf:TextField = null;
			var t_bt:SimpleButton = null;
			var t_bl:ButtonLogic = null;
			
			var t_str:String =
				File.applicationDirectory.nativePath +
				File.separator + '_Datas' +
				File.separator + 'default.' + MainProxy.EX_NAME;
			this._file = new File(t_str);
			this._file.addEventListener(Event.SELECT, this.p_file_select);
			this._fileStream = new FileStream();
			this._fileStream.addEventListener(Event.CLOSE, this.p_fileStream_close);
			this._fileStream.addEventListener(Event.COMPLETE, this.p_fileStream_complete);

			this._visible = false;
			this._isEditMode = false;
			this._isAutoClose = false;
			
			
			// Set Title Name
			t_tf = this._owner.name_tf;
			t_tf.text = MainProxy.TITLE_NAME;
			
			// Close
			t_bt = this._owner.close_bt;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_close_click);
			
			// EditMode
			t_bl = new ButtonLogic(this._owner.editMode_mc, true);
			t_bl.addEventListener(MouseEvent.CLICK, this.p_editMode_click);
			//t_bl.selectedDispatch = true;
			
			// AutoClose
			t_bl = new ButtonLogic(this._owner.autoClose_mc, true);
			t_bl.addEventListener(MouseEvent.CLICK, this.p_autoClose_click);
			t_bl.selectedDispatch = true;
			
			// Pin
			t_bt = this._owner.pin_bt;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_pin_click);
			MovieClipUtil.delayExcute(this._owner, this.p_pin_click, [null], 10);
			
			
			// New
			t_bt = this._owner.new_bt;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_new_click);
			
			// Open
			t_bt = this._owner.open_bt;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_open_click);
			
			// Save
			t_bt = this._owner.save_bt;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_save_click);
			
			// ScreenShot
			t_bt = this._owner.shot_bt;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_shot_click);	
			
			// Shuffling
			t_bt = this._owner.shuffling_bt;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_shuffling_click);
			
			// Reset
			t_bt = this._owner.reset_bt;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_reset_click);
			
			// Info
			t_bt = this._owner.info_bt;
			t_bt.tabEnabled = false;
			t_bt.addEventListener(MouseEvent.CLICK, this.p_info_click);
		}
	}
}

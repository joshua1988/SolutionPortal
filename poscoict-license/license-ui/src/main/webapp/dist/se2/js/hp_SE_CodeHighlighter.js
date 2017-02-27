nhn.husky.SE_CodeHighlighter = jindo.$Class({
    name : "SE_CodeHighlighter",
    $init : function(elAppContainer){
        this._assignHTMLObjects(elAppContainer);
    },

    _assignHTMLObjects : function(elAppContainer){
        this.oDropdownLayer = cssquery.getSingle("DIV.husky_seditor_CodeHighlighter_layer", elAppContainer);
        this.oCodeContents = cssquery.getSingle(".se_code_textarea", elAppContainer);
        this.oCodeLanguage = cssquery.getSingle(".se_input_code_language", elAppContainer);

        this.oCloseButton = cssquery.getSingle(".se_button_close", elAppContainer);
        this.oInputButton = cssquery.getSingle(".se_button_insert_code", elAppContainer);

        this.oPopupButton = cssquery.getSingle(".husky_seditor_ui_CodeHighlighter", elAppContainer);
    },

    $ON_MSG_APP_READY : function(){
        this.oApp.exec("REGISTER_UI_EVENT", ["CodeHighlighter", "click", "SE_TOGGLE_CODEHIGHLIGHTER_LAYER"]);
        //input button에 click 이벤트를 할당.
        this.oApp.registerBrowserEvent(this.oInputButton, 'click','PASTE_CODE_HILIGHT');
        this.oApp.registerBrowserEvent(this.oCloseButton, 'click','CLOSE_CODE_PANEL');
    },

    $ON_SE_TOGGLE_CODEHIGHLIGHTER_LAYER : function(){
        this.oApp.exec("TOGGLE_TOOLBAR_ACTIVE_LAYER", [this.oDropdownLayer]);
    },

    $ON_PASTE_NOW_DATE : function(){
        this.oApp.exec("PASTE_HTML", ["hi"]);
    },

    $ON_PASTE_CODE_HILIGHT : function(){
        var cHTML = "<pre><code class='language-" + this.oCodeLanguage.value + "'+>" + this.oCodeContents.value + "<\/code><\/pre>";
        this.oApp.exec("PASTE_HTML", [cHTML]);
        this.oCodeContents.value = null;
        this.oCodeLanguage.value = null;
    },

    $ON_CLOSE_CODE_PANEL : function(){
        this.oApp.exec("DISABLE_ALL_UI");
        this.oApp.exec("ENABLE_ALL_UI"); 	// 모든 UI 활성화.
        // this.oApp.exec("DESELECT_UI", ["helpPopup"]);
        // this.oApp.exec("HIDE_ALL_DIALOG_LAYER", []);
        // this.oApp.exec("HIDE_EDITING_AREA_COVER");		// 편집 영역 활성화.
        //
        // this.oApp.exec("FOCUS");
    }
});

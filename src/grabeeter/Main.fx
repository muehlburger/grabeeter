
/*
 * Copyright (c) 2009, Sun Microsystems, Inc.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without 
 * modification, are permitted provided that the following conditions are met:
 * 
 *  * Redistributions of source code must retain the above copyright notice, 
 *    this list of conditions and the following disclaimer.
 *  * Redistributions in binary form must reproduce the above copyright 
 *    notice, this list of conditions and the following disclaimer in 
 *    the documentation and/or other materials provided with the distribution.
 *  * Neither the name of Sun Microsystems, Inc. nor the names of its 
 *    contributors may be used to endorse or promote products derived 
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT 
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED 
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 
 */

package grabeeter;

import javafx.io.http.URLConverter;
import javafx.scene.image.ImageView;
import javafx.scene.layout.Stack;
//import javafx.stage.AppletStageExtension;
import grabeeter.model.Tweet;
//import org.jfxtras.util.BrowserUtil;

public class Main {

    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:main
    def __layoutInfo_progressIndicator: javafx.scene.layout.LayoutInfo = javafx.scene.layout.LayoutInfo {
        margin: javafx.geometry.Insets { left: 3.0, top: 0.0, right: 0.0, bottom: 0.0 }
    }
    public-read def progressIndicator: javafx.scene.control.ProgressIndicator = javafx.scene.control.ProgressIndicator {
        visible: false
        layoutInfo: __layoutInfo_progressIndicator
    }
    
    def __layoutInfo_statusMessageLabel: javafx.scene.layout.LayoutInfo = javafx.scene.layout.LayoutInfo {
        width: 500.0
        height: 15.0
    }
    public-read def statusMessageLabel: javafx.scene.control.Label = javafx.scene.control.Label {
        visible: true
        layoutInfo: __layoutInfo_statusMessageLabel
        text: "Status message"
    }
    
    public-read def statusMessageBox: javafx.scene.layout.HBox = javafx.scene.layout.HBox {
        content: [ progressIndicator, statusMessageLabel, ]
        padding: javafx.geometry.Insets { left: 10.0, top: 10.0, right: 10.0, bottom: 0.0 }
        spacing: 6.0
        vpos: javafx.geometry.VPos.TOP
        nodeVPos: javafx.geometry.VPos.CENTER
    }
    
    public-read def listView: javafx.scene.control.ListView = javafx.scene.control.ListView {
        items: bind listViewItems
    }
    
    public-read def urlTextbox: javafx.scene.control.TextBox = javafx.scene.control.TextBox {
        visible: true
        cursor: javafx.scene.Cursor.TEXT
        multiline: true
        lines: 1.0
    }
    
    public-read def circle: javafx.scene.shape.Circle = javafx.scene.shape.Circle {
        opacity: 0.61
        cursor: javafx.scene.Cursor.HAND
        layoutY: 0.0
        radius: 8.0
    }
    
    public-read def logoImage: javafx.scene.image.Image = javafx.scene.image.Image {
        url: "{__DIR__}images/logo.png"
        backgroundLoading: false
        smooth: false
        placeholder: null
        preserveRatio: true
    }
    
    public-read def logoImageView: javafx.scene.image.ImageView = javafx.scene.image.ImageView {
        image: logoImage
    }
    
    public-read def backgroundGradient: javafx.scene.paint.LinearGradient = javafx.scene.paint.LinearGradient {
        endX: 0.0
        stops: [ javafx.scene.paint.Stop { offset: 0.0, color: javafx.scene.paint.Color.web ("#FFFFFF") }, javafx.scene.paint.Stop { offset: 0.4, color: javafx.scene.paint.Color.web ("#FFFFFF") }, javafx.scene.paint.Stop { offset: 0.6, color: javafx.scene.paint.Color.web ("#CCCCCC") }, javafx.scene.paint.Stop { offset: 1.0, color: javafx.scene.paint.Color.web ("#FFFFFF") }, ]
    }
    
    public-read def closeText: javafx.scene.control.Label = javafx.scene.control.Label {
        layoutX: 0.0
        layoutY: 0.0
        text: "x"
        textAlignment: javafx.scene.text.TextAlignment.CENTER
        textOverrun: javafx.scene.control.OverrunStyle.CENTER_ELLIPSES
        hpos: javafx.geometry.HPos.CENTER
        vpos: javafx.geometry.VPos.CENTER
        graphicHPos: javafx.geometry.HPos.CENTER
        graphicVPos: javafx.geometry.VPos.CENTER
        graphicTextGap: 5.0
        textFill: backgroundGradient
    }
    
    public-read def closeIcons: javafx.scene.layout.Stack = javafx.scene.layout.Stack {
        visible: false
        opacity: 1.0
        layoutX: 649.0
        layoutY: 0.0
        onMouseClicked: closeIconsOnMouseClicked
        content: [ circle, closeText, ]
        nodeHPos: javafx.geometry.HPos.CENTER
        nodeVPos: javafx.geometry.VPos.CENTER
    }
    
    public-read def closeImage: javafx.scene.image.Image = javafx.scene.image.Image {
        url: "{__DIR__}images/close_94.png"
        width: 11.0
        height: 11.0
        preserveRatio: true
    }
    
    public-read def color: javafx.scene.paint.Color = javafx.scene.paint.Color {
        red: 1.0
        green: 1.0
        blue: 1.0
        opacity: 1.0
    }
    
    public-read def font: javafx.scene.text.Font = javafx.scene.text.Font {
        size: 24.0
    }
    
    public-read def tweetTextbox: javafx.scene.control.TextBox = javafx.scene.control.TextBox {
        cursor: javafx.scene.Cursor.TEXT
        text: "Das ist ein Tweet"
        font: font
        multiline: true
        lines: 2.0
    }
    
    def __layoutInfo_detailsVbox: javafx.scene.layout.LayoutInfo = javafx.scene.layout.LayoutInfo {
        width: 800.0
    }
    public-read def detailsVbox: javafx.scene.layout.VBox = javafx.scene.layout.VBox {
        layoutInfo: __layoutInfo_detailsVbox
        content: [ listView, tweetTextbox, urlTextbox, ]
        padding: javafx.geometry.Insets { left: 10.0, top: 10.0, right: 10.0, bottom: 10.0 }
        spacing: 6.0
    }
    
    public-read def headline: javafx.scene.control.Label = javafx.scene.control.Label {
        effect: null
        text: "Grabeeter - Grab and Search your Tweets!"
        font: font
        textWrap: true
        textFill: javafx.scene.paint.Color.BLACK
    }
    
    public-read def hbox3: javafx.scene.layout.HBox = javafx.scene.layout.HBox {
        content: [ logoImageView, headline, ]
        padding: javafx.geometry.Insets { left: 10.0, top: 10.0, right: 10.0, bottom: 0.0 }
    }
    
    public-read def font2: javafx.scene.text.Font = javafx.scene.text.Font {
        size: 18.0
    }
    
    public-read def searchButton: javafx.scene.control.Button = javafx.scene.control.Button {
        managed: true
        text: "Search"
        font: font2
        action: searchButtonAction
    }
    
    public-read def searchTextBox: javafx.scene.control.TextBox = javafx.scene.control.TextBox {
        cursor: javafx.scene.Cursor.TEXT
        promptText: "search tweets"
        font: font2
        action: searchButtonAction
    }
    
    public-read def hbox2: javafx.scene.layout.HBox = javafx.scene.layout.HBox {
        content: [ searchTextBox, searchButton, ]
        padding: javafx.geometry.Insets { left: 10.0, top: 0.0, right: 10.0, bottom: 0.0 }
        spacing: 6.0
    }
    
    public-read def retrieveButton: javafx.scene.control.Button = javafx.scene.control.Button {
        text: "Grab Tweets"
        font: font2
        action: retrieveButtonAction
    }
    
    public-read def usernameTextBox: javafx.scene.control.TextBox = javafx.scene.control.TextBox {
        cursor: javafx.scene.Cursor.TEXT
        effect: null
        text: ""
        promptText: "enter twitter username"
        selectOnFocus: true
        font: font2
        action: retrieveButtonAction
    }
    
    public-read def hbox: javafx.scene.layout.HBox = javafx.scene.layout.HBox {
        content: [ usernameTextBox, retrieveButton, ]
        padding: javafx.geometry.Insets { left: 10.0, top: 5.0, right: 10.0, bottom: 0.0 }
        spacing: 6.0
    }
    
    def __layoutInfo_containerVbox: javafx.scene.layout.LayoutInfo = javafx.scene.layout.LayoutInfo {
        hfill: true
        vfill: true
    }
    public-read def containerVbox: javafx.scene.layout.VBox = javafx.scene.layout.VBox {
        layoutInfo: __layoutInfo_containerVbox
        content: [ hbox3, hbox, hbox2, statusMessageBox, detailsVbox, ]
        spacing: 5.0
        hpos: javafx.geometry.HPos.LEFT
        nodeHPos: javafx.geometry.HPos.LEFT
    }
    
    public-read def scene: javafx.scene.Scene = javafx.scene.Scene {
        content: getDesignRootNodes ()
        camera: null
        cursor: javafx.scene.Cursor.DEFAULT
        fill: backgroundGradient
    }
    
    init {
    }
    
    public-read def searchState: org.netbeans.javafx.design.DesignState = org.netbeans.javafx.design.DesignState {
        names: [ ]
        timelines: [
        ]
    }
    
    public function getDesignRootNodes (): javafx.scene.Node[] {
        [ containerVbox, closeIcons, ]
    }
    
    public function getDesignScene (): javafx.scene.Scene {
        scene
    }
    // </editor-fold>//GEN-END:main

    var apiUrl: String = bind "http://grabeeter.tugraz.at/api/tweets/{username}.xml";
    var username = bind new URLConverter().encodeString(usernameTextBox.text);
    
    var tweetUtil: TweetUtil = TweetUtil {
        location: bind apiUrl
        statusMessage: bind statusMessageLabel
    };


    var listViewItems: Object[] = bind tweetUtil.searchResults;

    var selectedResult = bind listView.selectedItem as Tweet on replace {
        tweetTextbox.text = "{selectedResult.text}";
        urlTextbox.text = "{selectedResult.url}";
    }

//    var isApplet = "true".equals(FX.getArgument("isApplet") as String);
//    var inBrowser = isApplet;
//    var draggable = AppletStageExtension.appletDragSupported;


//    function tweetLinkOnMouseClicked(event: javafx.scene.input.MouseEvent): Void {
//        BrowserUtil.browse(tweetLink.text);
//    }
//
    function closeIconsOnMouseClicked(event: javafx.scene.input.MouseEvent): Void {
        scene.stage.close();
    }
//
//    public function getCloseIcons(): Stack {
//        return this.closeIcons;
//    }
    
    function retrieveButtonAction(): Void {
        progressIndicator.visible = true;
        statusMessageLabel.text = "Retrieving tweets ...";
        tweetUtil.retrieveData(true, progressIndicator);
    }

    function searchButtonAction(): Void {
        statusMessageLabel.text = "Searching tweets containing \"{searchTextBox.text.trim()}\" ...";
        tweetUtil.queryTweets(searchTextBox.text.trim());
        searchState.actual = 1;
        listView.select(-1);
    }
}

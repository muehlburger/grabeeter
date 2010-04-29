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
import javafx.scene.shape.Rectangle;
import javafx.scene.image.ImageView;
import javafx.scene.layout.Stack;
import javafx.stage.AppletStageExtension;
import javafx.animation.Timeline;
import grabeeter.model.Tweet;

public class Main {

    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:main
    public-read def dragArea: javafx.scene.shape.Rectangle = javafx.scene.shape.Rectangle {
        visible: true
        opacity: 0.0
        cursor: javafx.scene.Cursor.HAND
        onMouseDragged: dragAreaOnMouseDragged
        onMouseEntered: dragAreaOnMouseEntered
        onMouseExited: dragAreaOnMouseExited
        width: 600.0
        height: 15.0
        arcWidth: 10.0
        arcHeight: 10.0
    }
    
    def __layoutInfo_dragText: javafx.scene.layout.LayoutInfo = javafx.scene.layout.LayoutInfo {
        width: 200.0
        hpos: javafx.geometry.HPos.CENTER
        vpos: javafx.geometry.VPos.CENTER
    }
    public-read def dragText: javafx.scene.control.Label = javafx.scene.control.Label {
        visible: bind dragArea.hover and not closeIcons.visible
        disable: false
        managed: true
        layoutX: 10.0
        layoutY: 3.0
        layoutInfo: __layoutInfo_dragText
        text: "Drag me out of the Browser"
    }
    
    public-read def progressIndicator: javafx.scene.control.ProgressIndicator = javafx.scene.control.ProgressIndicator {
        visible: false
    }
    
    def __layoutInfo_statusMessageLabel: javafx.scene.layout.LayoutInfo = javafx.scene.layout.LayoutInfo {
        width: 500.0
        height: 15.0
    }
    public-read def statusMessageLabel: javafx.scene.control.Label = javafx.scene.control.Label {
        layoutInfo: __layoutInfo_statusMessageLabel
        text: ""
    }
    
    def __layoutInfo_onlineCheckbox: javafx.scene.layout.LayoutInfo = javafx.scene.layout.LayoutInfo {
        hfill: false
        vfill: false
        hpos: javafx.geometry.HPos.LEFT
        margin: null
    }
    public-read def onlineCheckbox: javafx.scene.control.CheckBox = javafx.scene.control.CheckBox {
        visible: true
        disable: false
        layoutY: 0.0
        layoutInfo: __layoutInfo_onlineCheckbox
        translateX: 150.0
        text: "search online"
        selected: true
    }
    
    def __layoutInfo_searchTextBox: javafx.scene.layout.LayoutInfo = javafx.scene.layout.LayoutInfo {
        width: 265.0
        height: 23.0
    }
    public-read def searchTextBox: javafx.scene.control.TextBox = javafx.scene.control.TextBox {
        layoutInfo: __layoutInfo_searchTextBox
        action: searchButtonAction
    }
    
    def __layoutInfo_searchButton: javafx.scene.layout.LayoutInfo = javafx.scene.layout.LayoutInfo {
        width: 138.0
    }
    public-read def searchButton: javafx.scene.control.Button = javafx.scene.control.Button {
        managed: true
        layoutInfo: __layoutInfo_searchButton
        text: "Search"
        action: searchButtonAction
    }
    
    def __layoutInfo_hbox: javafx.scene.layout.LayoutInfo = javafx.scene.layout.LayoutInfo {
        hfill: false
        vfill: false
        vpos: javafx.geometry.VPos.BOTTOM
    }
    public-read def hbox: javafx.scene.layout.HBox = javafx.scene.layout.HBox {
        layoutX: 65.0
        layoutY: 20.0
        layoutInfo: __layoutInfo_hbox
        content: [ searchTextBox, searchButton, ]
        spacing: 6.0
        nodeVPos: javafx.geometry.VPos.CENTER
    }
    
    public-read def listView: javafx.scene.control.ListView = javafx.scene.control.ListView {
        items: bind listViewItems
    }
    
    public-read def authorLabel: javafx.scene.control.Label = javafx.scene.control.Label {
        text: "Author"
    }
    
    public-read def textLabel: javafx.scene.control.Label = javafx.scene.control.Label {
        text: "Text:"
    }
    
    public-read def tweetLink: javafx.scene.control.Hyperlink = javafx.scene.control.Hyperlink {
    }
    
    def __layoutInfo_detailsVbox: javafx.scene.layout.LayoutInfo = javafx.scene.layout.LayoutInfo {
        width: 800.0
    }
    public-read def detailsVbox: javafx.scene.layout.VBox = javafx.scene.layout.VBox {
        layoutInfo: __layoutInfo_detailsVbox
        content: [ authorLabel, textLabel, tweetLink, ]
        spacing: 6.0
    }
    
    public-read def circle: javafx.scene.shape.Circle = javafx.scene.shape.Circle {
        opacity: 0.61
        cursor: javafx.scene.Cursor.HAND
        layoutY: 0.0
        radius: 8.0
    }
    
    public-read def logoImage: javafx.scene.image.Image = javafx.scene.image.Image {
        url: "{__DIR__}images/logo_tugraz.gif"
        backgroundLoading: false
        smooth: false
        width: 200.0
        height: 77.0
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
    
    def __layoutInfo_retrieveButton: javafx.scene.layout.LayoutInfo = javafx.scene.layout.LayoutInfo {
        width: 138.0
        height: 35.0
    }
    public-read def retrieveButton: javafx.scene.control.Button = javafx.scene.control.Button {
        managed: true
        layoutInfo: __layoutInfo_retrieveButton
        text: "Go"
        font: font
        action: retrieveButtonAction
    }
    
    def __layoutInfo_usernameTextBox: javafx.scene.layout.LayoutInfo = javafx.scene.layout.LayoutInfo {
        width: 394.0
        height: 35.0
    }
    public-read def usernameTextBox: javafx.scene.control.TextBox = javafx.scene.control.TextBox {
        managed: true
        layoutInfo: __layoutInfo_usernameTextBox
        effect: null
        text: ""
        promptText: "Enter your Twitter username here"
        selectOnFocus: true
        font: font
        action: retrieveButtonAction
    }
    
    def __layoutInfo_hbox2: javafx.scene.layout.LayoutInfo = javafx.scene.layout.LayoutInfo {
        hfill: false
        vfill: false
        hpos: javafx.geometry.HPos.CENTER
    }
    public-read def hbox2: javafx.scene.layout.HBox = javafx.scene.layout.HBox {
        visible: bind onlineCheckbox.selected
        managed: true
        layoutInfo: __layoutInfo_hbox2
        content: [ usernameTextBox, retrieveButton, ]
        spacing: 6.0
    }
    
    def __layoutInfo_headline: javafx.scene.layout.LayoutInfo = javafx.scene.layout.LayoutInfo {
        width: 0.0
    }
    public-read def headline: javafx.scene.control.Label = javafx.scene.control.Label {
        layoutInfo: __layoutInfo_headline
        effect: null
        text: "Grabeeter - Grab and Search your Tweets!"
        font: font
        textWrap: true
        hpos: javafx.geometry.HPos.CENTER
        textFill: null
    }
    
    def __layoutInfo_containerVbox: javafx.scene.layout.LayoutInfo = javafx.scene.layout.LayoutInfo {
        hfill: true
        vfill: true
    }
    public-read def containerVbox: javafx.scene.layout.VBox = javafx.scene.layout.VBox {
        layoutInfo: __layoutInfo_containerVbox
        content: [ progressIndicator, statusMessageLabel, headline, logoImageView, hbox2, onlineCheckbox, hbox, listView, detailsVbox, ]
        spacing: 5.0
        hpos: javafx.geometry.HPos.LEFT
        nodeHPos: javafx.geometry.HPos.CENTER
    }
    
    public-read def scene: javafx.scene.Scene = javafx.scene.Scene {
        width: 800.0
        height: 600.0
        content: getDesignRootNodes ()
        camera: null
        cursor: javafx.scene.Cursor.DEFAULT
        fill: backgroundGradient
    }
    
    init {
    }
    
    public-read def searchState: org.netbeans.javafx.design.DesignState = org.netbeans.javafx.design.DesignState {
        names: [ "HomePage", "Results", ]
        actual: 0
        timelines: [
            javafx.animation.Timeline {
                keyFrames: [
                    javafx.animation.KeyFrame {
                        time: 0ms
                        action: function() {
                            dragArea.managed = true;
                            dragArea.width = 800.0;
                            headline.managed = true;
                            headline.text = "Grabeeter - Grab and Search your Tweets!";
                            headline.textWrap = true;
                            headline.hpos = javafx.geometry.HPos.CENTER;
                            headline.vpos = javafx.geometry.VPos.CENTER;
                            usernameTextBox.text = "";
                            usernameTextBox.promptText = "enter your twitter username here";
                            usernameTextBox.selectOnFocus = true;
                            retrieveButton.font = font;
                            hbox2.managed = true;
                            hbox2.hpos = javafx.geometry.HPos.CENTER;
                            onlineCheckbox.layoutX = 0.0;
                            __layoutInfo_onlineCheckbox.hfill = false;
                            onlineCheckbox.translateX = 175.0;
                            onlineCheckbox.hpos = javafx.geometry.HPos.RIGHT;
                            __layoutInfo_searchTextBox.width = 394.0;
                            __layoutInfo_searchTextBox.height = 35.0;
                            searchTextBox.promptText = "what do you search for?";
                            searchTextBox.font = font;
                            searchButton.font = font;
                            hbox.visible = true;
                            hbox.managed = true;
                            hbox.layoutX = 0.0;
                            hbox.layoutY = 0.0;
                            __layoutInfo_hbox.hfill = true;
                            hbox.hpos = javafx.geometry.HPos.CENTER;
                            listView.visible = true;
                            authorLabel.text = "Author:";
                            tweetLink.text = "Url:";
                            detailsVbox.visible = true;
                            containerVbox.managed = true;
                        }
                    }
                ]
            }
            javafx.animation.Timeline {
                keyFrames: [
                    javafx.animation.KeyFrame {
                        time: 0ms
                        values: [
                            dragArea.width => dragArea.width tween javafx.animation.Interpolator.DISCRETE,
                            onlineCheckbox.layoutX => onlineCheckbox.layoutX tween javafx.animation.Interpolator.DISCRETE,
                            onlineCheckbox.translateX => onlineCheckbox.translateX tween javafx.animation.Interpolator.DISCRETE,
                            __layoutInfo_searchTextBox.width => __layoutInfo_searchTextBox.width tween javafx.animation.Interpolator.DISCRETE,
                            __layoutInfo_searchTextBox.height => __layoutInfo_searchTextBox.height tween javafx.animation.Interpolator.DISCRETE,
                            hbox.layoutX => hbox.layoutX tween javafx.animation.Interpolator.DISCRETE,
                            hbox.layoutY => hbox.layoutY tween javafx.animation.Interpolator.DISCRETE,
                        ]
                    }
                    javafx.animation.KeyFrame {
                        time: 500ms
                        values: [
                            dragArea.width => 600.0 tween javafx.animation.Interpolator.EASEBOTH,
                            onlineCheckbox.layoutX => 0.0 tween javafx.animation.Interpolator.EASEBOTH,
                            onlineCheckbox.translateX => 150.0 tween javafx.animation.Interpolator.EASEBOTH,
                            __layoutInfo_searchTextBox.width => 265.0 tween javafx.animation.Interpolator.EASEBOTH,
                            __layoutInfo_searchTextBox.height => 23.0 tween javafx.animation.Interpolator.EASEBOTH,
                            hbox.layoutX => 65.0 tween javafx.animation.Interpolator.EASEBOTH,
                            hbox.layoutY => 20.0 tween javafx.animation.Interpolator.EASEBOTH,
                        ]
                        action: function() {
                            dragArea.managed = true;
                            headline.managed = true;
                            headline.text = "Grabeeter - Grab and Search your Tweets!";
                            headline.textWrap = true;
                            headline.hpos = javafx.geometry.HPos.CENTER;
                            usernameTextBox.text = "";
                            usernameTextBox.promptText = "Enter your Twitter username here";
                            usernameTextBox.selectOnFocus = true;
                            retrieveButton.font = font;
                            hbox2.managed = true;
                            hbox2.hpos = javafx.geometry.HPos.LEFT;
                            __layoutInfo_onlineCheckbox.hfill = false;
                            onlineCheckbox.hpos = javafx.geometry.HPos.LEFT;
                            searchTextBox.promptText = null;
                            hbox.visible = true;
                            hbox.managed = true;
                            __layoutInfo_hbox.hfill = false;
                            hbox.hpos = javafx.geometry.HPos.LEFT;
                            listView.visible = true;
                            authorLabel.text = "Author";
                            tweetLink.text = null;
                            detailsVbox.visible = true;
                            containerVbox.managed = true;
                        }
                    }
                ]
            }
        ]
    }
    
    public-read def detailsState: org.netbeans.javafx.design.DesignState = org.netbeans.javafx.design.DesignState {
        names: [ "No Details", "Details", ]
        actual: 0
        timelines: [
            javafx.animation.Timeline {
                keyFrames: [
                    javafx.animation.KeyFrame {
                        time: 0ms
                    }
                ]
            }
            javafx.animation.Timeline {
                keyFrames: [
                    javafx.animation.KeyFrame {
                        time: 0ms
                    }
                ]
            }
        ]
    }
    
    public function getDesignRootNodes (): javafx.scene.Node[] {
        [ dragArea, dragText, containerVbox, closeIcons, ]
    }
    
    public function getDesignScene (): javafx.scene.Scene {
        scene
    }
    // </editor-fold>//GEN-END:main

    var listViewItems: Object[] = bind tweetUtil.searchResults;
  
    var tweetUtil = TweetUtil{
        location: bind "http://vlpc01.tugraz.at/projekte/herbert/t/web/api/tweets/{username}.xml"
        statusMessage: bind statusMessageLabel
    };

    var username = bind new URLConverter().encodeString(usernameTextBox.text);
   
//    var loadingFinished = bind tweetUtil.finished on replace {
//        if(loadingFinished == true) {
//            searchState.actual = 1;
//            statusMessageLabel.text = "Tweets saved now loading ...";
//            progressIndicator.visible = false;
//        }
//    }

    var selectedResult = bind listView.selectedItem as Tweet on replace {
        authorLabel.text = "Author: {selectedResult.screenName}";
        textLabel.text = "{selectedResult.screenName}: {selectedResult.text}";
        tweetLink.text = "Url: {selectedResult.url}";
        detailsState.actual = if (selectedResult != null) then 1 else 0;
    }

    var isApplet = "true".equals(FX.getArgument("isApplet") as String);
    var inBrowser = isApplet;
    var draggable = AppletStageExtension.appletDragSupported;

    function dragAreaOnMouseExited(e: javafx.scene.input.MouseEvent): Void {
        def fader = Timeline {
        keyFrames: [
            at (0s) {
                dragArea.opacity => 0.3
            },
            at (0.2s) {
                dragArea.opacity => 0.0
            }
        ]
        };
        fader.rate = 1.0;
        fader.play();
    }

    function dragAreaOnMouseEntered(e: javafx.scene.input.MouseEvent): Void {    

        def fader = Timeline {
        keyFrames: [
            at (0s) {
                dragArea.opacity => 0.0
            },
            at (0.2s) {
                dragArea.opacity => 0.3
            }
        ]
        };
        fader.rate = 1.0;
        fader.play();
    }

    function closeIconsOnMouseClicked(event: javafx.scene.input.MouseEvent): Void {
        scene.stage.close();
    }

    function dragAreaOnMouseDragged(e: javafx.scene.input.MouseEvent): Void {
        scene.stage.x += e.dragX;
        scene.stage.y += e.dragY;
    }

    public function getDragArea(): Rectangle {
        return this.dragArea;
    }

    public function getCloseIcons(): Stack {
        return this.closeIcons;
    }
    
    function retrieveButtonAction(): Void {
        progressIndicator.visible = true;
        statusMessageLabel.text = "Retrieving tweets ...";
        tweetUtil.retrieveData(onlineCheckbox.selected);
    }

    function searchButtonAction(): Void {
        progressIndicator.visible = true;
        statusMessageLabel.text = "Searching tweets containing \"{searchTextBox.text.trim()}\" ...";
        tweetUtil.queryTweets(searchTextBox.text.trim());
        searchState.actual = 1;
        listView.select(-1);
    }
}

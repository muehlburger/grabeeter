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

public class Main {

    public-read var logoImageView: javafx.scene.image.ImageView;//GEN-BEGIN:main
    public-read var headline: javafx.scene.control.Label;
    public-read var onlineCheckbox: javafx.scene.control.CheckBox;
    public-read var hbox3: javafx.scene.layout.HBox;
    public-read var label2: javafx.scene.control.Label;
    public-read var usernameTextBox: javafx.scene.control.TextBox;
    public-read var retrieveButton: javafx.scene.control.Button;
    public-read var hbox2: javafx.scene.layout.HBox;
    public-read var label: javafx.scene.control.Label;
    public-read var searchTextBox: javafx.scene.control.TextBox;
    public-read var searchButton: javafx.scene.control.Button;
    public-read var hbox: javafx.scene.layout.HBox;
    public-read var listView: javafx.scene.control.ListView;
    public-read var titleLabel: javafx.scene.control.Label;
    public-read var urlLabel: javafx.scene.control.Label;
    public-read var detailsBox: javafx.scene.layout.VBox;
    public-read var vbox: javafx.scene.layout.VBox;
    public-read var scene: javafx.scene.Scene;
    public-read var logoImage: javafx.scene.image.Image;
    public-read var backgroundGradient: javafx.scene.paint.LinearGradient;
    public-read var font: javafx.scene.text.Font;
    public-read var httpDataSource: org.netbeans.javafx.datasrc.HttpDataSource;
    
    public-read var searchState: org.netbeans.javafx.design.DesignState;
    public-read var detailsState: org.netbeans.javafx.design.DesignState;
    
    // <editor-fold defaultstate="collapsed" desc="Generated Init Block">
    init {
        onlineCheckbox = javafx.scene.control.CheckBox {
            visible: true
            disable: false
            layoutY: 0.0
            text: "online"
            selected: true
        };
        hbox3 = javafx.scene.layout.HBox {
            width: 278.0
            height: 17.0
            layoutInfo: javafx.scene.layout.LayoutInfo {
                width: bind hbox3.width
                height: bind hbox3.height
            }
            content: [ onlineCheckbox, ]
            hpos: javafx.geometry.HPos.LEFT
            spacing: 6.0
        };
        label2 = javafx.scene.control.Label {
            width: 123.0
            height: 15.0
            layoutInfo: javafx.scene.layout.LayoutInfo {
                width: bind label2.width
                height: bind label2.height
            }
            text: "Twitter Username:"
        };
        usernameTextBox = javafx.scene.control.TextBox {
            width: 265.0
            height: 23.0
            layoutInfo: javafx.scene.layout.LayoutInfo {
                width: bind usernameTextBox.width
                height: bind usernameTextBox.height
            }
            action: retrieveButtonAction
        };
        retrieveButton = javafx.scene.control.Button {
            width: 138.0
            height: 23.0
            layoutInfo: javafx.scene.layout.LayoutInfo {
                width: bind retrieveButton.width
                height: bind retrieveButton.height
            }
            text: "Update Tweets"
            action: retrieveButtonAction
        };
        hbox2 = javafx.scene.layout.HBox {
            visible: bind onlineCheckbox.selected
            content: [ label2, usernameTextBox, retrieveButton, ]
            vpos: javafx.geometry.VPos.CENTER
            spacing: 6.0
        };
        label = javafx.scene.control.Label {
            width: 123.0
            height: 15.0
            layoutInfo: javafx.scene.layout.LayoutInfo {
                width: bind label.width
                height: bind label.height
                hpos: javafx.geometry.HPos.RIGHT
            }
            text: "Search Query:"
        };
        searchTextBox = javafx.scene.control.TextBox {
            width: 265.0
            height: 23.0
            layoutInfo: javafx.scene.layout.LayoutInfo {
                width: bind searchTextBox.width
                height: bind searchTextBox.height
            }
            action: searchButtonAction
        };
        searchButton = javafx.scene.control.Button {
            width: 138.0
            layoutInfo: javafx.scene.layout.LayoutInfo {
                width: bind searchButton.width
                height: bind searchButton.height
            }
            text: "Search Tweets"
            action: searchButtonAction
        };
        hbox = javafx.scene.layout.HBox {
            layoutX: 65.0
            layoutY: 20.0
            layoutInfo: javafx.scene.layout.LayoutInfo {
                width: bind hbox.width
                height: bind hbox.height
                vpos: javafx.geometry.VPos.BOTTOM
            }
            content: [ label, searchTextBox, searchButton, ]
            nodeVPos: javafx.geometry.VPos.CENTER
            spacing: 6.0
        };
        listView = javafx.scene.control.ListView {
            visible: false
            opacity: 0.0
            width: 540.0
            height: 250.0
            layoutInfo: javafx.scene.layout.LayoutInfo {
                width: bind listView.width
                height: bind listView.height
            }
            items: bind listViewItems
        };
        titleLabel = javafx.scene.control.Label {
            textWrap: true
        };
        urlLabel = javafx.scene.control.Label {
            textWrap: true
        };
        detailsBox = javafx.scene.layout.VBox {
            visible: false
            opacity: 0.0
            width: 540.0
            layoutInfo: javafx.scene.layout.LayoutInfo {
                width: bind detailsBox.width
                height: bind detailsBox.height
            }
            content: [ titleLabel, urlLabel, ]
            spacing: 6.0
        };
        logoImage = javafx.scene.image.Image {
            url: "http://portal.tugraz.at/tu_graz/images/head/logo_head.gif"
            backgroundLoading: false
            smooth: false
            width: 200.0
            height: 77.0
            placeholder: null
            preserveRatio: true
        };
        logoImageView = javafx.scene.image.ImageView {
            image: logoImage
            preserveRatio: true
        };
        backgroundGradient = javafx.scene.paint.LinearGradient {
            endX: 0.0
            stops: [ javafx.scene.paint.Stop { offset: 0.0, color: javafx.scene.paint.Color.web ("#FFFFFF") }, javafx.scene.paint.Stop { offset: 0.4, color: javafx.scene.paint.Color.web ("#FFFFFF") }, javafx.scene.paint.Stop { offset: 0.6, color: javafx.scene.paint.Color.web ("#CCCCCC") }, javafx.scene.paint.Stop { offset: 1.0, color: javafx.scene.paint.Color.web ("#FFFFFF") }, ]
        };
        font = javafx.scene.text.Font {
            size: 70.0
        };
        headline = javafx.scene.control.Label {
            text: "Grabeeter"
            font: font
        };
        vbox = javafx.scene.layout.VBox {
            disable: false
            layoutX: 0.0
            layoutY: 0.0
            width: 600.0
            height: 0.0
            layoutInfo: javafx.scene.layout.LayoutInfo {
                width: bind vbox.width
                height: bind vbox.height
                hpos: javafx.geometry.HPos.LEFT
                vpos: javafx.geometry.VPos.TOP
                managed: true
            }
            content: [ logoImageView, headline, hbox3, hbox2, hbox, listView, detailsBox, ]
            hpos: javafx.geometry.HPos.CENTER
            vpos: javafx.geometry.VPos.TOP
            nodeHPos: javafx.geometry.HPos.CENTER
            spacing: 10.0
        };
        scene = javafx.scene.Scene {
            width: 600.0
            height: 600.0
            content: javafx.scene.layout.Panel {
                content: getDesignRootNodes ()
            }
            fill: backgroundGradient
        };
        httpDataSource = org.netbeans.javafx.datasrc.HttpDataSource {
            recordDisplayName: httpDataSourceRecordDisplayName
            url: ""
            parser: org.netbeans.javafx.datasrc.Parsers.JSON_PARSER
        };
        
        searchState = org.netbeans.javafx.design.DesignState {
            names: [ "HomePage", "Results", ]
            stateChangeType: org.netbeans.javafx.design.DesignStateChangeType.PAUSE_AND_PLAY_FROM_START
            actual: 0
            createTimeline: function (actual) {
                if (actual == 0) {
                    javafx.animation.Timeline {
                        keyFrames: [
                            javafx.animation.KeyFrame {
                                time: 0.001ms
                                action: function() {
                                    listView.visible = false;
                                    listView.opacity = 0.0;
                                    vbox.layoutX = 0.0;
                                    vbox.layoutY = 0.0;
                                    vbox.width = 600.0;
                                    vbox.height = 479.0;
                                }
                            }
                        ]
                    }
                } else if (actual == 1) {
                    javafx.animation.Timeline {
                        keyFrames: [
                            javafx.animation.KeyFrame {
                                time: 0.001ms
                                action: function() {
                                    listView.visible = true;
                                }
                            }
                            javafx.animation.KeyFrame {
                                time: 500ms
                                values: [
                                    listView.opacity => 1.0 tween javafx.animation.Interpolator.EASEBOTH,
                                    vbox.layoutX => 0.0 tween javafx.animation.Interpolator.EASEBOTH,
                                    vbox.layoutY => 0.0 tween javafx.animation.Interpolator.EASEBOTH,
                                    vbox.width => 600.0 tween javafx.animation.Interpolator.EASEBOTH,
                                    vbox.height => 479.0 tween javafx.animation.Interpolator.EASEBOTH,
                                ]
                            }
                        ]
                    }
                } else {
                    null
                }
            }
        }
        detailsState = org.netbeans.javafx.design.DesignState {
            names: [ "No Details", "Details", ]
            stateChangeType: org.netbeans.javafx.design.DesignStateChangeType.PAUSE_AND_PLAY_FROM_START
            actual: 0
            createTimeline: function (actual) {
                if (actual == 0) {
                    javafx.animation.Timeline {
                        keyFrames: [
                            javafx.animation.KeyFrame {
                                time: 500ms
                                values: [
                                    listView.width => 540.0 tween javafx.animation.Interpolator.EASEBOTH,
                                    listView.height => 250.0 tween javafx.animation.Interpolator.EASEBOTH,
                                    detailsBox.opacity => 0.0 tween javafx.animation.Interpolator.EASEBOTH,
                                ]
                                action: function() {
                                    detailsBox.visible = false;
                                }
                            }
                        ]
                    }
                } else if (actual == 1) {
                    javafx.animation.Timeline {
                        keyFrames: [
                            javafx.animation.KeyFrame {
                                time: 0.001ms
                                action: function() {
                                    detailsBox.visible = true;
                                }
                            }
                            javafx.animation.KeyFrame {
                                time: 500ms
                                values: [
                                    listView.width => 540.0 tween javafx.animation.Interpolator.EASEBOTH,
                                    listView.height => 283.0 tween javafx.animation.Interpolator.EASEBOTH,
                                    detailsBox.opacity => 1.0 tween javafx.animation.Interpolator.EASEBOTH,
                                ]
                            }
                        ]
                    }
                } else {
                    null
                }
            }
        }
    }// </editor-fold>
    
    // <editor-fold defaultstate="collapsed" desc="Generated Design Functions">
    public function getDesignRootNodes () : javafx.scene.Node[] {
        [ vbox, ]
    }
    
    public function getDesignScene (): javafx.scene.Scene {
        scene
    }// </editor-fold>//GEN-END:main

    var onlineCheckboxText: String = bind {if (onlineCheckbox.selected) then "online" else "offline"};

    var listViewItems: Object[] = bind tweetUtil.searchResults;

    var tweetUtil = TweetUtil{
        location: bind "http://vlpc01.tugraz.at/projekte/herbert/tweetex/web/api/tweets/{username}.xml"
    };

    var username = bind new URLConverter().encodeString(usernameTextBox.text);

    var loadingFinished = bind tweetUtil.finished on replace {
        if(loadingFinished == true) {
            searchState.actual = 1;
            println("saving finished now loading ...");
            tweetUtil.load();
            tweetUtil.indexTweets();
        }
    }
    
    function retrieveButtonAction(): Void {
        delete tweetUtil.tweets;
        delete tweetUtil.searchResults;
        tweetUtil.retrieveData(onlineCheckbox.selected);
        listView.select(-1);
    }

    var selectedResult = bind listView.selectedItem as String on replace {
        titleLabel.text = "Tweet: {selectedResult}";
        urlLabel.text = "URL: {if(selectedResult != null) then new URLConverter ().decodeString(selectedResult) else ""}";
        detailsState.actual = if (selectedResult != null) then 1 else 0;
    }

    function httpDataSourceRecordDisplayName(record: org.netbeans.javafx.datasrc.Record): String {
        record.getString("text")
    }

    function searchButtonAction(): Void {
        tweetUtil.queryTweets(searchTextBox.text.trim());
        searchState.actual = 1;
        listView.select(-1);
    }


}
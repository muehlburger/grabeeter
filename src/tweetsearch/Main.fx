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

package tweetsearch;

import javafx.io.http.URLConverter;

public class Main {

    public-read var logoImageView: javafx.scene.image.ImageView;//GEN-BEGIN:main
    public-read var label: javafx.scene.control.Label;
    public-read var searchTextBox: javafx.scene.control.TextBox;
    public-read var goButton: javafx.scene.control.Button;
    public-read var hbox: javafx.scene.layout.HBox;
    public-read var listView: javafx.scene.control.ListView;
    public-read var titleLabel: javafx.scene.control.Label;
    public-read var urlLabel: javafx.scene.control.Label;
    public-read var detailsBox: javafx.scene.layout.VBox;
    public-read var vbox: javafx.scene.layout.VBox;
    public-read var scene: javafx.scene.Scene;
    public-read var logoImage: javafx.scene.image.Image;
    public-read var backgroundGradient: javafx.scene.paint.LinearGradient;
    public-read var httpDataSource: org.netbeans.javafx.datasrc.HttpDataSource;
    
    public-read var searchState: org.netbeans.javafx.design.DesignState;
    public-read var detailsState: org.netbeans.javafx.design.DesignState;
    
    // <editor-fold defaultstate="collapsed" desc="Generated Init Block">
    init {
        label = javafx.scene.control.Label {
            text: "Search:"
        };
        searchTextBox = javafx.scene.control.TextBox {
            width: 265.0
            height: 23.0
            layoutInfo: javafx.scene.layout.LayoutInfo {
                width: bind searchTextBox.width
                height: bind searchTextBox.height
            }
            action: goButtonAction
        };
        goButton = javafx.scene.control.Button {
            text: "Tweet-Search"
            action: goButtonAction
        };
        hbox = javafx.scene.layout.HBox {
            layoutX: 65.0
            layoutY: 20.0
            layoutInfo: javafx.scene.layout.LayoutInfo {
                width: bind hbox.width
                height: bind hbox.height
                vpos: javafx.geometry.VPos.BOTTOM
            }
            content: [ label, searchTextBox, goButton, ]
            nodeVPos: javafx.geometry.VPos.CENTER
            spacing: 6.0
        };
        listView = javafx.scene.control.ListView {
            visible: false
            opacity: 0.0
            width: 460.0
            height: 250.0
            layoutInfo: javafx.scene.layout.LayoutInfo {
                width: bind listView.width
                height: bind listView.height
            }
            items: bind httpDataSource.getDataSource("responseData/results").getRecordSet().all()
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
            width: 460.0
            layoutInfo: javafx.scene.layout.LayoutInfo {
                width: bind detailsBox.width
                height: bind detailsBox.height
            }
            content: [ titleLabel, urlLabel, ]
            spacing: 6.0
        };
        logoImage = javafx.scene.image.Image {
            url: "http://www.google.com/images/logo.gif"
        };
        logoImageView = javafx.scene.image.ImageView {
            image: logoImage
        };
        vbox = javafx.scene.layout.VBox {
            layoutX: 0.0
            layoutY: 0.0
            width: 600.0
            height: 479.0
            layoutInfo: javafx.scene.layout.LayoutInfo {
                width: bind vbox.width
                height: bind vbox.height
            }
            content: [ logoImageView, hbox, listView, detailsBox, ]
            hpos: javafx.geometry.HPos.CENTER
            nodeHPos: javafx.geometry.HPos.CENTER
            spacing: 20.0
        };
        backgroundGradient = javafx.scene.paint.LinearGradient {
            endX: 0.0
            stops: [ javafx.scene.paint.Stop { offset: 0.0, color: javafx.scene.paint.Color.web ("#FFFFFF") }, javafx.scene.paint.Stop { offset: 0.4, color: javafx.scene.paint.Color.web ("#FFFFFF") }, javafx.scene.paint.Stop { offset: 0.6, color: javafx.scene.paint.Color.web ("#CCCCCC") }, javafx.scene.paint.Stop { offset: 1.0, color: javafx.scene.paint.Color.web ("#FFFFFF") }, ]
        };
        scene = javafx.scene.Scene {
            width: 600.0
            height: 400.0
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
                                    logoImageView.opacity = 1.0;
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
                                    logoImageView.opacity => 1.0 tween javafx.animation.Interpolator.EASEBOTH,
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
                                    listView.height => 170.0 tween javafx.animation.Interpolator.EASEBOTH,
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

    var selectedResult = bind listView.selectedItem as org.netbeans.javafx.datasrc.Record on replace {
        titleLabel.text = "Tweet: {selectedResult.getString ("text")}";
        urlLabel.text = "URL: {new URLConverter ().decodeString(selectedResult.getString ("url"))}";
        detailsState.actual = if (selectedResult != null) then 1 else 0;
    }

    function httpDataSourceRecordDisplayName(record: org.netbeans.javafx.datasrc.Record): String {
        record.getString("text")
    }

    function goButtonAction(): Void {
        httpDataSource.url = "http://www.tweetex.dat/frontend_dev.php/api/{new URLConverter().encodeString(searchTextBox.text)}/search.json";
        searchState.actual = 1;
        listView.select(-1);
    }

}

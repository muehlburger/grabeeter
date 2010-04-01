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
 
package org.netbeans.javafx.datasrc;

import javafx.data.pull.PullParser;
import javafx.data.pull.Event;
import org.netbeans.javafx.datasrc.MemoryRecordSet;

/**
 * Collection of common stream parsers.
 *
 * @author Maros Sandor
 */

public-read def LINE_PARSER_FIELD_LINE = ".line";

/**
 * Parses the input stream line by line. The result is a RecodSet that contains a Record for each line of input.
 * Records contain just one field named "line" that contains the line.
 */
public-read def LINE_PARSER = StreamParser {

    override public function parse(input : java.io.Reader, recordDisplayName : function(record : Record) : String) : RecordSet {
        var line : String;
        var result : Record [] = [];
        line = readLine(input);

        // BEWARE  ("" == null) is true
        while (line != null or "".equals(line)) {
            var map = new java.util.HashMap();
            map.put(LINE_PARSER_FIELD_LINE, line);
            var record = MapRecord {
                fields: map
                displayName: recordDisplayName
            }
            insert record into result;
            line = readLine(input);
        }
        MemoryRecordSet {
            records: result
        }
    }
}

function readLine(in : java.io.Reader) : String {
    var str = new java.lang.StringBuilder;
    while (true) {
        var c = in.read();
        if (c == -1) {
            return if (str.length() == 0) then null else str.toString();
        } else if (c == 0x0D) {
            c = in.read();
            if (c == 0x0A or c == -1) {
                return str.toString();
            }
            str.append(0x0D);
        } else if (c == 0x0A) {
            return str.toString();
        }
        str.append(c as Character);
    }
    str.toString()
}

/**
 * Treats the input stream as JSON. JSON arrays are converted into RecordSet obejcts.
 */
public-read def JSON_PARSER = StreamParser {

    function toSequence(list : java.util.List) : Record [] {
        var result : Record [] = [];
        var ii = list.iterator();
        while (ii.hasNext()) {
            var r = ii.next() as Record;
            insert r into result;
        }
        result
    }

    override public function parse(input : java.io.InputStream, recordDisplayName : function(record : Record) : String) : RecordSet {

        var topLevel : Object;

        def parser = PullParser {
            documentType: PullParser.JSON
            input: input

            var mapStack = new java.util.Stack();
            var currentMap : java.util.Map;
            var recordsStack = new java.util.Stack();
            var currentRecords : java.util.List;

            var lastEvent: Event;

            onEvent: function(event: Event) {
                if (event.type == PullParser.TEXT) {
                    currentMap.put(event.name, event.text)
                } else if (event.type == PullParser.INTEGER) {
                    currentMap.put(event.name, event.integerValue)
                } else if (event.type == PullParser.NULL) {
                    currentMap.put(event.name, null)
                } else if (event.type == PullParser.START_ELEMENT) {
                    if (lastEvent.type == PullParser.START_ARRAY_ELEMENT) return;
                    var oldMap = currentMap;

                    var temp = new java.util.HashMap();
                    temp.put(new Object(), null);
                    currentMap = temp;
                    currentMap.clear();

                    mapStack.push(currentMap);
                    if (topLevel == null) topLevel = currentMap;
                    if (oldMap != null) {
                        var mr = MapRecord {
                            fields: currentMap
                            displayName: recordDisplayName
                        }
                        if (event.name == "" and lastEvent.type == PullParser.START_VALUE) {
                            oldMap.put(lastEvent.name, mr)
                        } else {
                            oldMap.put(event.name, mr)
                        }
                    }
                } else if (event.type == PullParser.START_ARRAY_ELEMENT) {

                    var temp = new java.util.HashMap();
                    temp.put(new Object(), null);
                    currentMap = temp;
                    currentMap.clear();

                    mapStack.push(currentMap);
                    var mr = MapRecord {
                        fields: currentMap
                        displayName: recordDisplayName
                    }
                    currentRecords.add(mr);
                } else if (event.type == PullParser.END_ELEMENT) {
                    mapStack.pop();
                    if (not mapStack.empty()) {
                        currentMap = mapStack.peek() as java.util.HashMap;
                    } else {
                        currentMap = null;
                    }
                } else if (event.type == PullParser.END_ARRAY_ELEMENT) {
                    if (lastEvent.type == PullParser.END_ELEMENT) return;
                    mapStack.pop();
                    if (not mapStack.empty()) {
                        currentMap = mapStack.peek() as java.util.HashMap;
                    } else {
                        currentMap = null;
                    }
                } else if (event.type == PullParser.START_ARRAY) {
                    currentRecords = new java.util.ArrayList();
                    recordsStack.push(currentRecords);
                    if (topLevel == null) topLevel = currentRecords;
                } else if (event.type == PullParser.END_ARRAY) {
                    var set = MemoryRecordSet {
                        records: toSequence(currentRecords)
                    }
                    currentMap.put(event.name, set);
                    recordsStack.pop();
                    if (not recordsStack.empty()) {
                        currentRecords = recordsStack.peek() as java.util.List;
                    } else {
                        currentRecords = null;
                    }
                }
                lastEvent = event;
            }
        }
        parser.parse();

        if (topLevel instanceof java.util.Map) {
            var mr = MapRecord {
                fields: topLevel as java.util.Map
                displayName: recordDisplayName
            }
            MemoryRecordSet {
               records: [mr]
            }
        } else {
            // List
            var rs = MemoryRecordSet {
                records: toSequence(topLevel as java.util.List)
            }
            rs
        }
            
    }
}

public-read def XML_RECORD_ELEMENTS = ".elements";
public-read def XML_RECORD_NAME = ".name";
public-read def XML_RECORD_NAMESPACE = ".namespace";
public-read def XML_RECORD_TEXT = ".text";

/**
 * Treats the input stream as XML.
 *
 * - every XML element transforms to a Record
 * - there is only one Record in the root RecordSet (corresponding to the root XML element)
 * - each attribute of an XML element transofrms to a field in its XML element Record
 * - Records have, besides regular XML attributes, these special fields (their names begin with a dot):
 *   - ".name": name of the XML element, never null
 *   - ".text": inner text of the element, if any (text must be non-empty after trimming), may be null
 *   - ".namespace": namespace of the element, may be null
 *   - ".elements": child elements as RecordSet, may be null
 */
public-read def XML_PARSER = StreamParser {

    override public function parse(input : java.io.InputStream, recordDisplayName : function(record : Record) : String) : RecordSet {

        var topLevel : Object;

        def parser = PullParser {
            documentType: PullParser.XML
            input: input

            var mapStack = new java.util.Stack();
            var currentMap : java.util.Map;

            onEvent: function(event: Event) {
                if (event.type == PullParser.TEXT) {
                    if (event.text.trim().length() > 0) {
                        currentMap.put(XML_RECORD_TEXT, event.text)
                    }
                } else if (event.type == PullParser.START_ELEMENT) {
                    var oldMap = currentMap;

                    var temp = new java.util.HashMap();
                    temp.put(new Object(), null);
                    currentMap = temp;
                    currentMap.clear();

                    mapStack.push(currentMap);
                    if (topLevel == null) topLevel = currentMap;

                    currentMap.put(XML_RECORD_NAME, event.qname.name);
                    if (event.qname.namespace.length() > 0) {
                        currentMap.put(XML_RECORD_NAMESPACE, event.qname.namespace);
                    }
                    for (qname in event.getAttributeNames()) {
                        var value = event.getAttributeValue(qname.name);
                        currentMap.put(qname.name, value);
                    }

                    if (oldMap != null) {
                        var mr = MapRecord {
                            fields: currentMap
                            displayName: recordDisplayName
                        }

                        var elements = oldMap.get(XML_RECORD_ELEMENTS) as MemoryRecordSet;
                        if (elements == null) {
                            elements = MemoryRecordSet {
                                records: []
                            }
                            oldMap.put(XML_RECORD_ELEMENTS, elements)
                        }

                        insert mr into elements.records;
                    }
                } else if (event.type == PullParser.END_ELEMENT) {
                    mapStack.pop();
                    if (not mapStack.empty()) {
                        currentMap = mapStack.peek() as java.util.HashMap;
                    } else {
                        currentMap = null;
                    }
                }
            }
        }
        parser.parse();

        var mr = MapRecord {
            fields: topLevel as java.util.Map
            displayName: recordDisplayName
        }
        MemoryRecordSet {
           records: [mr]
        }
    }
}

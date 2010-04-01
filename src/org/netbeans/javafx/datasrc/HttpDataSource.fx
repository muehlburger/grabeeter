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

import javafx.io.http.*;
import org.netbeans.javafx.datasrc.MemoryRecordSet;
import javafx.data.Pair;

/**
 * Fetches Records from an HTTP or HTTPS source or web service.
 *
 * @author Maros Sandor
 */
public class HttpDataSource extends DataSource {

    /**
     * URL of the web service.
     */
    public var url : String on replace {
        autorefresh()
    }

    /**
     * Username for authentication purposes or null if authentication is not used.
     */
    public var user : String on replace {
        autorefresh()
    }

    /**
     * Password for authentication purposes or null if authentication is not used.
     */
    public var password : String on replace {
        autorefresh()
    }

    /**
     * Connection method to use while issueing the request.
     */
    public var connectionMethod = HttpRequest.GET on replace {
        autorefresh()
    }

    /**
     * Additional request (query) parameters to send when issueing the request. 
     * Parameters are separated using ampersand, names and values are separated by equal sign.
     * Parameter values must be already properly encoded using UrlConverter.
     * Using queryParams property is more convenient in most cases and is also recommended.
     * Example: name=John+Smith&company=J%26S+Inc.
     */
    public var requestParams : String on replace {
        autorefresh()
    }

    /**
     * Additional request (query) parameters to send when issueing the request.
     * Parameters are specified as name,value pairs and should NOT be encoded in any way
     * (UrlConverter will be used automatically).
     */
    public var queryParams : Pair [] on replace {
        def urlc = URLConverter{}
        requestParams = urlc.encodeParameters(queryParams)
    }

    /**
     * Additional request (query) headers to send when issueing the request.
     */
    public var requestHeaders : String on replace {
        autorefresh()
    }

    /**
     * Defines format of incoming data. The default is JSON.
     */
    public-init var parser : StreamParser = Parsers.JSON_PARSER on replace {
        autorefresh()
    }

    override public function fetchData() : Void {
        sendRequest(url);
    }

    override public function metaData() : RecordSetMetadata {
        null
    }

    function sendRequest(requestUrl : String) : Void {
        if (requestUrl == null or requestUrl.length() == 0) {
            dataFetched(MemoryRecordSet {
               records: []
            });
            return;
        }

        var postData;
        if (requestParams != null) {
            postData = requestParams.getBytes("UTF-8");
        }

        var request : HttpRequest;

        request = HttpRequest {
            location: requestUrl
            method: connectionMethod

            onException: function(exception: java.lang.Exception) {
                dataFetchError(exception);
            }

            onOutput: function(os: java.io.OutputStream) {
                try {
                    if (connectionMethod == HttpRequest.POST and postData != null) {
                        os.write(postData);
                    }
                } finally {
                    os.close();
                }
            }

            onInput: function(input: java.io.InputStream) {
                try {
                    if (request.responseCode == HttpStatus.OK) {
                        dataFetched(parser.parse(input, recordDisplayName))
                    }
                } finally {
                    input.close();
                }
            }

            onDone: function() {
                if (request.responseCode == HttpStatus.MOVED_PERM or request.responseCode == HttpStatus.MOVED_TEMP) {
                    for (header in request.responseHeaders) {
                        if (header.name == HttpHeader.LOCATION) {
                            sendRequest(header.value);
                            break;
                        }
                    }
                }
            }
        }

        if (postData != null) {
            var header = HttpHeader {
                name:   HttpHeader.CONTENT_LENGTH
                value:  "{sizeof postData}"
            }
            insert header into request.headers;

            header = HttpHeader {
                name:   HttpHeader.CONTENT_TYPE
                value:  "application/x-www-form-urlencoded"
            }
            insert header into request.headers;
        }

        if (user != null and user != "") {
            var pwd = password;
            if (pwd == null) {
                pwd = ""
            }
            var userPassword = "{user}:{pwd}";
            var authString = "Basic {Base64.encode(userPassword)}";
            var header = HttpHeader {
                    name: HttpHeader.AUTHORIZATION
                    value: authString
            }
            insert header into request.headers;
        }

        request.start();
    }

}

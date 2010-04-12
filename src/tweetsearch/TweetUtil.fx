/*
 * TweetUtil.fx
 *
 * Created on 07.04.2010, 11:59:40
 */
package tweetsearch;

import javafx.io.Storage;
import javafx.io.http.HttpRequest;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import javafx.data.pull.*;

/**
 * @author Herbert Muehlburger
 */
public class TweetUtil {

    public var location: String;
    public var tweets: String[];
    public var finished: Boolean;
    
    var storage = Storage {
        source: "twitter-search";
    };

    init {
        storage.resource.maxLength = 1048576; // 1MB
        finished = false;
    }

    public function load(): Void {
        var ressource = storage.resource;
        var is = ressource.openInputStream();

        var pullParser = PullParser {
            input: is
            documentType: PullParser.XML
            onEvent: function(e) {
                if(e.type == PullParser.START_ELEMENT) {
                    
                    if(e.qname.name == "tweet") {
                        //println( "{%-20s e.typeName} {%-20s e.qname.name} {%-20s e.text}");
                        for(qname in e.getAttributeNames()) {
                            var value = e.getAttributeValue(qname);
                            if(qname.name == "text")
                                insert value into tweets;
                            //println( "{%-20s "   url"} {%-20s qname.name} {%-20s value}");
                        }
                    }
                }
            }
        };

        try {
            pullParser.parse();
        } catch(e: java.lang.Exception) {
            e.printStackTrace();
        }



    }

    public function retrieveData(): Void {
        finished = false;
        def httpRequest = HttpRequest {
                    location: bind location
                    method: HttpRequest.GET
                    onInput: function (in: java.io.InputStream) {
                        try {
                            // Read the content from this InputStream
                            // Pass the InputStream to parserd
                            save(in);
                        } finally {
                            in.close();
                        }
                    }
                    onDone: function(): Void {
                        println("done reading tweets");
                        finished = true;
                    }

                }
        httpRequest.start();
    }

    public function save(in: java.io.InputStream): Void {

        delete tweets;
        var ressource = storage.resource;

        var os = ressource.openOutputStream(true);
        var out = new java.io.PrintWriter(os);
        var reader: BufferedReader;

        try {
            reader = new BufferedReader(new InputStreamReader(in));
            var line = reader.readLine();
            while(line != null) {
                out.println(line);
                line = reader.readLine();
            }

        } catch(e: java.lang.Exception) {
          e.printStackTrace();
        }
        finally {
            if(reader != null) {
                reader.close();
            } else {
                in.close();
            }
        }
        println("{ressource.length} Bytes saved from {location}");
        out.close();
    }

}

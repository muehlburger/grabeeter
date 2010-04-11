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

/**
 * @author Herbert Muehlburger
 */
public class TweetUtil {

    public var location: String;
    
    var storage = Storage {
        source: "local-tweets";
    };

    init {
        storage.resource.maxLength = 1048576; // 1MB
    }

    public function save(in: java.io.InputStream): Void {

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

    public function load(): Void {
        var ressource = storage.resource;
        var is = ressource.openInputStream();
    }

    public function retrieveData(): Void {
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
                }
        httpRequest.start();
    }

}

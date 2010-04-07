/*
 * TweetUtil.fx
 *
 * Created on 07.04.2010, 11:59:40
 */
package tweetsearch;
import javafx.io.Storage;

/**
 * @author Herbert Muehlburger
 */
public class TweetUtil {

    var storage = Storage {
        source: "local-tweets"
    }

//    init {
//        storage.resource.maxLength = -1;
//    }


    public function save(): Void {
        var ressource = storage.resource;
        var os = ressource.openOutputStream(true);
        var out = new java.io.PrintStream(os);


        out.println("username");
        out.println("text");
        out.close();
    }

    public function load(): Void {
        var ressource = storage.resource;
        var is = ressource.openInputStream();
    }


}

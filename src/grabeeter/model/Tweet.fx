/*
 * Tweet.fx
 *
 * Created on 12.04.2010, 12:20:03
 */

package grabeeter.model;

/**
 * @author Herbert Muehlburger
 */

public class Tweet {
    public var text: String;
    public var screenName: String;
    public var created: String;
    public var url: String;
    public var twitterUrl: String;

    public override function toString(): String {
        "{created}: {text}"
    }

}

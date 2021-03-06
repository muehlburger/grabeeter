/*
 * TweetUtil.fx
 *
 * Created on 07.04.2010, 11:59:40
 */
package grabeeter;

import javafx.io.Storage;
import javafx.io.http.HttpRequest;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import javafx.data.pull.*;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.RAMDirectory;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.de.GermanAnalyzer;
import org.apache.lucene.util.Version;
import java.io.IOException;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.search.Query;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.TopScoreDocCollector;
import org.apache.lucene.search.ScoreDoc;
import grabeeter.model.Tweet;

import org.apache.lucene.analysis.standard.StandardAnalyzer;
/**
 * @author Herbert Muehlburger
 */
public class TweetUtil {

    public var location: String;
    public var tweets: Tweet[];
    public var searchResults: Tweet[];
    public var finished: Boolean = true;
    public var statusMessage: javafx.scene.control.Label;
    public var screenName: String;

    public var periodStart: String;
    public var periodEnd: String;

    public var origPeriodStart: String;
    public var origPeriodEnd: String;
    
    var storage = Storage {
        source: "grabeeter";
    };

    var analyser: Analyzer;
    var index : Directory;

    init {
        storage.resource.maxLength = 104857600; // 100MB
        //storage.clear();
        load();
        indexTweets();
    }

    public function load(): Void {
        var ressource = storage.resource;
        var is = ressource.openInputStream();

        var pullParser = PullParser {
            input: is
            documentType: PullParser.XML
            onEvent: function(e) {
                if(e.type == PullParser.START_ELEMENT) {
                    var tweet : Tweet = new Tweet();
                    if(e.qname.name == "tweet") {
                        //println( "{%-20s e.typeName} {%-20s e.qname.name} {%-20s e.text}");
                        for(qname in e.getAttributeNames()) {
                            var value = e.getAttributeValue(qname);
                            if(qname.name == "text") {
                                tweet.text = value;
                            } else if(qname.name == "created") {
                                tweet.created = value;
                            } else if(qname.name == "screen_name") {
                                screenName = value;
                                tweet.screenName = value;
                            } else if(qname.name == "url") {
                                tweet.url = value;
                            } else if(qname.name == "twitterUrl") {
                                tweet.twitterUrl = value;
                            }
                            //println( "{%-20s "   url"} {%-20s qname.name} {%-20s value}");
                        }
                    insert tweet into tweets;
                    }
                }
            }
        };

        try {
            statusMessage.text = "Loading saved tweets ...";
            pullParser.parse();
        } catch(e: java.lang.NullPointerException) {
            statusMessage.text = "Please retrieve your tweets first ...";
        } catch(e: java.lang.Exception) {
            e.printStackTrace();
        }
    }

    public function retrieveData(online: Boolean, progress: javafx.scene.control.ProgressIndicator): Void {
        delete tweets;
        delete searchResults;
        if(online) {
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
                            finished = true;
                            load();
                            indexTweets();
                        }

                    }
            httpRequest.start();
        } else {
            finished = true;
        }

    }

    public function save(in: java.io.InputStream): Void {
        statusMessage.text = "Saving tweets ...";
        delete tweets;
        var ressource = storage.resource;
        println("ressource-writable: {ressource.writable}");
        println("ressource-length: {ressource.length}");
        println("ressource-name: {ressource.name}");
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
        statusMessage.text = "Tweets saved.";
        out.close();
    }

    public function indexTweets() {
        finished = false;
        delete searchResults;
        statusMessage.text = "Indexing tweets ...";
        analyser = new StandardAnalyzer(Version.LUCENE_30);
        index = new RAMDirectory();
        var w : IndexWriter = new IndexWriter(index, analyser, true, IndexWriter.MaxFieldLength.UNLIMITED);
        
        for(tweet in tweets) {
            addDoc(w, tweet);
            insert tweet into searchResults;
        }

        w.close();
        statusMessage.text = "Indexing finished! Ready to search! ;-)";
        
        // Update the start and end peroid where tweets are available
        periodStart = tweets[tweets.size()-1].created;
        periodEnd = tweets[0].created;

        // Store original periods for later use
        origPeriodStart = periodStart;
        origPeriodEnd = periodEnd;

        finished = true;
    }

    function addDoc(w: IndexWriter, tweet: Tweet): Void {
        try {
            var doc: Document = new Document();
            doc.add(new Field("tweet-text", tweet.text, Field.Store.YES, Field.Index.ANALYZED));
            doc.add(new Field("screenName", tweet.screenName, Field.Store.YES, Field.Index.ANALYZED));
            doc.add(new Field("created", tweet.created, Field.Store.YES, Field.Index.ANALYZED));
            doc.add(new Field("url", tweet.url, Field.Store.YES, Field.Index.ANALYZED));
            doc.add(new Field("twitterUrl", tweet.twitterUrl, Field.Store.YES, Field.Index.ANALYZED));
            w.addDocument(doc);
        } catch(e: IOException) {
            e.printStackTrace();
        }
    }

    public function queryTweets(queryString: String, periodStart: String, periodEnd: String): Void {
        delete searchResults;
        println("searching tweets containing {queryString} from {periodStart} to {periodEnd}");

        var searcher: IndexSearcher = new IndexSearcher(index, true);
        var rangeQuery: String = "created:[{periodStart} TO {periodEnd}]";

        var parser: QueryParser  = new QueryParser(Version.LUCENE_30, "tweet-text", analyser);
        var q: Query;

        if(queryString == "") {
            q = parser.parse("{rangeQuery}");
        }
        else {
            var escapedString: String = parser.escape(queryString);
            q = parser.parse("{rangeQuery} AND {escapedString}");
        }

        var hitsPerPage: Integer = 3200;
       
        var collector: TopScoreDocCollector = TopScoreDocCollector.create(hitsPerPage, true);
        searcher.search(q, collector);

        var hits: ScoreDoc[] = collector.topDocs().scoreDocs;
        for(hit in hits) {
            var docId: Integer = hit.doc;
            var d: Document = searcher.doc(docId);
            var t: Tweet = new Tweet();
            t.text = d.get("tweet-text");
            t.screenName = d.get("screenName");
            t.created = d.get("created");
            t.url = d.get("url");
            t.twitterUrl = d.get("twitterUrl");
            insert t into searchResults;
        }
    }

    public function resetToDefault() {
        searchResults = tweets;
        periodStart = origPeriodStart;
        periodEnd = origPeriodEnd;
    }





}

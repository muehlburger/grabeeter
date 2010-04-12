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

/**
 * @author Herbert Muehlburger
 */
public class TweetUtil {

    public var location: String;
    public var tweets: String[];
    public var searchResults: String[];
    public var finished: Boolean;
    
    var storage = Storage {
        source: "twitter-search";
    };

    var analyser: Analyzer;
    var index : Directory;

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

    public function indexTweets() {
        // 0. Specify the analyzer for tokenizing text.
        //    The same analyzer should be used for indexing and searching
        analyser = new GermanAnalyzer(Version.LUCENE_30);

        // 1. Create the index
        index = new RAMDirectory();

        // the boolean arg in the IndexWriter ctor means to
        // create a new index, overwriting any existing index
        var w : IndexWriter = new IndexWriter(index, analyser, true, IndexWriter.MaxFieldLength.UNLIMITED);
        
        for(tweet in tweets) {
            this.addDoc(w, tweet);
        }

        w.close();
        println("finished to index tweets ...");
    }

    function addDoc(w: IndexWriter, value: String): Void {
        try {
            var doc: Document = new Document();
            doc.add(new Field("tweet-text", value, Field.Store.YES, Field.Index.ANALYZED));
            w.addDocument(doc);
        } catch(e: IOException) {
            e.printStackTrace();
        }
    }

    public function queryTweets(queryString: String): Void {
        println("queryString: {queryString}");
        delete searchResults;
        var parser: QueryParser = new QueryParser(Version.LUCENE_30, "tweet-text", analyser);
        
        var q: Query = parser.parse(queryString);

        // 3. Search
        var hitsPerPage: Integer = 3200;
        var searcher: IndexSearcher = new IndexSearcher(index, true);
        var collector: TopScoreDocCollector = TopScoreDocCollector.create(hitsPerPage, true);
        searcher.search(q, collector);

        var hits: ScoreDoc[] = collector.topDocs().scoreDocs;
        for(hit in hits) {
            var docId: Integer = hit.doc;
            var d: Document = searcher.doc(docId);
            var tweet: String = d.get("tweet-text");
            insert tweet into searchResults;
        }
        println("Tweets: {searchResults}");

        //println("hits: {hits}");
    }




}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

class Details extends StatefulWidget {
  final String link;

  const Details({Key? key, required this.link});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool isLoading = true;
  bool linkDone = false;
  String finishedVideo = "";

  getVideo() async {
    print("finding video src...");

    var url = widget.link;
    print(url);
    var response = await http.get(Uri.parse(url));

    dom.Document document = parser.parse(response.body);
    try {
      var firstVid =
          document.getElementsByTagName("iframe")[0].attributes["src"];

      var script = document.getElementsByTagName("body")[0].innerHtml;
      print("nana....................");
      print(script.toString() + "stephen.............");

      setState(() {
        finishedVideo = firstVid.toString().substring(2);
        
        // print(firstVid);
        print(finishedVideo.substring(2) + "link..........");
        // print("finished.");

        linkDone = true;
      });
    } catch (e) {
      setState(() {
        // print(widget.link);
        finishedVideo = widget.link;
        print("else");
        linkDone = true;
      });
    }

    // print(firstVid);

    // var vid = document.getElementsByTagName("iframe");

    // vid.forEach((element) {
    //   var pic = element.innerHtml.toString();
    //   parser.parse(pic).getElementsByTagName("iframe").forEach((element) {
    //     // var links = element.innerHtml;
    //     print(element.attributes["src"]);
    //     var video = element.attributes["src"];
    //     setState(() {
    //         finishedVideo = video.toString();

    // print("done");

    //     });
    //     // icons.add(src.toString());
    //     // print(element.text);
    //     // print(element.outerHtml);
    //     // print(element.attributes["href"]);
    //     // print(links);
    //     print("finished");
    //   });
    // });
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getVideo();
    print(finishedVideo);
  }

  @override
  Widget build(BuildContext context) {
    print(finishedVideo);

    return Scaffold(
      body: Stack(children: [
        linkDone
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                
                // padding: EdgeInsets.all(20),
                child: WebView(
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: finishedVideo,
                    
                    // debuggingEnabled: true,
                    // onWebResourceError: (error) {
                    //   return print(error);
                    // },
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.complete(webViewController);
                    },
                    gestureNavigationEnabled: true,
                    initialMediaPlaybackPolicy:
                        AutoMediaPlaybackPolicy.always_allow,
                    // allowsInlineMediaPlayback: true,
                    onPageFinished: (finish) {
                      setState(() {
                        isLoading = false;
                      });
                    },
                    navigationDelegate: (NavigationRequest request) {
                      if (request.url.startsWith('http://hesgoal.com/')) {
                        print('blocking navigation to $request}');
                        return NavigationDecision.navigate;
                      } else {
                        print('allowing navigation to $request');
                        return NavigationDecision.prevent;
                      }
                    }),
              )
            : Container(
                child: Center(child: CircularProgressIndicator()),
              ),
        isLoading
            ? Container(
                //alignment: FractionalOffset.center,
                child: Center(child: CircularProgressIndicator()),
              )
            : Container(
                color: Colors.transparent,

                )
      ]),
    );
  }
}

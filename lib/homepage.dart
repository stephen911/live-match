import 'package:cached_network_image/cached_network_image.dart';
// import 'package:thememode_selector/thememode_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stedaplivematches/constants.dart';
import 'package:stedaplivematches/details.dart';
// import 'package:stedaplivematches/main.dart';
import 'package:stedaplivematches/model.dart';
// import 'package:thememode_selector/thememode_selector.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Future<List<String>> getData() async{
  //   http.Response response = await http.get("hesgoal.com");
  // }
  bool light = true;
  bool dataisthere = false;

  List<String> matches = [];
  List<String> teams = [];
  List<String> times = [];
  List<String> newtimes = [];

  List<String> icons = [];

  List<MatchTile> matchesList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    print("getting data...");
    var url = "http://hesgoal.com/";
    var response = await http.get(Uri.parse(url));

    dom.Document document = parser.parse(response.body);

    var fresh = document.getElementsByClassName("desc");
    // var timetag = document.getElementsByClassName("stars stars0");
    // print(timetag);

    var image = document.getElementsByClassName("icon");
    image.forEach((element) {
      var pic = element.innerHtml.toString();
      parser.parse(pic).getElementsByTagName("img").forEach((element) {
        // var links = element.innerHtml;
        // print(element.attributes["src"]);
        var src = element.attributes["src"];
        icons.add(src.toString());
        // matchesList.add(MatchTile(link: src.toString()));
        // print(element.text);
        // print(element.outerHtml);
        // print(element.attributes["href"]);
        // print(links);
      });
    });

    // timetag.forEach((element) {
    //   var inner = element.innerHtml.toString();
    //   if (inner.contains("p")) {
    //     print(inner);
    //     parser.parse(inner).getElementsByTagName("p").forEach((element) {
    //       var time = element.innerHtml;
    //       print(time);
    //       times.add(time);
    //     });
    //   }
    // print(inner);

    // });
    fresh.forEach((element) {
      var inner = element.innerHtml.toString();

      if (inner.contains("<p>")) {
        // print("Start");
        // print(inner);
        // print("end");
        parser.parse(inner).getElementsByTagName("p").forEach((element) {
          var time = element.innerHtml;
          // print("initial");
          // print(time);
          // print("done..");
          times.add(time);
          // print("added");
        });
      }
      // print(times);

      // for (var item in times) {
      //   print(item);
      //   if (checkPrime(){
      //     newtimes.add(item);
      //   }else{

      //   }

      // }
      // print(newtimes);

      // print(inner);
      if (inner.contains("link")) {
        // print(inner);
        parser.parse(inner).getElementsByTagName("a").forEach((element) {
          var links = element.innerHtml;
          // print(element.attributes["href"]);
          var link = element.attributes["href"];
          // print(element.text);
          // print(element.outerHtml);
          // print(element.attributes["href"]);
          // print(links);
          matches.add(links);
          teams.add(link.toString());
        });
      }
    });
    times.asMap().forEach((key, value) {
      // checkPrime(key);
      // print(key);
      // print(value);
      if (key.isOdd) {
        // print(key);
        newtimes.add(value);
        // print(value);
      } else {}
    });
    // final mainclass = document.getElementsByClassName("desc");
    // print("done.");
    // final mainclass1 = document.getElementsByClassName("desc");

    // print(document.getElementsByClassName("desc")[0].innerHtml);
    setState(() {
      // print(mainclass[0].getElementsByClassName("desc")[0].innerHtml);

      // final hrefs = mainclass1[0]
      //     .getElementsByClassName("link")[0]
      //     .getElementsByTagName("a")
      //     .where((element) => element.attributes.containsKey("href")).map((e) => e.attributes["href"]).toList();
      //     print(hrefs);
      // print(matches);
      // time = mainclass
      //     .map((elements) =>
      //         elements.getElementsByClassName("link")[1].innerHtml)
      //     .toList();
      // print(time);
      // print("good");
      dataisthere = true;
    });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
    
  void choiceAction(String choice) {
    if (choice == Constants.Savetoplaylist) {
      // print('Save To watch Later');
    }
    // else if (choice == Constants.Pause) {
    //   print('pause');
    // }
    else if (choice == Constants.Share) {
      // Snarck();
      // print('Share');
      //share(posturl, title, context);
    }
    
    else if (choice == Constants.Dontrecommend) {
      // print('Dont recommend Channel');
    } else if (choice == Constants.AboutUs) {
      showAboutDialog(context: context,
      applicationName: "Stedap Live Matches",
      applicationVersion: "1.0.0",
      applicationIcon: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(1.5),
                decoration: BoxDecoration(
                    color: Colors.red,
                    // shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.white, width: 2)),
                child: const Text(
                  "Stedap",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(1.5),
                decoration: BoxDecoration(
                    // shape: BoxShape.rectangle,
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 2)),
                child: const Text(
                  "Live",
                  style: TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(1.5),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    // shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.white, width: 2)),
                child: const Text(
                  "Matches",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
      applicationLegalese: "From A trusted developer(Stephen Dapaah)"
      );
      // print('About Us');
      // Navigator.push(
          // context, MaterialPageRoute(builder: (context) => AboutUs()));
    } else if (choice == Constants.Privacy) {
      // print('privacy');
      // const url = "http://www.stedap1.site.live";
      // launchUrl(url);
    }
  }
  
  bool loading = true;
  void _onRefresh() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    matches = [];
    teams = [];
    times = [];
    newtimes = [];
    icons = [];
    await getData();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

   void _onRefreshNoData() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      loading = false;
    });
    
    await getData();
    
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    // if(mounted)
    // setState(() {

    // });
    _refreshController.loadComplete();
  }

  
  // void _onLoadingNoData() async {
  //   // monitor network fetch
  //   await Future.delayed(Duration(milliseconds: 1000));
  //   // if failed,use loadFailed(),if no data return,use LoadNodata()
  //   // items.add((items.length+1).toString());
  //   // if(mounted)
  //   // setState(() {

  //   // });
  //   setState(() {
  //     loading = true;
  //   });
  //   _refreshController.loadComplete();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // iconTheme: IconThemeData(color: Colors.grey),
          actions: [
      //       ThemeModeSelector(
      //   height: 39,
      //   onChanged: (mode) {
      //     print('ThemeMode changed to $mode');
      //     ThemeModeManager.of(context)!.themeMode = mode;
      //   },
      // ),
            // GestureDetector(
            //   onTap: () {
            //     // AdaptiveTheme.of(context).toggleThemeMode();
            //     // changeTheme();
            //   },
            //   child: Icon(light ? Icons.brightness_2 : Icons.wb_sunny),
            // ),
            // IconButton(
            //     padding: EdgeInsets.all(4),
            //     // iconSize: 24,
            //     icon: const Icon(
            //       Icons.refresh,
            //     ), // color: Colors.grey,),
            //     onPressed: () {
                  //showInSnackBar("Page Refreshed");
                  // print("refresh");
                  // categories = getCategories();
                  // getNews(country);
                  //print(getNews(this.country));
                  // print(country);
                // }),
            PopupMenuButton<String>(
              //color: Colors.grey,
              onSelected: choiceAction,
              itemBuilder: (BuildContext context) {
                return Constants.choices.map((String choice) {
                  return PopupMenuItem<String>(
                    textStyle: TextStyle(
                        color: light ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
          centerTitle: false,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(1.5),
                decoration: BoxDecoration(
                    color: Colors.red,
                    // shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.white, width: 2)),
                child: const Text(
                  "Stedap",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(1.5),
                decoration: BoxDecoration(
                    // shape: BoxShape.rectangle,
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 2)),
                child: const Text(
                  "Live",
                  style: TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(1.5),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    // shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.white, width: 2)),
                child: const Text(
                  "Matches",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          // backgroundColor: Colors.transparent,
          elevation: 1.0,
        ),
        drawer: Drawer(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: light
                              ? Image.asset("assets/images/stedapnewsicon.png")
                                  .image
                              : Image.asset(
                                      "assets/images/stedapnewsicondark.png")
                                  .image,
                          fit: BoxFit.cover)),
                  child: const Opacity(
                    opacity: 0.0,
                    child: Text(
                      "Stedap Live Matches",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        //color: Colors.blue,
                      ),
                    ),
                  )),
              ListTile(
                title: const Text(
                  "Home",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                leading: const Icon(Icons.home, color: Colors.blueAccent),
                onTap: () {
                  // print("home");
                  Navigator.pop(context);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
              ListTile(
                  title: const Text(
                    "Send Us a mail",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  leading: const Icon(Icons.mail, color: Colors.blueAccent),
                  onTap: () {
                    // print("mail");
                    // mail();
                    Navigator.pop(context);
                  }),
              // ListTile(
              //     title: Text("Send Us a message"),
              //     leading: Icon(Icons.message, color: Colors.blueAccent),
              //     onTap: () {
              //       print("message");
              //       Navigator.pop(context);
              //     }),

              ListTile(
                  title: const Text(
                    "Visit Us",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  leading: const Icon(Icons.explore, color: Colors.blueAccent),
                  onTap: () {
                    // print("visit");
                    // mail();
                    Navigator.pop(context);
                    // const url = "http://www.stedap1.site.live";
                    // launchUrl(url);
                  }),
              ListTile(
                  title: const Text(
                    "Call Us",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  leading: const Icon(Icons.call, color: Colors.blueAccent),
                  onTap: () {
                    // print("Call Made");
                    // call();
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: const Text(
                    "Close",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  leading:
                      const Icon(Icons.exit_to_app, color: Colors.blueAccent),
                  onTap: () {
                    // print("add people");
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
        body: SafeArea(
            child: dataisthere
                ? SmartRefresher(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    enablePullDown: true,
                    enablePullUp: true,
                    header: WaterDropHeader(),
                    footer: CustomFooter(
                      builder: (BuildContext context, mode) {
                        Widget body;
                        if (mode == LoadStatus.idle) {
                          body = Text("pull up load");
                        } else if (mode == LoadStatus.loading) {
                          body = CupertinoActivityIndicator();
                        } else if (mode == LoadStatus.failed) {
                          body = Text("Load Failed!Click retry!");
                        } else if (mode == LoadStatus.canLoading) {
                          body = Text("release to load more");
                        } else {
                          body = Text("No more Data");
                        }
                        return Container(
                          height: 55.0,
                          child: Center(child: body),
                        );
                      },
                    ),
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: matches.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Details(link: teams[index])));
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Container(
                                height: MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? MediaQuery.of(context).size.height * 0.17
                                    : MediaQuery.of(context).size.height * 0.30,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        offset: Offset(0, 3),
                                        color: Colors.black26,
                                        blurRadius: 5),
                                  ],
                                ),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          fadeInCurve: Curves.bounceInOut,
                                          imageUrl: icons[index],
                                          imageBuilder:
                                              (context, imageProvider) {
                                            return new Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fill)),
                                            );
                                          },
                                          placeholder: (_, url) {
                                            return Center(
                                                widthFactor: 3.5,
                                                child:
                                                    new CupertinoActivityIndicator());
                                          },
                                          errorWidget: (context, url, error) {
                                            return Center(
                                                widthFactor: 1.5,
                                                child: new Icon(Icons.error,
                                                    color: Colors.grey));
                                          },
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.30,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.30,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(7.0),
                                            margin: EdgeInsets.all(4),
                                            // color: Colors.blue,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.60,
                                            child: Text(
                                              matches[index],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(5.0),
                                            margin: EdgeInsets.all(4),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.60,
                                            // color: Colors.blue,
                                            // ignore: unrelated_type_equality_checks
                                            child: Text(
                                              newtimes[index],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              softWrap: true,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                              ),
                            ),
                          );
                        }))
                : SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text("pull up load");
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = Text("Load Failed!Click retry!");
            }
            else if(mode == LoadStatus.canLoading){
                body = Text("release to load more");
            }
            else{
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefreshNoData,
        onLoading: _onLoading,
        child: loading ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Center(
                            child: Container(
                              // color: Colors.blue,
                                height:
                                    MediaQuery.of(context).size.height * 0.010)),
                        CupertinoActivityIndicator(radius: 20),
                      ]) : Container()
      )));
  }
}


// class Snarck extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Builder(builder: (context) => IconButton(icon: Icon(Icons.refresh), onPressed: (){
//       Scaffold.of(context).showSnackBar(
//         SnackBar(content: Text("refreshed"),)
//     );
//     },),);

//   }
// }
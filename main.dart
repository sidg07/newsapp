import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newspaper/Card.dart';
import 'package:newspaper/News.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,


      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black12),
        useMaterial3: true,



      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});






  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   List<String> lst=['https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=ce56a3efd8c446209825dc4a77b4867d','https://newsapi.org/v2/everything?domains=wsj.com&apiKey=b47e05ab6ac6442988ee332447525f75','https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=b47e05ab6ac6442988ee332447525f75','https://newsapi.org/v2/everything?q=tesla&from=2024-06-03&sortBy=publishedAt&apiKey=b47e05ab6ac6442988ee332447525f75',
   'https://newsapi.org/v2/everything?q=apple&from=2024-07-02&to=2024-07-02&sortBy=popularity&apiKey=b47e05ab6ac6442988ee332447525f75'];
   static String _element='https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=ce56a3efd8c446209825dc4a77b4867d';

   late Future<List<Article>?> postNews;

  @override
  void initState() {
    super.initState();
   postNews=getNews(_element);
  }

   Future<void> _fetchNews() async{
     final _random= new Random();
     setState(() {

       _element=lst[_random.nextInt(lst.length)];
       postNews=getNews(_element);

     });

   }



  static Future<List<Article>?>  getNews(String st) async{
    var url= Uri.parse(st);
    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final apiResponse = News.fromJson(jsonResponse);
      return apiResponse.articles;
    } else {
      throw Exception('Failed to load articles');
    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(


      extendBodyBehindAppBar: true,
      appBar: AppBar(centerTitle: true,title: Text("News",style: TextStyle(color: Colors.white),),backgroundColor: Colors.black.withOpacity(0.8)),
      body:RefreshIndicator(
        onRefresh: _fetchNews,
        child: Center(


            child: FutureBuilder<List<Article>?>(
              future: postNews,
              builder: (context,snapshot)
              {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // until data is fetched, show loader
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {

                  final news=snapshot.data!;
                  return ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      itemCount: news.length,
                      itemBuilder: (context,index){
                        final newsindex=news[index];
                        return NewsCard(title: newsindex?.title??'Hello', description: newsindex?.description ??'Hello' + '...', url: newsindex?.url ?? 'https://assets2.cbsnewsstatic.com/hub/i/r/2024/04/16/0fb75ad2-a909-44bb-87dc-86b9d51cbeb2/thumbnail/1280x720/949f3d3fef16f9c113e3048c6aef229f/247-key-channelthumbnail-1920x1080.jpg?v=a23cb4bdf4fa7f3cb72e5118085577f9',newsurl: newsindex.newsurl!,);


                  });
                } else {
                  // if no data, show simple Text
                  return const Text("No data available");
                }

              },
            ),


        ),
      )

    );


  }
}

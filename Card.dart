import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
class NewsCard extends StatefulWidget {
   String? title;
   String? description;
   String?  url  ;
   String? newsurl;
  NewsCard({Key? key ,    this.title,  this.description,  this.url,this.newsurl}) : super(key: key);

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {

  _launchURL() async {
    final Uri url = Uri.parse(widget.newsurl!);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }


  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      child: Card(
        color: Colors.black,
        child:Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image:  DecorationImage(image: NetworkImage(widget?.url??'https://assets2.cbsnewsstatic.com/hub/i/r/2024/04/16/0fb75ad2-a909-44bb-87dc-86b9d51cbeb2/thumbnail/1280x720/949f3d3fef16f9c113e3048c6aef229f/247-key-channelthumbnail-1920x1080.jpg?v=a23cb4bdf4fa7f3cb72e5118085577f9'),
                  fit:BoxFit.fill,),
                  borderRadius: BorderRadius.circular(15),
                  
                  
                  
                  
                  
              ),
              height: MediaQuery.of(context).size.height/2,
              width:MediaQuery.of(context).size.width,
              
              
             
              
                  
            ),
            Padding(
                padding: EdgeInsets.all(8.0),
              child:  Text(widget?.title??'Hello',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

            )
           ,
            Padding(
              padding: EdgeInsets.all(4.0),
              child:  Text(widget?.description??'Hello',style: TextStyle(color: Colors.grey),),

            )
          ],
        ),
            elevation: 2.0,
      ),
      onTap:_launchURL ,
    );
  }
}
//ce56a3efd8c446209825dc4a77b4867d
//https://newsapi.org/v2/everything?q=Apple&from=2024-06-29&sortBy=popularity&apiKey=API_KEY
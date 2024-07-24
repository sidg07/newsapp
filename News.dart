class Article{
  String? title;
  String? description;
  String? url;
  String? newsurl;
  Article({this.title,this.description,this.url,this.newsurl});

  Article.fromJson(Map<dynamic,dynamic> json)
  {
   title= json['title'];
    description=json['description'] ;

    url=json['urlToImage'];
    newsurl=json['url'];
  }

}


class News{
   String? status;
  int? totalresults;
  List<Article>? articles;

  News({this.status, this.totalresults,this.articles});

  News.fromJson(Map<dynamic,dynamic> json){
    var list = json['articles'] as List;
    List<Article> articlesList = list.map((i) => Article.fromJson(i)).toList();


    status=json['status'];
    totalresults=json['totalResults'];
    articles=articlesList;
  }



}
import 'dart:collection';

import 'package:fitness/screens/watch_video.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fitness/models/model_theme.dart';
import 'package:provider/provider.dart';


import '../widgets/navigation_bar.dart';


class Food_website extends StatefulWidget {
  const Food_website({Key? key}) : super(key: key);

  @override
  State<Food_website> createState() => _Food_websiteState();
}

class _Food_websiteState extends State<Food_website> {

  Future<void> _launchURL(String url) async{
    final Uri uri = Uri(scheme: "https", host:url);
    if (!await launchUrl(
        uri,
        mode: LaunchMode.externalApplication
    )){
      throw "Can not launch url";

    }
  }

  Future<void> _launchInWebViewWithoutJavaScript(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(enableJavaScript: false),
    )) {
      throw Exception('Could not launch $url');
    }
  }


  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: Column(
    //     children: [
    //       Text("How to Gain Muscle Mass - 8 Top Tips | Everyone Active"),
    //       ElevatedButton(
    //           onPressed: () async{
    //             // final url = "https://www.timeout.com/singapore/restaurants/the-best-restaurants-in-singapore-for-healthy-eating";
    //             final url = "https://www.everyoneactive.com/content-hub/gym/muscle-mass/";
    //             _launchInWebViewWithoutJavaScript(Uri.parse(url));
    //
    //             },
    //           child: Text("View Website"),)
    //     ],
    //   ),
    // );
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: websiteLink().allWebsiteUrlCount,
        itemBuilder: (context,index){
          final website_list = websiteLink().allWebsiteUrl;
          final website = website_list[index];
          return ListTile(
            title: Text(website.title),
            trailing: ElevatedButton(
              onPressed: () async{
                _launchInWebViewWithoutJavaScript(Uri.parse(website.url));
              }, child: Text("View Website"),
            ),
          );
        }
    );
  }
}

class websiteLink{

  UnmodifiableListView<website_info> get allWebsiteUrl {
    return UnmodifiableListView(_allWebsite);
  }

  int get allWebsiteUrlCount {
    return _allWebsite.length;
  }
  
  final List<website_info> _allWebsite =[
    website_info(title: "How to Gain Muscle Mass - 8 Top Tips | Everyone Active", url: "https://www.everyoneactive.com/content-hub/gym/muscle-mass/"),
    website_info(title: "The 18 Best Healthy Foods to Gain Weight Fast", url: "https://www.healthline.com/nutrition/18-foods-to-gain-weight")
    
  ];
}

class website_info {
  final String title;
  final url;


  website_info({
    required this.title,
    required this.url,
  });


}
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  // 最初に表示するWidget
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // アプリ名
      title: 'MyApp',
      theme: ThemeData(
        // テーマカラー
        primarySwatch: Colors.blue,
      ),
      // リスト一覧画面を表示
      home: WebBrowser(),
    );
  }
}

late WebViewController _controller;

// ボタンWidget
@override
class WebBrowser extends StatelessWidget {
  final controller = Completer<WebViewController>();
  final url = Uri.parse('https://zenn.dev/tsuruo/articles/56f3abbb132f90');
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // アプリ外
          TextButton(
            onPressed: () async {
              if (await canLaunchUrl(url)) {
                launchUrl(url, mode: LaunchMode.externalApplication);
              }
            },
            child: Text('ブラウザで開くtest'),
          ),
          // アプリ内
          TextButton(
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebView(
                            initialUrl:
                                "https://zenn.dev/tsuruo/articles/56f3abbb132f90",
                            javascriptMode: JavascriptMode.unrestricted,
                            onWebViewCreated: (WebViewController controller) {
                              _controller = controller;
                            },
                          )));
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Text('アプリ内で開く'),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'register_web_webview_stub.dart'
    if (dart.library.html) 'register_web_webview.dart';

void main() {
  registerWebViewWebImplementation();

  runApp(const MyApp());
}

late WebViewController _controller;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Embedded Timeline'),
        ),
        body: WebView(
          onWebViewCreated: (WebViewController webViewController) async {
            _controller = webViewController;
            _loadEmbeddedTimeline();
          },
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }

  void _loadEmbeddedTimeline() {
    String fileText = '''
    <a
      class="twitter-timeline"
      href="https://twitter.com/Twiterdev?ref_src=twsrc%5Etfw"
      >Tweets by Twiterdev</a
    >
    <script
      async
      src="https://platform.twitter.com/widgets.js"
      charset="utf-8"
    ></script>
''';

    _controller.loadUrl(
      Uri.dataFromString(
        fileText,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'),
      ).toString(),
    );
  }
}

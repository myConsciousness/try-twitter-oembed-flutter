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
<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Free AI for Beginners Course - Microsoft has put together an AI course for beginners, consisting of a 12 week, 24 lesson curriculum, available for free to all<a href="https://twitter.com/hashtag/AI?src=hash&amp;ref_src=twsrc%5Etfw">#AI</a> <a href="https://twitter.com/hashtag/course?src=hash&amp;ref_src=twsrc%5Etfw">#course</a> <a href="https://twitter.com/hashtag/KDnuggets?src=hash&amp;ref_src=twsrc%5Etfw">#KDnuggets</a> <a href="https://t.co/kxrEOQ07N5">https://t.co/kxrEOQ07N5</a> <a href="https://t.co/VJx2BkXkS9">pic.twitter.com/VJx2BkXkS9</a></p>&mdash; KDnuggets (@kdnuggets) <a href="https://twitter.com/kdnuggets/status/1556626379860475906?ref_src=twsrc%5Etfw">August 8, 2022</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inline_webview_macos/flutter_inline_webview_macos.dart';
import 'package:flutter_inline_webview_macos/flutter_inline_webview_macos/flutter_inline_webview_macos_controller.dart';
import 'package:flutter_inline_webview_macos/flutter_inline_webview_macos/types.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _hide = true;

  InlineWebViewMacOsController? _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin integration_tests_on_platform_view_macos app'),
        ),
        body: Center(
          child: Column(
            children: [
              if (Platform.isMacOS)
                _hide
                    ? Column(
                        children: [
                          InlineWebViewMacOs(
                            key: widget.key,
                            width: 500,
                            height: 300,
                            onWebViewCreated: (controller) {
                              _controller = controller;
                              // _controller!.loadUrl(
                              //     urlRequest: URLRequest(
                              //         url: Uri.parse("https://google.com")));
                            },
                          ),
                          TextButton(
                              onPressed: () async {
                                await _controller!
                                    .loadUrl(urlRequest: URLRequest(url: Uri.parse("https://youtube.com/")));
                              },
                              child: const Text('load:"youtube.com"')),
                          TextButton(
                              onPressed: () async {
                                await _controller!
                                    .loadUrl(urlRequest: URLRequest(url: Uri.parse("https://google.com")));
                              },
                              child: const Text('load:"google.com"')),
                          TextButton(
                              onPressed: () async {
                                final url = await _controller!.getUrl();
                                print(url);
                              },
                              child: const Text("getUrl")),
                        ],
                      )
                    : const SizedBox(),
              if (Platform.isIOS)
                SizedBox(
                    width: 300,
                    height: 500,
                    child: GestureDetector(
                      onVerticalDragStart: (event) {},
                      child: WebViewWidget(
                          controller: WebViewController()
                            ..loadRequest(Uri.parse("https://en.wikipedia.org/wiki/English_language"))),
                    )),
              TextButton(
                  onPressed: () {
                    setState(() {
                      _hide = !_hide;
                    });
                  },
                  child: Text("toggle hide ${!_hide}")),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YoutubeWebview extends StatefulWidget {
  final String url;

  const YoutubeWebview({super.key, required this.url});

  @override
  State<YoutubeWebview> createState() => _YoutubeWebviewState();
}

class _YoutubeWebviewState extends State<YoutubeWebview> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(_buildYoutubeHtml(widget.url));
  }

  String _buildYoutubeHtml(String url) {
    final videoId = _extractVideoId(url);
    if (videoId == null) {
      return '''
        <!DOCTYPE html>
        <html>
        <body style="margin:0;display:flex;align-items:center;justify-content:center;height:100vh;background:#242424;">
          <p style="color:#919191;font-family:sans-serif;">No video available</p>
        </body>
        </html>
      ''';
    }

    return '''
      <!DOCTYPE html>
      <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
          body { margin: 0; padding: 0; background: #000; }
          iframe { width: 100%; height: 100vh; border: none; }
        </style>
      </head>
      <body>
        <iframe 
          src="https://www.youtube-nocookie.com/embed/$videoId?rel=0&modestbranding=1" 
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
          allowfullscreen>
        </iframe>
      </body>
      </html>
    ''';
  }

  String? _extractVideoId(String url) {
    if (url.isEmpty) return null;
    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
    } else if (uri.pathSegments.contains('embed')) {
      final i = uri.pathSegments.indexOf('embed');
      if (i + 1 < uri.pathSegments.length) return uri.pathSegments[i + 1];
    } else {
      return uri.queryParameters['v'];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../modules/profile/data/models/requests/web_view_args.dart';
import '../theme/app_colors.dart';
import '../widgets/app_loading_widget.dart';
import 'custom_appbar.dart';
import 'custom_scaffold.dart';

class AppWebView extends StatefulWidget {
  final WebViewArgs args;

  const AppWebView({super.key, required this.args});

  @override
  State<AppWebView> createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
  late final WebViewController _webViewController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.navBarBackground)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) => setState(() => _isLoading = false),
        ),
      )
      ..loadRequest(Uri.parse(widget.args.url));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      background: Backgrounds.profileAndEdit,
      appBar: CustomAppBar(
        title: widget.args.title,
        showBackButton: true,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _webViewController),
          if (_isLoading)
            const AppLoadingWidget(
              size: 50,
              strokeWidth: 4,
            ),
        ],
      ),
    );
  }
}
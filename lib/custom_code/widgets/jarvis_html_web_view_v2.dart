// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom widgets

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class JarvisHtmlWebViewV2 extends StatefulWidget {
  const JarvisHtmlWebViewV2({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  State<JarvisHtmlWebViewV2> createState() => _JarvisHtmlWebViewV2State();
}

class _JarvisHtmlWebViewV2State extends State<JarvisHtmlWebViewV2> {
  // ВАЖНО: сюда вставь ВЕСЬ свой HTML (как у тебя уже есть),
  // ничего в нём менять не нужно.
  static const String _htmlContent = r'''<!DOCTYPE html>
<html lang="ru">
<head>
  <!-- весь твой CSS/HTML/JS из версии JARVIS -->
</head>
<body>
  <!-- весь остальной контент страницы -->
</body>
</html>''';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      child: InAppWebView(
        initialData: InAppWebViewInitialData(
          data: _htmlContent,
          // baseUrl даём, чтобы был нормальный origin для WebView
          baseUrl: WebUri('https://voicyfy.ru'),
        ),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true,
            mediaPlaybackRequiresUserGesture: false,
            transparentBackground: false,
          ),
          android: AndroidInAppWebViewOptions(
            useHybridComposition: true,
          ),
          ios: IOSInAppWebViewOptions(
            allowsInlineMediaPlayback: true,
          ),
        ),
        androidOnPermissionRequest: (controller, origin, resources) async {
          // Автоматически даём WebView доступ к микрофону/камере
          return PermissionRequestResponse(
            resources: resources,
            action: PermissionRequestResponseAction.GRANT,
          );
        },
        onConsoleMessage: (controller, consoleMessage) {
          debugPrint(
            'JARVIS [${consoleMessage.messageLevel}]: ${consoleMessage.message}',
          );
        },
      ),
    );
  }
}

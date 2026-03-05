// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

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
  static const String _htmlContent = r'''<!DOCTYPE html>
<!-- сюда вставь ВЕСЬ свой HTML из предыдущей версии без изменений -->
</html>''';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      child: InAppWebView(
        initialData: InAppWebViewInitialData(
          data: _htmlContent,
          // baseUrl можно добавить при необходимости:
          // baseUrl: WebUri('https://voicyfy.ru'),
        ),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true,
            transparentBackground: true,
            mediaPlaybackRequiresUserGesture: false,
          ),
          android: AndroidInAppWebViewOptions(
            useHybridComposition: true,
          ),
          ios: IOSInAppWebViewOptions(
            allowsInlineMediaPlayback: true,
          ),
        ),
        androidOnPermissionRequest: (controller, origin, resources) async {
          return PermissionRequestResponse(
            resources: resources,
            action: PermissionRequestResponseAction.GRANT,
          );
        },
      ),
    );
  }
}

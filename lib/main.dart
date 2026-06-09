import 'package:flutter/material.dart';
import 'package:flutter_qr/app.dart';
import 'package:flutter_qr/services/web_loader.dart';

void main() {
  runApp(const FlutterQrApp());
  // Dismiss the HTML splash once the first frame has been rendered.
  WidgetsBinding.instance.addPostFrameCallback((_) => removeWebLoader());
}

import 'dart:async';

import 'package:flutter/services.dart';

class FlutterEmailSender {
  static const MethodChannel _channel =
      const MethodChannel('flutter_email_sender');

  static Future<FlutterEmailSenderChannelComposeResult> send(Email mail) async {
    final result = await _channel.invokeMethod('send', mail.toJson());
    print("result: ${result}");
    print("result: ${result.toString()}");
    switch(result) {
      case "sent": return FlutterEmailSenderChannelComposeResult.sent;
      case "saved": return FlutterEmailSenderChannelComposeResult.saved;
      case "cancelled": return FlutterEmailSenderChannelComposeResult.cancelled;
      case "failed":
      default:
        return FlutterEmailSenderChannelComposeResult.failed;
    }
  }
}

class Email {
  final String subject;
  final List<String> recipients;
  final List<String> cc;
  final List<String> bcc;
  final String body;
  final List<String> attachmentPaths;
  final bool isHTML;
  Email({
    this.subject = '',
    this.recipients = const [],
    this.cc = const [],
    this.bcc = const [],
    this.body = '',
    this.attachmentPaths,
    this.isHTML = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'body': body,
      'recipients': recipients,
      'cc': cc,
      'bcc': bcc,
      'attachment_paths': attachmentPaths,
      'is_html': isHTML
    };
  }
}


enum FlutterEmailSenderChannelComposeResult {
  saved, sent, cancelled, failed
}

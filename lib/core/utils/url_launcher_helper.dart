import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../shared/widgets/toast/app_toast.dart';

class UrlLauncherHelper {
  /// Opens a URL in an in-app browser with brand colors
  static Future<void> openInAppBrowser({
    required String url,
    required BuildContext context,
  }) async {
    final uri = Uri.parse(url);

    try {
      await launchUrl(
        uri,
        mode: LaunchMode.inAppBrowserView,
        browserConfiguration: const BrowserConfiguration(showTitle: true),
      );
    } catch (e) {
      debugPrint('Error opening URL: $e');
      if (context.mounted) {
        AppToast.show(
          context: context,
          message: 'Failed to open the link',
          type: ToastificationType.error,
        );
      }
    }
  }

  /// Opens a URL in external browser
  static Future<void> openExternalBrowser(String url) async {
    final uri = Uri.parse(url);

    try {
      final canLaunch = await canLaunchUrl(uri);
      if (!canLaunch) {
        debugPrint('Could not launch URL: $url');
        return;
      }

      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Error opening external URL: $e');
    }
  }

  /// Opens phone dialer
  static Future<void> openDialer(String phoneNumber) async {
    final uri = Uri.parse('tel:$phoneNumber');
    try {
      await launchUrl(uri);
    } catch (e) {
      debugPrint('Error opening dialer: $e');
    }
  }

  /// Opens email client
  static Future<void> openEmail({
    required String email,
    String? subject,
    String? body,
  }) async {
    final subjectParam = subject != null
        ? '?subject=${Uri.encodeComponent(subject)}'
        : '';
    final bodyParam = body != null
        ? '${subject != null ? '&' : '?'}body=${Uri.encodeComponent(body)}'
        : '';
    final uri = Uri.parse('mailto:$email$subjectParam$bodyParam');

    try {
      await launchUrl(uri);
    } catch (e) {
      debugPrint('Error opening email: $e');
    }
  }

  /// Opens WhatsApp
  static Future<void> openWhatsApp({
    required String phoneNumber,
    String? message,
  }) async {
    final messageParam = message != null
        ? '?text=${Uri.encodeComponent(message)}'
        : '';
    final uri = Uri.parse('https://wa.me/$phoneNumber$messageParam');

    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Error opening WhatsApp: $e');
    }
  }
}

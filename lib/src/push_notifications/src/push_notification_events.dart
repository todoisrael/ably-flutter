import 'remote_message.dart';

typedef BackgroundMessageHandler = void Function(RemoteMessage message);

/// Push Notification events, such as message arriving or notification tap.
abstract class PushNotificationEvents {
  /// Configure if notifications are shown when the app is in the foreground.
  /// By default, no notifications are shown when the app is in the foreground.
  ///
  /// On messages with notifications trigger this method
  ///
  /// On iOS, the result will be passed to
  /// `userNotificationCenter:willPresentNotification` to decide how to show
  /// the notification while the app is in the foreground
  ///
  /// On Android, a local Android notification will be generated to create an
  /// identical notification as iOS.
  void setOnShowNotificationInForeground(
      Future<ForegroundNotificationConfiguration> Function(
              RemoteMessage message)
          callback);

  /// Called with [ApplicationState] available in [RemoteMessage]
  ///
  /// The notification has not yet been tapped.
  ///
  /// TODO: has the notification been seen?
  Stream<RemoteMessage> get onMessage;

  /// This method will be called when a notification or data message is
  /// received by the device.
  ///
  /// Warning: only set a top-level function or static callback function. This
  /// is a limitation of a Dart API being used internally, [PluginUtilities.getCallbackHandle](https://api.flutter.dev/flutter/dart-ui/PluginUtilities/getCallbackHandle.html)
  set onBackgroundMessage(BackgroundMessageHandler handler);

  // Set this to run heavy processing. This will be called the same time as
  // OnMessage on a separate Isolate, but with more runtime (execution time)
  // privileges. You should not duplicate work.
  // setOnMessageForHeavyProcessing(BackgroundMessageHandler handler);

  ///
  /// Notification Taps
  ///

  /// Called when notification is tapped while the app is already in the foreground or in the background
  ///
  /// Check the [ApplicationState] to know if the app was in foreground or background.
  Stream<RemoteMessage> get onNotificationTap;

  /// Future resolves to the notification which was tapped to cause the app
  /// to launch from from a terminated state. `null` if app was not launched
  /// from a notification.
  Future<RemoteMessage?> get notificationTapLaunchedAppFromTerminated;
}

class ForegroundNotificationConfiguration {
  // TODO by default, do not show the notification
}

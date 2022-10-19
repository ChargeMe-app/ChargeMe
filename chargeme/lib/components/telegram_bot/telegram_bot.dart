import 'dart:io';

import 'package:chargeme/components/analytics_manager/analytics_manager.dart';
import 'package:chargeme/components/telegram_bot/telegram_bot_token.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teledart/telegram.dart';

class TelegramBot {
  static TelegramBot shared = TelegramBot();
  Telegram? bot;
  AnalyticsManager? analyticsManager;

  TelegramBot() {
    initSetup();
  }

  void initSetup() async {
    bot = Telegram(telegramBotAPIKey);
  }

  void sendFeedback(String text, List<XFile> images) async {
    analyticsManager?.logEvent("feedback", params: {"photos": images.length});
    for (final image in images) {
      bot?.sendPhoto(nikitaChatId, File(image.path));
    }
    bot?.sendMessage(nikitaChatId, text);
  }
}

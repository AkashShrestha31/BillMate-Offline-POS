/// Display flag for each supported UI language code.
abstract final class AppLanguageFlag {
  static const _emojiByCode = <String, String>{
    'en': '🇬🇧',
    'ne': '🇳🇵',
    'hi': '🇮🇳',
    'es': '🇪🇸',
    'ar': '🇸🇦',
    'zh': '🇨🇳',
    'fr': '🇫🇷',
    'de': '🇩🇪',
    'ja': '🇯🇵',
    'pt': '🇵🇹',
    'ru': '🇷🇺',
    'bn': '🇧🇩',
    'th': '🇹🇭',
    'vi': '🇻🇳',
    'id': '🇮🇩',
    'ko': '🇰🇷',
    'it': '🇮🇹',
    'nl': '🇳🇱',
    'pl': '🇵🇱',
    'tr': '🇹🇷',
    'ms': '🇲🇾',
    'fil': '🇵🇭',
    'ur': '🇵🇰',
    'fa': '🇮🇷',
    'sw': '🇰🇪',
  };

  static String emoji(String languageCode) {
    final code = languageCode.trim().toLowerCase();
    return _emojiByCode[code] ?? '🌐';
  }
}

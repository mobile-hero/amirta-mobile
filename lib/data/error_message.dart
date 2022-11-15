import 'package:equatable/equatable.dart';

class ErrorMessage extends Equatable {
  final dynamic response;
  final Map<String, String?>? messages;
  final bool shouldRelogin;
  final String errorCode;

  static String keyMessage = "message";
  static String keyEmail = "email";
  static String keyPhone = "phone";
  static String keyPassword = "password";
  static String keyConfPassword = "conf_password";
  static String keyFirstName = "first_name";
  static String keyLastName = "last_name";
  static String keyPromoCode = "promo_code";
  static String keyCarType = "car_type";
  static String defaultMessage = "Terjadi kesalahan. Silakan kontak admin";
  static Map<String, String> defaultMessages = {keyMessage: defaultMessage};

  const ErrorMessage({
    this.response,
    this.messages,
    this.errorCode = "-",
    this.shouldRelogin = false,
  });

  static ErrorMessage init() {
    return const ErrorMessage(messages: {});
  }

  String? get first {
    if (isEmpty) {
      return null;
    }
    return messages?.values.first;
  }

  String? get message {
    if (messages?.containsKey(keyMessage) == false) {
      return null;
    }
    return messages?[keyMessage];
  }

  void add(String key, String message) {
    messages?[key] = message;
  }

  String? get(String key) {
    if (messages?.containsKey(key) == true) {
      return messages?[key];
    } else {
      return null;
    }
  }

  bool get isEmpty =>
      messages!.isEmpty == true ||
      messages!.values.every((element) => element?.isEmpty == true);

  bool get isNotEmpty => !isEmpty;

  ErrorMessage copyWith({
    dynamic response,
    Map<String, String>? messages,
  }) {
    return ErrorMessage(
      response: response ?? this.response,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props => [
        response,
        messages,
      ];
}

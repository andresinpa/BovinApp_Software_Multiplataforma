// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:http/http.dart' as http;

/// The `EmailService` class provides a static method `sendEmail` that sends an email using the EmailJS
/// API.
class EmailService {
  /// The `sendEmail` function sends an email using the EmailJS API with the provided name, email, and
  /// message.
  ///
  /// Args:
  ///   name (String): The name of the person sending the email.
  ///   email (String): The "email" parameter is a required parameter that represents the email address
  /// of the recipient to whom the email will be sent.
  ///   message (String): The "message" parameter is a required string that represents the content of
  /// the email message that will be sent. It can contain any text or HTML content that you want to
  /// include in the email.
  static Future<void> sendEmail({
    required String name,
    required String email,
    required String message,
  }) async {
    const serviceId = 'service_8zg5d6h';
    const templateId = 'template_df7zc0j';
    const userId = 'MzvTx11b0rcHUpIf3';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http:localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': name,
          'user_email': email,
          'user_message': message,
        },
      }),
    );
    // ignore: avoid_print
    print('Informacion enviada al correo');
  }
}

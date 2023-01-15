import 'package:meta/meta.dart';

@immutable
class ContactData{
  const ContactData({
    required this.contactName,
    required this.profilePicture,
    required this.status,
    required this.uid
  });
  final String contactName;
  final String profilePicture;
  final String status;
  final String uid;
}
import 'package:intl/intl.dart';  // You might need this for formatting dates if required.

// A base entity class with createdAt and updatedAt fields
class BaseEntity {
  DateTime? createdAt;
  DateTime? updatedAt;

  BaseEntity({this.createdAt, this.updatedAt});

  // Method called when the entity is created
  void onCreate() {
    final now = DateTime.now();
    createdAt = now;
    updatedAt = now;
  }

  // Method called when the entity is updated
  void onUpdate() {
    updatedAt = DateTime.now();
  }

  @override
  String toString() {
    return 'BaseEntity{createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}

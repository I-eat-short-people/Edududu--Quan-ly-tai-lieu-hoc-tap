import 'package:flutter/material.dart';

class StudyDocument {
  StudyDocument({
    required this.title,
    required this.subject,
    required this.type,
    required this.category,
    required this.pages,
    required this.updatedAt,
    required this.color,
    required this.icon,
    this.isSaved = false,
  });

  final String title;
  final String subject;
  final String type;
  final String category;
  final int pages;
  final String updatedAt;
  final Color color;
  final IconData icon;
  bool isSaved;

  String get categoryLabel => switch (category) {
        'exercise' => 'Bài tập',
        'reference' => 'Tham khảo',
        'exam' => 'Đề thi',
        'code' => 'Mã nguồn',
        _ => 'Bài giảng',
      };
}
import 'package:flutter/material.dart';

import '../models/study_document.dart';
import '../theme/app_theme.dart';

final List<StudyDocument> sampleDocuments = [
  StudyDocument(
    title: 'Tổng hợp chương 1-4',
    subject: 'Giải tích I',
    type: 'PDF',
    category: 'lecture',
    pages: 24,
    updatedAt: '2 giờ trước',
    color: AppColors.lecture,
    icon: Icons.functions_rounded,
    isSaved: true,
  ),
  StudyDocument(
    title: 'Các vấn đề tiên tiến trong phát triển ứng dụng di động',
    subject: 'CNTT',
    type: 'PDF',
    category: 'code',
    pages: 38,
    updatedAt: 'Hôm qua',
    color: AppColors.code,
    icon: Icons.code_rounded,
  ),
  StudyDocument(
    title: 'Flashcard từ vựng Unit 6',
    subject: 'Tiếng Anh',
    type: 'Bộ thẻ',
    category: 'exercise',
    pages: 42,
    updatedAt: 'Thứ 3',
    color: AppColors.exercise,
    icon: Icons.style_rounded,
    isSaved: true,
  ),
  StudyDocument(
    title: 'Đề cương ôn tập giữa kỳ',
    subject: 'Vật lý đại cương',
    type: 'DOCX',
    category: 'exam',
    pages: 12,
    updatedAt: '12/10/2026',
    color: AppColors.exam,
    icon: Icons.science_rounded,
  ),
  StudyDocument(
    title: 'Nguyên lý Hệ điều hành',
    subject: 'CNTT',
    type: 'Hình ảnh',
    category: 'reference',
    pages: 1,
    updatedAt: '10/10/2026',
    color: AppColors.reference,
    icon: Icons.account_tree_rounded,
  ),
];
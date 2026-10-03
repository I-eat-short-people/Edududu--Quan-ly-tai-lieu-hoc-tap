import 'package:flutter/material.dart';

import '../models/study_document.dart';
import '../theme/app_theme.dart';
import '../widgets/document_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    required this.documents,
    required this.onOpenLibrary,
    required this.onToggleSaved,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final List<StudyDocument> documents;
  final VoidCallback onOpenLibrary;
  final ValueChanged<StudyDocument> onToggleSaved;
  final ValueChanged<StudyDocument> onEdit;
  final ValueChanged<StudyDocument> onDelete;

  @override
  Widget build(BuildContext context) {
    final recent = documents.take(3).toList();
    final savedCount = documents.where((document) => document.isSaved).length;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 110),
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Thứ Bảy, 03 Tháng 10',
                    style: TextStyle(
                      color: AppColors.primaryDark,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Xin chào, Phước!',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.4,
                        ),
                  ),
                ],
              ),
            ),
            const CircleAvatar(
              radius: 23,
              backgroundColor: AppColors.primaryLight,
              child: Text(
                'P',
                style: TextStyle(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primaryDark,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'GÓC HỌC TẬP CỦA BẠN',
                      style: TextStyle(
                        color: AppColors.primaryLight,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 11),
                    Text(
                      '${documents.length} tài liệu',
                      style: const TextStyle(
                        color: AppColors.surface,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '$savedCount tài liệu được đánh dấu yêu thích',
                      style: const TextStyle(
                        color: AppColors.primaryLight,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.auto_stories_rounded,
                  color: AppColors.surface,
                  size: 31,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            _QuickStat(
              icon: Icons.folder_open_rounded,
              value: '${_subjectCount()} môn',
              label: 'Đang học',
              color: AppColors.lecture.withValues(alpha: 0.12),
            ),
            const SizedBox(width: 10),
            _QuickStat(
              icon: Icons.local_fire_department_rounded,
              value: '5 ngày',
              label: 'Chuỗi học tập',
              color: AppColors.exercise.withValues(alpha: 0.12),
            ),
          ],
        ),
        const SizedBox(height: 26),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Gần đây',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
            ),
            TextButton(
              onPressed: onOpenLibrary,
              child: const Text('Xem tất cả'),
            ),
          ],
        ),
        const SizedBox(height: 5),
        for (final document in recent)
          DocumentTile(
            document: document,
            onToggleSaved: () => onToggleSaved(document),
            onEdit: () => onEdit(document),
            onDelete: () => onDelete(document),
          ),
      ],
    );
  }

  int _subjectCount() => documents.map((document) => document.subject).toSet().length;
}

class _QuickStat extends StatelessWidget {
  const _QuickStat({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.textPrimary),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
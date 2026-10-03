import 'package:flutter/material.dart';

import '../models/study_document.dart';
import '../theme/app_theme.dart';
import '../widgets/document_tile.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({
    required this.documents,
    required this.onToggleSaved,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final List<StudyDocument> documents;
  final ValueChanged<StudyDocument> onToggleSaved;
  final ValueChanged<StudyDocument> onEdit;
  final ValueChanged<StudyDocument> onDelete;

  @override
  Widget build(BuildContext context) {
    final saved = documents.where((document) => document.isSaved).toList();
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 110),
      children: [
        const Text(
          'Đã lưu',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 5),
        Text(
          '${saved.length} tài liệu để xem lại sau',
          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 20),
        if (saved.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 70),
            child: Column(
              children: [
                Icon(Icons.bookmark_border_rounded, size: 42, color: AppColors.textSecondary),
                SizedBox(height: 12),
                Text('Chưa có tài liệu được lưu'),
              ],
            ),
          )
        else
          for (final document in saved)
            DocumentTile(
              document: document,
              onToggleSaved: () => onToggleSaved(document),
              onEdit: () => onEdit(document),
              onDelete: () => onDelete(document),
            ),
      ],
    );
  }
}
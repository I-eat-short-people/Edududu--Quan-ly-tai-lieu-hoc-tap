import 'package:flutter/material.dart';

import '../models/study_document.dart';
import '../theme/app_theme.dart';

class DocumentTile extends StatelessWidget {
  const DocumentTile({
    required this.document,
    required this.onToggleSaved,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final StudyDocument document;
  final VoidCallback onToggleSaved;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Mở tài liệu: ${document.title}')),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 54,
                  decoration: BoxDecoration(
                    color: document.color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(document.icon, color: document.color, size: 23),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        document.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${document.subject}  ·  ${document.categoryLabel}  ·  ${document.type}  ·  ${document.pages} trang',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        document.updatedAt,
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onToggleSaved,
                  tooltip: document.isSaved ? 'Bỏ lưu' : 'Lưu tài liệu',
                  visualDensity: VisualDensity.compact,
                  icon: Icon(
                    document.isSaved
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                    color: document.isSaved
                      ? AppColors.primary
                      : AppColors.textSecondary,
                  ),
                ),
                PopupMenuButton<_DocumentAction>(
                  key: ValueKey('document_actions_${document.title}'),
                  tooltip: 'Tùy chọn tài liệu',
                  onSelected: (action) {
                    if (action == _DocumentAction.edit) {
                      onEdit();
                    } else {
                      onDelete();
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: _DocumentAction.edit,
                      child: Row(
                        children: [
                          Icon(Icons.edit_outlined, size: 18),
                          SizedBox(width: 10),
                          Text('Sửa tài liệu'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: _DocumentAction.delete,
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_outline_rounded,
                            size: 18,
                            color: AppColors.error,
                          ),
                          SizedBox(width: 10),
                          Text('Xóa tài liệu'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum _DocumentAction { edit, delete }
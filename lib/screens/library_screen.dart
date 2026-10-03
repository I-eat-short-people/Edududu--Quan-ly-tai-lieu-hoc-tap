import 'package:flutter/material.dart';

import '../models/study_document.dart';
import '../theme/app_theme.dart';
import '../widgets/document_tile.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({
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
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final _searchController = TextEditingController();
  String _selectedSubject = 'Tất cả';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subjects = [
      'Tất cả',
      ...widget.documents.map((document) => document.subject).toSet(),
    ];
    final query = _searchController.text.trim().toLowerCase();
    final filtered = widget.documents.where((document) {
      final matchesSubject =
          _selectedSubject == 'Tất cả' || document.subject == _selectedSubject;
        final matchesQuery =
          '${document.title} ${document.subject} ${document.type}'
            .toLowerCase()
            .contains(query);
      return matchesSubject && matchesQuery;
    }).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 110),
      children: [
        const Text(
          'Thư viện',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 5),
        Text(
          '${widget.documents.length} tài liệu trong bộ sưu tập',
          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 19),
        TextField(
          controller: _searchController,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search_rounded),
            hintText: 'Tìm tên tài liệu hoặc môn học',
            suffixIcon: query.isEmpty
                ? null
                : IconButton(
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                    tooltip: 'Xóa tìm kiếm',
                    icon: const Icon(Icons.close_rounded),
                  ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: subjects.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final subject = subjects[index];
              return ChoiceChip(
                label: Text(subject),
                selected: _selectedSubject == subject,
                onSelected: (_) => setState(() => _selectedSubject = subject),
                showCheckmark: false,
                labelStyle: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: _selectedSubject == subject
                      ? AppColors.surface
                      : AppColors.textSecondary,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 18),
        if (filtered.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Center(child: Text('Không tìm thấy tài liệu phù hợp')),
          )
        else
          for (final document in filtered)
            DocumentTile(
              document: document,
              onToggleSaved: () => widget.onToggleSaved(document),
              onEdit: () => widget.onEdit(document),
              onDelete: () => widget.onDelete(document),
            ),
      ],
    );
  }
}
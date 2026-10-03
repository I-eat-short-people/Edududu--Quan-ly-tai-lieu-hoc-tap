import 'package:flutter/material.dart';

import '../models/study_document.dart';
import '../theme/app_theme.dart';

class AddDocumentSheet extends StatefulWidget {
  const AddDocumentSheet({this.document, super.key});

  final StudyDocument? document;

  @override
  State<AddDocumentSheet> createState() => _AddDocumentSheetState();
}

class _AddDocumentSheetState extends State<AddDocumentSheet> {
  late final TextEditingController _titleController;
  late final TextEditingController _subjectController;
  String _type = 'PDF';
  String _category = 'lecture';

  bool get _isEditing => widget.document != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.document?.title ?? '');
    _subjectController =
        TextEditingController(text: widget.document?.subject ?? '');
    _type = widget.document?.type ?? 'PDF';
    _category = widget.document?.category ?? 'lecture';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  void _submit() {
    final title = _titleController.text.trim();
    final subject = _subjectController.text.trim();
    if (title.isEmpty || subject.isEmpty) return;
    Navigator.of(context).pop(
      StudyDocument(
        title: title,
        subject: subject,
        type: _type,
        category: _category,
        pages: widget.document?.pages ?? 1,
        updatedAt: _isEditing ? 'Vừa chỉnh sửa' : 'Vừa thêm',
        color: AppColors.category(_category),
        icon: _iconForType(_type),
        isSaved: widget.document?.isSaved ?? false,
      ),
    );
  }

  IconData _iconForType(String type) {
    if (type == 'Bộ thẻ') return Icons.style_rounded;
    if (type == 'Hình ảnh') return Icons.image_rounded;
    if (type == 'DOCX') return Icons.article_rounded;
    return Icons.description_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 20 + bottomInset),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              _isEditing ? 'Chỉnh sửa tài liệu' : 'Thêm tài liệu',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: _titleController,
              autofocus: true,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Tên tài liệu'),
            ),
            const SizedBox(height: 11),
            TextField(
              controller: _subjectController,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
              decoration: const InputDecoration(labelText: 'Môn học'),
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              initialValue: _category,
              decoration: const InputDecoration(labelText: 'Nhóm tài liệu'),
              items: const [
                DropdownMenuItem(value: 'lecture', child: Text('Bài giảng')),
                DropdownMenuItem(value: 'exercise', child: Text('Bài tập')),
                DropdownMenuItem(value: 'reference', child: Text('Tham khảo')),
                DropdownMenuItem(value: 'exam', child: Text('Đề thi')),
                DropdownMenuItem(value: 'code', child: Text('Mã nguồn')),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _category = value);
              },
            ),
            const SizedBox(height: 14),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'PDF', label: Text('PDF')),
                ButtonSegment(value: 'DOCX', label: Text('DOCX')),
                ButtonSegment(value: 'Hình ảnh', label: Text('Ảnh')),
                ButtonSegment(value: 'Bộ thẻ', label: Text('Bộ thẻ')),
              ],
              selected: {_type},
              onSelectionChanged: (selection) => setState(() => _type = selection.first),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _submit,
                icon: Icon(_isEditing ? Icons.check_rounded : Icons.add_rounded),
                label: Text(
                  _isEditing ? 'Lưu thay đổi' : 'Thêm vào thư viện',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'data/sample_documents.dart';
import 'models/study_document.dart';
import 'screens/home_screen.dart';
import 'screens/library_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/saved_screen.dart';
import 'theme/app_theme.dart';
import 'widgets/add_document_sheet.dart';

void main() => runApp(const HocLieuApp());

class HocLieuApp extends StatelessWidget {
  const HocLieuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edududu - Quản lý tài liệu học tập',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;
  final List<StudyDocument> _documents = sampleDocuments;

  void _toggleSaved(StudyDocument document) {
    setState(() => document.isSaved = !document.isSaved);
  }

  Future<void> _addDocument() async {
    final document = await showModalBottomSheet<StudyDocument>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const AddDocumentSheet(),
    );
    if (document != null && mounted) {
      setState(() => _documents.insert(0, document));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã thêm tài liệu vào thư viện')),
      );
    }
  }

  Future<void> _editDocument(StudyDocument document) async {
    final updatedDocument = await showModalBottomSheet<StudyDocument>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddDocumentSheet(document: document),
    );
    if (updatedDocument == null || !mounted) return;

    final index = _documents.indexOf(document);
    if (index == -1) return;
    setState(() => _documents[index] = updatedDocument);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã cập nhật tài liệu')),
    );
  }

  Future<void> _deleteDocument(StudyDocument document) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa tài liệu?'),
        content: Text('“${document.title}” sẽ bị xóa khỏi thư viện.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Hủy'),
          ),
          FilledButton.tonal(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
    if (shouldDelete != true || !mounted) return;

    setState(() => _documents.remove(document));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã xóa tài liệu')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(
        documents: _documents,
        onOpenLibrary: () => setState(() => _selectedIndex = 1),
        onToggleSaved: _toggleSaved,
        onEdit: _editDocument,
        onDelete: _deleteDocument,
      ),
      LibraryScreen(
        documents: _documents,
        onToggleSaved: _toggleSaved,
        onEdit: _editDocument,
        onDelete: _deleteDocument,
      ),
      SavedScreen(
        documents: _documents,
        onToggleSaved: _toggleSaved,
        onEdit: _editDocument,
        onDelete: _deleteDocument,
      ),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 920),
            child: IndexedStack(index: _selectedIndex, children: pages),
          ),
        ),
      ),
      floatingActionButton: _selectedIndex == 3
          ? null
          : FloatingActionButton(
            tooltip: 'Thêm tài liệu',
              onPressed: _addDocument,
            child: const Icon(Icons.add_rounded),
            ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.space_dashboard_outlined),
            selectedIcon: Icon(Icons.space_dashboard_rounded),
            label: 'Tổng quan',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_stories_outlined),
            selectedIcon: Icon(Icons.auto_stories_rounded),
            label: 'Thư viện',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border_rounded),
            selectedIcon: Icon(Icons.bookmark_rounded),
            label: 'Đã lưu',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Cá nhân',
          ),
        ],
      ),
    );
  }
}

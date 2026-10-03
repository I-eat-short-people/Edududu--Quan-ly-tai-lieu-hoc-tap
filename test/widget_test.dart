import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hoc_lieu/main.dart';

void main() {
  testWidgets('dashboard opens and library navigation works', (tester) async {
    await tester.pumpWidget(const HocLieuApp());

    expect(find.text('Xin chào, Phước!'), findsOneWidget);
    expect(find.text('5 tài liệu'), findsOneWidget);

    await tester.tap(find.text('Thư viện').last);
    await tester.pumpAndSettle();

    expect(find.text('Tìm tên tài liệu hoặc môn học'), findsOneWidget);
    expect(find.text('Tổng hợp chương 1-4'), findsOneWidget);
  });

  testWidgets('a document can be added to the library', (tester) async {
    await tester.pumpWidget(const HocLieuApp());

    await tester.tap(find.byTooltip('Thêm tài liệu'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(0), 'Ghi chú chương mới');
    await tester.enterText(find.byType(TextField).at(1), 'Sinh học');
    await tester.tap(find.text('Thêm vào thư viện'));
    await tester.pumpAndSettle();

    expect(find.text('Đã thêm tài liệu vào thư viện'), findsOneWidget);
    await tester.tap(find.text('Thư viện').last);
    await tester.pumpAndSettle();
    expect(find.text('Ghi chú chương mới'), findsOneWidget);
  });

  testWidgets('library search matches document subjects', (tester) async {
    await tester.pumpWidget(const HocLieuApp());
    await tester.tap(find.text('Thư viện').last);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, 'CNTT');
    await tester.pumpAndSettle();

    expect(find.text('Các vấn đề tiên tiến trong phát triển ứng dụng di động'), findsOneWidget);
    expect(find.text('Nguyên lý Hệ điều hành'), findsOneWidget);
    expect(find.text('Flashcard từ vựng Unit 6'), findsNothing);
  });

  testWidgets('a document can be edited', (tester) async {
    await tester.pumpWidget(const HocLieuApp());
    await tester.tap(find.text('Thư viện').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('document_actions_Tổng hợp chương 1-4')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sửa tài liệu'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, 'Giải tích - bản cập nhật');
    await tester.tap(find.text('Lưu thay đổi'));
    await tester.pumpAndSettle();

    expect(find.text('Giải tích - bản cập nhật'), findsOneWidget);
    expect(find.text('Tổng hợp chương 1-4'), findsNothing);
  });

  testWidgets('a document can be deleted after confirmation', (tester) async {
    await tester.pumpWidget(const HocLieuApp());
    await tester.tap(find.text('Thư viện').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('document_actions_Tổng hợp chương 1-4')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Xóa tài liệu'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Xóa'));
    await tester.pumpAndSettle();

    expect(find.text('Tổng hợp chương 1-4'), findsNothing);
    expect(find.text('Đã xóa tài liệu'), findsOneWidget);
  });
}

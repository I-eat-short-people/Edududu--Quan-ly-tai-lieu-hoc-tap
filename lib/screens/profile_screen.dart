import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
      children: [
        const Text(
          'Cá nhân',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 22),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Row(
            children: [
              CircleAvatar(
                radius: 29,
                backgroundColor: AppColors.primaryLight,
                child: Text(
                  'P',
                  style: TextStyle(
                    color: AppColors.primaryDark,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Phạm Văn Phước', style: TextStyle(fontWeight: FontWeight.w800)),
                  SizedBox(height: 4),
                  Text('Sinh viên · năm 4', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                ],
              ),
              Spacer(),
              Icon(Icons.edit_outlined, size: 19, color: AppColors.primary),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text('THIẾT LẬP', style: _SectionLabel.style),
        const SizedBox(height: 8),
        _ProfileOption(
          icon: Icons.school_outlined,
          title: 'Môn học của tôi',
          subtitle: 'Quản lý danh sách môn học',
        ),
        _ProfileOption(
          icon: Icons.notifications_none_rounded,
          title: 'Nhắc nhở học tập',
          subtitle: 'Lịch nhắc và mục tiêu hằng ngày',
        ),
        _ProfileOption(
          icon: Icons.cloud_outlined,
          title: 'Sao lưu dữ liệu',
          subtitle: 'Đồng bộ tài liệu của bạn',
        ),
        const SizedBox(height: 24),
        const Text('ỨNG DỤNG', style: _SectionLabel.style),
        const SizedBox(height: 8),
        _ProfileOption(
          icon: Icons.info_outline_rounded,
          title: 'Giới thiệu Edududu',
          subtitle: 'Phiên bản 1.0.0',
        ),
      ],
    );
  }
}

class _SectionLabel {
  static const style = TextStyle(
    color: AppColors.primaryDark,
    fontSize: 10,
    fontWeight: FontWeight.w800,
  );
}

class _ProfileOption extends StatelessWidget {
  const _ProfileOption({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 3),
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 11)),
      trailing: const Icon(Icons.chevron_right_rounded, size: 20),
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$title sẽ sớm khả dụng')),
      ),
    );
  }
}
# Edududu- Quản lý tài liệu học tập

Ứng dụng flutter được xây dựng dựa trên nguyên lý cấu trúc của Cashew- Expense Tracker phiên bản mã nguồn mở ở github

Họ tên sinh viên: Phạm Văn Phước
MSV: 2251172456

## 📋 Danh sách Chức năng (Functional Requirements)

| Mã | Chức năng | Hành vi |
| :--- | :--- | :--- |
| **FR-01** | Xem tổng quan | Hiển thị tổng số tài liệu, số đã lưu, số môn và một số tài liệu gần đây. |
| **FR-02** | Xem thư viện | Liệt kê tài liệu; lọc theo môn học và tìm theo tên, môn hoặc loại tệp (`library_screen.dart`). |
| **FR-03** | Thêm tài liệu | Nhập tên, môn, nhóm học liệu và loại tệp. Tên và môn là bắt buộc; tài liệu mới mặc định có một trang. |
| **FR-04** | Sửa tài liệu | Nạp thông tin hiện tại vào biểu mẫu; cập nhật tài liệu sau khi lưu. |
| **FR-05** | Xóa tài liệu | Yêu cầu xác nhận trước khi xóa. |
| **FR-06** | Đánh dấu đã lưu | Bật/tắt trạng thái lưu; mục Đã lưu phản ánh cùng danh sách tài liệu. |
| **FR-07** | Điều hướng | Chuyển giữa Tổng quan, Thư viện, Đã lưu và Cá nhân. Màn Cá nhân hiện chủ yếu là giao diện; các mục thiết lập chưa thao tác dữ liệu. |



## 📊 Sơ đồ Luồng Dữ liệu Chi tiết (DFD)

```mermaid
flowchart LR
    U([Sinh viên])

    P1((1.0 Xem tổng quan))
    P2((2.0 Quản lý tài liệu))
    P3((3.0 Tìm kiếm và lọc))
    P4((4.0 Quản lý tài liệu đã lưu))
    P5((5.0 Xem cá nhân))

    D1[(D1 Danh sách tài liệu trong bộ nhớ)]

    U -->|Mở trang tổng quan| P1
    P1 -->|Yêu cầu danh sách| D1
    D1 -->|Tài liệu và trạng thái lưu| P1
    P1 -->|Thống kê và tài liệu gần đây| U

    U -->|Thông tin tài liệu hoặc yêu cầu xóa| P2
    P2 -->|Thêm, cập nhật hoặc xóa| D1
    D1 -->|Kết quả cập nhật| P2
    P2 -->|Thông báo thành công hoặc yêu cầu xác nhận| U

    U -->|Từ khóa và môn học được chọn| P3
    P3 -->|Đọc danh sách| D1
    D1 -->|Các tài liệu phù hợp| P3
    P3 -->|Kết quả tìm kiếm/lọc| U

    U -->|Bật hoặc tắt đánh dấu lưu| P4
    P4 -->|Cập nhật trạng thái isSaved| D1
    D1 -->|Các tài liệu đã lưu| P4
    P4 -->|Danh sách đã lưu| U

    U -->|Mở trang cá nhân| P5
    P5 -->|Thông tin hồ sơ và thiết lập tĩnh| U
    U -->|Mở trang cá nhân| P5
    P5 -->|Thông tin hồ sơ và thiết lập tĩnh| U


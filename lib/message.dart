import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          //common
          "please_wait": "Please wait",
          "create_success": "Create success",
          'update_success': "Update success",
          'admin': "Admin",
          'leave': "Leave",
          'remove': "Remove",
          'confirm': 'Confirm',
          'in_list': "In list",
          'no_have_tasks': "No have task",
          'please_check_your': "Please check your mail and verify email",

          // walk through page
          'sign_in': 'Log in',
          'sign_up': 'Sign up',
          'title_walk_through_1': "Get more done with Trellis",
          'description_walk_through_1':
              'Plan, track, and organzine pretty much\nanything with anyone.',
          'title_walk_through_2': "Get organized",
          'description_walk_through_2':
              'Make a Trellis board to organize\nanything with anyone.',
          'title_walk_through_3': "Add details",
          'description_walk_through_3':
              'Open cards to add pictures,\nchecklists, and more.',
          'title_walk_through_4': "Temp up",
          'description_walk_through_4':
              'Invite people to join your board,\nall for fre.',
          'termsCondition1': 'By creating an account, you agree to our ',
          'termsCondition2': 'Terms of\nService ',
          'termsCondition3': 'and ',
          'termsCondition4': 'Privacy Policy ',
          'termsCondition5': '',
          'signUpEmailLabel': 'Sign up with email',
          'signInEmailLabel': 'Sign in with email',
          'signUpGoogleLabel': 'Sign up with google',
          'signInGoogleLabel': 'Sign in with google',

          // sign up page

          'register_account': 'Register account',
          'first_name': 'First name',
          'last_name': 'Last name',
          'please_enter_first_name': 'Please enter first name',
          'please_enter_last_name': 'Please enter last name',
          'please_enter_email': "Please enter email",
          'email_invalid': 'Email invalid',
          'password': 'Password',
          "please_enter_password": "Please enter password",
          "password_at_least": "Password must have at least 6 characters",
          "please_re-enter_password": "Please re-enter password",
          'password_incorrect': 'Password incorrect',
          're-enter_password': 'Re-enter password',
          'already_account': 'Do you already have a account? ',

          // sign in page
          'forgot_password': 'Forgot password? ',
          'no_already_account': 'Do you have not a account? ',
          'reset_password': "Reset password",

          // dashboard page
          "boards": "Boards",
          'board': 'Board',
          'home': "Home",
          'workspaces': 'Workspaces',
          'my_cards': 'My cards',
          'setting': 'Setting',
          'help': "Help!",
          'statistics': "Statistics",
          'log_out': 'Log out',
          'add_account': "Add account",
          'are_you_sure_logout': 'Are you sure want to logout? ',
          'logout_success': "Logout Success",
          'no': 'No',
          'yes': "Yes",
          'card': "Card",
          'workspace': 'Workspace',
          'do_not_have_workspace': "You don't have any workspace",

          // notification page
          'notifications': 'Notifications',
          'notifications_setting': "Notification setting",
          'all': "All",
          'me': 'Me',
          'comments': 'Comments',

          //  create board page
          'board_name': "Board name",
          'workspace': 'Workspace',
          'visibility': 'Visibility',
          'create_board': "Create board",
          'private': "Private",
          'public': "Public",
          "board_description": "Board description (Optional)",

          // create card page
          "add_card": "Add card",
          "start_date": 'Start date',
          'due_date': "Due day",
          'done': "DONE",
          'cancel': 'CANCEL',
          'set_reminder': 'Set reminder',
          'reminder_desc':
              'Reminders are only sent to members and watchers of the card',
          'card_name': 'Card name',
          'desc': 'Description',
          'at_time_of_due_date': 'At time of due date',
          'today': "Today",
          'tomorrow': 'Tomorrow',
          'pick_a_date': 'Pick a date',
          'morning': "Morning",
          'afternoon': "Afternoon",
          'evening': "Evening",
          'night': "Night",
          'pick_a_time': "Pick a time",
          'list': "List",
          'minutes_ago': "minutes ago",
          'hours_ago': "hours ago",
          'days_ago': "days ago",
          'attachment': "Attachment",
          'attach_from': 'Attach from...',
          'camera': "Camera",
          'file': 'File',
          'attach_link': "Attach a link",
          'the_due_date_must_be_before_the_start_date':
              'The due date must be before the start date',
          'into_the': 'into the',

          // settings page
          'settings': 'Settings',
          'language': "Language",
          'select_language': 'Select language',

          // end drawer
          'about_this_board': 'About this board',
          'members': 'Members',
          'activity': 'Activity',
          'power_ups': 'Powers-Ups',
          'archived_cards': 'Archived cards',
          'archived_list': 'Archived list',
          'board_settings': 'Board settings',
          'star_board': 'Star board',
          'pin_to_home_screen': 'Pin to home screen',
          'copy_board': 'Copy board',
          'synced': 'Synced',

          // create workspace page
          "create_workspace": "Create workspace",
          "update_workspace": "Update workspace",
          "workspace_name": 'Workspace name',
          "workspace_type": "Workspace Type",
          "select": "Select",
          "personnel": "Personnel",
          "small_business": "Small Business",
          "operating": "Operating",
          "education": "Education",
          "it": "Information technology",
          "other": "Other",
          "marketing": "Marketing",
          "workspace_description": "Workspace description (Optional)",

          // detail board page
          "move_list": "Move list",
          'edit_list_name': 'Edit list name',
          'add_list': 'Add list',
          'delete_list': "Delete list",
          'sort_by_created_desc': "Sort by date created(newest first)",
          'sort_by_created_asc': "Sort by date created(oldest first)",
          'sort_by_start_date': "Sort by start day",
          'sort_by_due_date': "Sort by due day",
          'choose_action': "Choose action",
          'confirm_complete': "Confirm complete",
          'delete_card': "Delete card",
          'rework': 'Rework',
          'are_you_sure_delete_this_card': "Are you sure delete this card ?",
          'complete': "Complete",
          'incomplete': "Incomplete",
          'to': 'to',

          // search board page
          'search': 'Search',
          'no_results_found': "No results found.",

          // EasyLoading message
          'error': "Something went wrong",
          'sign_up_success': 'Sign up successful',

          // workspace menu page
          'workspace_menu': 'Workspace menu',
          'invite': 'Invite',
          'workspace_setting': "Workspace setting",

          // invite member page
          'add_members': 'Invite members',
          'add_user_to_workspace': 'Add users to the workspace',
          'add_user_to_board': 'Add users to the board',
          'user_not_found': "User not found",
          'add': "Add",
          'you_have_selected_this_user': "You have selected this user",

          // remove member page
          'remove_from_workspace': 'Remove from workspace',
          'admin_permission_explain':
              "Can view, create, edit Workspace boards and change settings for the Workspace",
          'would_you_live_to_leave': 'Would you like to leave this workspace?',
          'would_you_live_to_leave_board':
              "Would you like to leave this board?",

          // board menu page
          'board_menu': "Board menu",
          'board_setting': "Board setting",
          'background_color': "Background color",
          'delete_board': 'Delete board',
          'are_you_sure_delete_this_list': "Are you sure delete this list",
          'at': 'at',
          'are_you_sure_delete_this_board': "Are you sure delete this board? ",
          'only_admin_delete_board': "Only admin can delete this board",

          // update card page
          'edit_card_name': 'Edit name',
          'add_card_description': "Add card description...",
          'edit_card_description': "Edit description",
          'card_members': "Card members",
          'quick_actions': "Quick actions",
          'add_task': "Add task",
          'add_attachment': 'Add_attachment',
          'editing_task': 'Editing task',
          'delete': 'Delete',
          'label': 'Label',

          // edit lable page
          'edit_label': "Edit labels",
          'create_new_label': "CREATE NEW LABEL",
          'new_label': "New label",
          'label_name': "Label name",

          // my calendar page
          'my_calendar': "My calendar",
        },
        'vi_VN': {
          //common
          "please_wait": "Vui lòng đợi",
          "create_success": "Tạo thành công",
          'update_success': "Cập nhật thành công",
          'admin': "Người quản trị",
          'leave': "Rời khỏi",
          'remove': "Loại bỏ",
          'confirm': 'Xác nhận',
          'in_list': "Trong danh sách",
          'no_have_tasks': "Không có công việc nào",
          'please_check_your': "Vui lòng kiểm tra email và xác minh email",

          // walk through page
          'sign_in': 'Đăng nhập',
          'sign_up': 'Đăng ký',
          'title_walk_through_1': "Hoàn thành nhiều việc hơn với Trellis",
          'description_walk_through_1':
              'Lập kế hoạch, theo dõi và sắp xếp mọi thứ với\nbất kỳ ai',
          'title_walk_through_2': "Cùng sắp xếp thật ngăn nắp nào",
          'description_walk_through_2':
              'Tạo bảng Trellis để sắp xếp mọi\nthứ cùng mọi người',
          'title_walk_through_3': "Thêm chi tiết",
          'description_walk_through_3':
              'Mở thẻ để thêm hình ảnh , danh\nsách công việc và nhiều thứ nữa',
          'title_walk_through_4': "Lập nhóm",
          'description_walk_through_4':
              'Mời mọi người tham gia bảng của\nbạn, tất cả đều miễn phí',
          'termsCondition1': 'Bằng cách tạo tài khoản, bạn đồng ý với ',
          'termsCondition2': 'Điều khoản và dịch\nvụ ',
          'termsCondition3': 'và ',
          'termsCondition4': 'Chính sách riêng tư ',
          'termsCondition5': 'của chúng tôi ',
          'signUpEmailLabel': 'Đăng ký bằng email',
          'signInEmailLabel': 'Đăng nhập bằng email',
          'signUpGoogleLabel': 'Đăng ký bằng tài khoản google',
          'signInGoogleLabel': 'Đăng nhập bằng tài khoản google',

          // sign up page

          'register_account': 'Đăng ký tài khoản',
          'first_name': 'Họ',
          'last_name': 'Tên',
          'please_enter_first_name': 'Vui lòng nhập họ',
          'please_enter_last_name': 'Vui lòng nhập tên',
          'please_enter_email': "Vui lòng nhập email",
          'email_invalid': 'Email không hợp lệ',
          'password': 'Mật khẩu',
          "please_enter_password": "Vui lòng nhập mật khẩu",
          "password_at_least": "mật khẩu phải có ít nhất 6 kí từ",
          "please_re-enter_password": "Vui lòng nhập lại mật khẩu",
          'password_incorrect': 'Mật khẩu không khớp',
          're-enter_password': 'Nhập lại mật khẩu',
          'already_account': 'Bạn đã có tài khoản? ',

          // sign in page
          'forgot_password': 'Quên mật khẩu? ',
          'no_already_account': 'Bạn chưa có tài khoản? ',
          'reset_password': "Đặt lại mật khẩu",

          // dashboard page
          "boards": "Bảng",
          'board': 'Bảng',
          'home': "Trang chủ",
          'workspaces': 'Các không gian làm việc',
          'my_cards': 'Các thẻ của tôi',
          'setting': 'Cài đặt',
          'help': "Trợ giúp!",
          'statistics': "Thống kê",
          'log_out': 'Đăng xuất',
          'add_account': "Thêm tài khoản",
          'are_you_sure_logout': 'Bạn có chắc muốn đăng xuất? ',
          'logout_success': 'Đăng xuất thành công',
          'no': 'Không',
          'yes': 'Có',
          'card': "Thẻ",
          'workspace': 'Không gian làm việc',
          'do_not_have_workspace': 'Bạn không có không gian làm việc nào',

          // notification page
          'notifications': 'Thông báo',
          'notifications_setting': "Cài đặt thông báo",
          'all': "Tất cả",
          'me': 'Tôi',
          'comments': 'Bình luận',

          // create board page
          'board_name': "Tên bảng",
          'workspace': 'Không gian làm việc',
          'visibility': 'Quyền xem',
          'create_board': "Tạo bảng",
          'private': "Riêng tư",
          'public': "Công khai",
          'board_description': 'Mô tả bảng (Tùy chọn)',

          // create card page
          "add_card": "Thêm thẻ",
          "start_date": 'Ngày bắt đầu',
          'due_date': "Ngày hết hạn",
          'done': "HOÀN TẤT",
          'cancel': 'HỦY',
          'set_reminder': 'Thiết lập nhắc nhở',
          'reminder_desc':
              'Nhắc nhở chỉ được gửi đến các thành viên và người theo dõi thẻ',
          'card_name': 'Tên thẻ',
          'desc': 'Mô tả',
          'at_time_of_due_date': 'Vào thời điểm hết hạn',
          'today': "Hôm nay",
          'tomorrow': 'Ngày mai',
          'pick_a_date': 'Chọn một ngày',
          'morning': "Buổi sáng",
          'afternoon': "Buổi chiều",
          'evening': "Buổi tối",
          'night': "Đêm",
          'pick_a_time': "Chọn thời gian",
          'list': "Danh sách",
          'minutes_ago': "phút trước",
          'hours_ago': "giờ trước",
          'days_ago': "ngày trước",
          'attachment': "Tệp đính kèm",
          'attach_from': 'Đính kèm từ...',
          'camera': "Chụp ảnh",
          'file': 'Tệp',
          'attach_link': "Đính kèm liên kết",
          'the_due_date_must_be_before_the_start_date':
              "Ngày hết bạn phải trước ngày bắt đầu",
          'into_the': 'vào',

          // settings page
          'settings': 'Cài đặt',
          'language': "Ngôn ngữ",
          'select_language': 'Chọn ngôn ngữ',

          // end drawer
          'about_this_board': 'Về bảng này',
          'members': 'Thành viên',
          'activity': 'Hoạt động',
          'power_ups': 'Các tiện ích bổ sung',
          'archived_cards': 'Các thẻ đã lưu',
          'archived_list': 'Các danh sách đã lưu trữ',
          'board_settings': 'Thiết lập bảng',
          'star_board': 'Đánh dấu sao cho bảng',
          'pin_to_home_screen': 'Ghim ra màn hình trang chủ',
          'copy_board': 'Sao chép bảng',
          'synced': 'Đông bộ',

          // create workspace page
          "create_workspace": "Tạo không gian làm việc",
          'update_workspace': "Chỉnh sửa Không gian làm việc",
          "workspace_name": 'Tên không gian làm việc',
          "workspace_type": "Loại không gian làm việc",
          "select": "Chọn",
          "personnel": "Nhân sự",
          "small_business": "Doanh nghiệp nhỏ",
          "operating": "Điều hành",
          "education": "Giáo dục",
          "it": "Công nghệ thông tin",
          "other": "Khác",
          "workspace_description": "Mô tả không gian làm việc (Tùy chọn)",
          "marketing": "Marketing",

          // detail board page
          "move_list": "Di chuyển danh sách",
          'edit_list_name': 'Chỉnh sửa danh sách',
          'add_list': 'Thêm danh sách',
          'delete_list': "Xóa danh sách",
          'sort_by_created_desc': "Sắp xếp theo ngày tạo(mới nhất)",
          'sort_by_created_asc': "Sắp xếp theo ngày tạo(cũ nhất)",
          'sort_by_start_date': "Sắp xếp theo ngày bắt đầu",
          'sort_by_due_date': "Sắp xếp theo ngày hết hạn",
          'choose_action': "Chọn thao tác",
          'confirm_complete': "Xác nhận hoàn thành",
          'delete_card': "Xóa thẻ",
          'rework': "Làm lại",
          'are_you_sure_delete_this_card': "Bạn có chắc chắn xóa thẻ này ?",
          'complete': "Hoàn thành",
          'incomplete': "Chưa hoàn thành",
          'to': 'đến',

          // search board page
          'search': 'Tìm kiếm',
          'no_results_found': "Không có kết quả nào được tìm thấy.",

          // EasyLoading message
          'error': "Đã xảy ra lỗi",
          'sign_up_success': 'Đăng ký thành công',

          // workspace menu page
          'workspace_menu': "Menu không gian làm việc",
          'invite': 'Mời',
          'workspace_setting': "Chỉnh sửa Không gian làm việc",

          // invite member page
          'add_members': 'Mời các thành viên',
          'add_user_to_workspace': 'Thêm người dùng vào Không gian làm việc',
          'add_user_to_board': 'Thêm người dùng vào Bảng',
          'user_not_found': "Không tìm thấy người dùng",
          'add': "Thêm",
          'you_have_selected_this_user': "Bạn đã chọn người dùng này",

          // remove member page
          'remove_from_workspace': 'Gỡ khỏi Không gian làm việc',
          'admin_permission_explain':
              "Có thể xem, tạo và chỉnh sửa các bảng Không gian làm việc, cũng như thay đổi cài đặt cho Không gian làm viêc",
          'would_you_live_to_leave':
              "Bạn có muốn rời khỏi Không gian làm việc này?",
          'would_you_live_to_leave_board': "Bạn có muốn rời khỏi Bảng này?",

          // board menu page
          'board_menu': "Menu bảng",
          'board_setting': "Chỉnh sửa bảng",
          'background_color': "Màu nền",
          'delete_board': 'Xóa bảng',
          'are_you_sure_delete_this_list':
              "Bạn có chắc chắn xóa danh sách này không? ",
          'at': "lúc",
          'are_you_sure_delete_this_board':
              "Bạn có chắc chắc xóa bảng này không? ",
          'only_admin_delete_board':
              "Chỉ có thể người quản trị mới có thể xóa bảng này",

          // update card page
          'edit_card_name': 'Chỉnh sửa tên',
          'add_card_description': "Thêm mô tả thẻ...",
          'edit_card_description': "Chỉnh sửa mô tả",
          'card_members': "Thành viên thẻ",
          'quick_actions': "Các hành động nhanh",
          'add_task': "Thêm công việc",
          'add_attachment': 'Thêm tệp đính kèm',
          'editing_task': 'Chỉnh sửa công việc',
          'delete': 'Xóa',
          'label': 'Nhãn',

          // edit lable page
          'edit_label': "Chỉnh sửa nhãn",
          'create_new_label': "TẠO MỚI NHÃN",
          'new_label': "Nhãn mới",
          'label_name': "Tên nhãn",

          // my calendar page
          'my_calendar': "Lịch của tôi",
        }
      };
}

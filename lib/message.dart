import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
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
          'log_out': 'Log out',
          'add_account': "Add account",
          'are_you_sure_logout': 'Are you sure want to logout? ',
          'no': 'No',
          'yes': "Yes",
          'card': "Card",
          'workspace': 'Workspace',

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
          "workspace_name": 'Workspace name',

          // detail board page
          "move_list": "Move list",
          'edit_list_name': 'Edit list name',
          'add_list': 'Add list',

          // search board page
          'search': 'Search',
        },
        'vi_VN': {
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
          'log_out': 'Đăng xuất',
          'add_account': "Thêm tài khoản",
          'are_you_sure_logout': 'Bạn có chắc muốn đăng xuất? ',
          'no': 'Không',
          'yes': 'Có',
          'card': "Thẻ",
          'workspace': 'Không gian làm việc',

          // notification page
          'notifications': 'Thông báo',
          'notifications_setting': "Cài đặt thông báo",
          'all': "Tất cả",
          'me': 'Tôi',
          'comments': 'Bình luận',

          // create add board page
          'board_name': "Tên bảng",
          'workspace': 'Không gian làm việc',
          'visibility': 'Quyền xem',
          'create_board': "Tạo bảng",
          'private': "Riêng tư",
          'public': "Công khai",

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
          "workspace_name": 'Tên không gian làm việc',

          // detail board page
          "move_list": "Di chuyển danh sách",
          'edit_list_name': 'Chỉnh sửa danh sách',
          'add_list': 'Thêm danh sách',

          // search board page
          'search': 'Tìm kiếm',
        }
      };
}

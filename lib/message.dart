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
          'loading': "Loading...",

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
          'gallery': "Gallery",
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
          'delete_workspace': "Delete workspace",
          'are_you_sure_delete_this_workspace':
              "Are you sure delete this workspace?",

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
          'image': "Images",
          'download_image': "Download image",
          'download_image_success': "Download image success",
          'open': "Open",
          'failed': "Failed",
          'canceled': 'Canceled',
          'pending': "Pending",

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
          "please_wait": "Vui l??ng ?????i",
          "create_success": "T???o th??nh c??ng",
          'update_success': "C???p nh???t th??nh c??ng",
          'admin': "Ng?????i qu???n tr???",
          'leave': "R???i kh???i",
          'remove': "Lo???i b???",
          'confirm': 'X??c nh???n',
          'in_list': "Trong danh s??ch",
          'no_have_tasks': "Kh??ng c?? c??ng vi???c n??o",
          'please_check_your': "Vui l??ng ki???m tra email v?? x??c minh email",
          'loading': "??ang t???i...",

          // walk through page
          'sign_in': '????ng nh???p',
          'sign_up': '????ng k??',
          'title_walk_through_1': "Ho??n th??nh nhi???u vi???c h??n v???i Trellis",
          'description_walk_through_1':
              'L???p k??? ho???ch, theo d??i v?? s???p x???p m???i th??? v???i\nb???t k??? ai',
          'title_walk_through_2': "C??ng s???p x???p th???t ng??n n???p n??o",
          'description_walk_through_2':
              'T???o b???ng Trellis ????? s???p x???p m???i\nth??? c??ng m???i ng?????i',
          'title_walk_through_3': "Th??m chi ti???t",
          'description_walk_through_3':
              'M??? th??? ????? th??m h??nh ???nh , danh\ns??ch c??ng vi???c v?? nhi???u th??? n???a',
          'title_walk_through_4': "L???p nh??m",
          'description_walk_through_4':
              'M???i m???i ng?????i tham gia b???ng c???a\nb???n, t???t c??? ?????u mi???n ph??',
          'termsCondition1': 'B???ng c??ch t???o t??i kho???n, b???n ?????ng ?? v???i ',
          'termsCondition2': '??i???u kho???n v?? d???ch\nv??? ',
          'termsCondition3': 'v?? ',
          'termsCondition4': 'Ch??nh s??ch ri??ng t?? ',
          'termsCondition5': 'c???a ch??ng t??i ',
          'signUpEmailLabel': '????ng k?? b???ng email',
          'signInEmailLabel': '????ng nh???p b???ng email',
          'signUpGoogleLabel': '????ng k?? b???ng t??i kho???n google',
          'signInGoogleLabel': '????ng nh???p b???ng t??i kho???n google',

          // sign up page

          'register_account': '????ng k?? t??i kho???n',
          'first_name': 'H???',
          'last_name': 'T??n',
          'please_enter_first_name': 'Vui l??ng nh???p h???',
          'please_enter_last_name': 'Vui l??ng nh???p t??n',
          'please_enter_email': "Vui l??ng nh???p email",
          'email_invalid': 'Email kh??ng h???p l???',
          'password': 'M???t kh???u',
          "please_enter_password": "Vui l??ng nh???p m???t kh???u",
          "password_at_least": "m???t kh???u ph???i c?? ??t nh???t 6 k?? t???",
          "please_re-enter_password": "Vui l??ng nh???p l???i m???t kh???u",
          'password_incorrect': 'M???t kh???u kh??ng kh???p',
          're-enter_password': 'Nh???p l???i m???t kh???u',
          'already_account': 'B???n ???? c?? t??i kho???n? ',

          // sign in page
          'forgot_password': 'Qu??n m???t kh???u? ',
          'no_already_account': 'B???n ch??a c?? t??i kho???n? ',
          'reset_password': "?????t l???i m???t kh???u",

          // dashboard page
          "boards": "B???ng",
          'board': 'B???ng',
          'home': "Trang ch???",
          'workspaces': 'C??c kh??ng gian l??m vi???c',
          'my_cards': 'C??c th??? c???a t??i',
          'setting': 'C??i ?????t',
          'help': "Tr??? gi??p!",
          'statistics': "Th???ng k??",
          'log_out': '????ng xu???t',
          'add_account': "Th??m t??i kho???n",
          'are_you_sure_logout': 'B???n c?? ch???c mu???n ????ng xu???t? ',
          'logout_success': '????ng xu???t th??nh c??ng',
          'no': 'Kh??ng',
          'yes': 'C??',
          'card': "Th???",
          'workspace': 'Kh??ng gian l??m vi???c',
          'do_not_have_workspace': 'B???n kh??ng c?? kh??ng gian l??m vi???c n??o',

          // notification page
          'notifications': 'Th??ng b??o',
          'notifications_setting': "C??i ?????t th??ng b??o",
          'all': "T???t c???",
          'me': 'T??i',
          'comments': 'B??nh lu???n',

          // create board page
          'board_name': "T??n b???ng",
          'workspace': 'Kh??ng gian l??m vi???c',
          'visibility': 'Quy???n xem',
          'create_board': "T???o b???ng",
          'private': "Ri??ng t??",
          'public': "C??ng khai",
          'board_description': 'M?? t??? b???ng (T??y ch???n)',

          // create card page
          "add_card": "Th??m th???",
          "start_date": 'Ng??y b???t ?????u',
          'due_date': "Ng??y h???t h???n",
          'done': "HO??N T???T",
          'cancel': 'H???Y',
          'set_reminder': 'Thi???t l???p nh???c nh???',
          'reminder_desc':
              'Nh???c nh??? ch??? ???????c g???i ?????n c??c th??nh vi??n v?? ng?????i theo d??i th???',
          'card_name': 'T??n th???',
          'desc': 'M?? t???',
          'at_time_of_due_date': 'V??o th???i ??i???m h???t h???n',
          'today': "H??m nay",
          'tomorrow': 'Ng??y mai',
          'pick_a_date': 'Ch???n m???t ng??y',
          'morning': "Bu???i s??ng",
          'afternoon': "Bu???i chi???u",
          'evening': "Bu???i t???i",
          'night': "????m",
          'pick_a_time': "Ch???n th???i gian",
          'list': "Danh s??ch",
          'minutes_ago': "ph??t tr?????c",
          'hours_ago': "gi??? tr?????c",
          'days_ago': "ng??y tr?????c",
          'attachment': "T???p ????nh k??m",
          'attach_from': '????nh k??m t???...',
          'camera': "Ch???p ???nh",
          'gallery': "B??? s??u t???p",
          'file': 'T???p',
          'attach_link': "????nh k??m li??n k???t",
          'the_due_date_must_be_before_the_start_date':
              "Ng??y h???t b???n ph???i tr?????c ng??y b???t ?????u",
          'into_the': 'v??o',

          // settings page
          'settings': 'C??i ?????t',
          'language': "Ng??n ng???",
          'select_language': 'Ch???n ng??n ng???',

          // end drawer
          'about_this_board': 'V??? b???ng n??y',
          'members': 'Th??nh vi??n',
          'activity': 'Ho???t ?????ng',
          'power_ups': 'C??c ti???n ??ch b??? sung',
          'archived_cards': 'C??c th??? ???? l??u',
          'archived_list': 'C??c danh s??ch ???? l??u tr???',
          'board_settings': 'Thi???t l???p b???ng',
          'star_board': '????nh d???u sao cho b???ng',
          'pin_to_home_screen': 'Ghim ra m??n h??nh trang ch???',
          'copy_board': 'Sao ch??p b???ng',
          'synced': '????ng b???',

          // create workspace page
          "create_workspace": "T???o kh??ng gian l??m vi???c",
          'update_workspace': "Ch???nh s???a Kh??ng gian l??m vi???c",
          "workspace_name": 'T??n kh??ng gian l??m vi???c',
          "workspace_type": "Lo???i kh??ng gian l??m vi???c",
          "select": "Ch???n",
          "personnel": "Nh??n s???",
          "small_business": "Doanh nghi???p nh???",
          "operating": "??i???u h??nh",
          "education": "Gi??o d???c",
          "it": "C??ng ngh??? th??ng tin",
          "other": "Kh??c",
          "workspace_description": "M?? t??? kh??ng gian l??m vi???c (T??y ch???n)",
          "marketing": "Marketing",

          // detail board page
          "move_list": "Di chuy???n danh s??ch",
          'edit_list_name': 'Ch???nh s???a danh s??ch',
          'add_list': 'Th??m danh s??ch',
          'delete_list': "X??a danh s??ch",
          'sort_by_created_desc': "S???p x???p theo ng??y t???o(m???i nh???t)",
          'sort_by_created_asc': "S???p x???p theo ng??y t???o(c?? nh???t)",
          'sort_by_start_date': "S???p x???p theo ng??y b???t ?????u",
          'sort_by_due_date': "S???p x???p theo ng??y h???t h???n",
          'choose_action': "Ch???n thao t??c",
          'confirm_complete': "X??c nh???n ho??n th??nh",
          'delete_card': "X??a th???",
          'rework': "L??m l???i",
          'are_you_sure_delete_this_card': "B???n c?? ch???c ch???n x??a th??? n??y ?",
          'complete': "Ho??n th??nh",
          'incomplete': "Ch??a ho??n th??nh",
          'to': '?????n',

          // search board page
          'search': 'T??m ki???m',
          'no_results_found': "Kh??ng c?? k???t qu??? n??o ???????c t??m th???y.",

          // EasyLoading message
          'error': "???? x???y ra l???i",
          'sign_up_success': '????ng k?? th??nh c??ng',

          // workspace menu page
          'workspace_menu': "Menu kh??ng gian l??m vi???c",
          'invite': 'M???i',
          'workspace_setting': "Ch???nh s???a Kh??ng gian l??m vi???c",
          'delete_workspace': "X??a kh??ng gian l??m vi???c",
          'are_you_sure_delete_this_workspace':
              "B???n c?? ch???c ch???c x??a kh??ng gian l??m vi???c n??y kh??ng?",

          // invite member page
          'add_members': 'M???i c??c th??nh vi??n',
          'add_user_to_workspace': 'Th??m ng?????i d??ng v??o Kh??ng gian l??m vi???c',
          'add_user_to_board': 'Th??m ng?????i d??ng v??o B???ng',
          'user_not_found': "Kh??ng t??m th???y ng?????i d??ng",
          'add': "Th??m",
          'you_have_selected_this_user': "B???n ???? ch???n ng?????i d??ng n??y",

          // remove member page
          'remove_from_workspace': 'G??? kh???i Kh??ng gian l??m vi???c',
          'admin_permission_explain':
              "C?? th??? xem, t???o v?? ch???nh s???a c??c b???ng Kh??ng gian l??m vi???c, c??ng nh?? thay ?????i c??i ?????t cho Kh??ng gian l??m vi??c",
          'would_you_live_to_leave':
              "B???n c?? mu???n r???i kh???i Kh??ng gian l??m vi???c n??y?",
          'would_you_live_to_leave_board': "B???n c?? mu???n r???i kh???i B???ng n??y?",

          // board menu page
          'board_menu': "Menu b???ng",
          'board_setting': "Ch???nh s???a b???ng",
          'background_color': "M??u n???n",
          'delete_board': 'X??a b???ng',
          'are_you_sure_delete_this_list':
              "B???n c?? ch???c ch???n x??a danh s??ch n??y kh??ng? ",
          'at': "l??c",
          'are_you_sure_delete_this_board':
              "B???n c?? ch???c ch???c x??a b???ng n??y kh??ng? ",
          'only_admin_delete_board':
              "Ch??? c?? th??? ng?????i qu???n tr??? m???i c?? th??? x??a b???ng n??y",

          // update card page
          'edit_card_name': 'Ch???nh s???a t??n',
          'add_card_description': "Th??m m?? t??? th???...",
          'edit_card_description': "Ch???nh s???a m?? t???",
          'card_members': "Th??nh vi??n th???",
          'quick_actions': "C??c h??nh ?????ng nhanh",
          'add_task': "Th??m c??ng vi???c",
          'add_attachment': 'Th??m t???p ????nh k??m',
          'editing_task': 'Ch???nh s???a c??ng vi???c',
          'delete': 'X??a',
          'label': 'Nh??n',
          'image': "H??nh ???nh",
          'download_image': "T???i h??nh ???nh",
          'download_image_success': "T???i ???nh th??nh c??ng",
          'open': "M???",
          'failed': "L???i",
          'canceled': 'h???y',
          'pending': "??ang ch???",

          // edit lable page
          'edit_label': "Ch???nh s???a nh??n",
          'create_new_label': "T???O M???I NH??N",
          'new_label': "Nh??n m???i",
          'label_name': "T??n nh??n",

          // my calendar page
          'my_calendar': "L???ch c???a t??i",
        }
      };
}

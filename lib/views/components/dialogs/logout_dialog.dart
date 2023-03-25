import 'package:insta_riverpod/views/components/constants/strings.dart';
import 'package:insta_riverpod/views/components/dialogs/alert_dialog_model.dart';

class LogoutDialog extends AlertDialogModel {
  LogoutDialog()
      : super(
          title: Strings.logOut,
          message: Strings.areYouSureThatYouWantToLogOut0fTheApp,
          buttons: const {
            Strings.cancel: false,
            Strings.logOut: true,
          },
        );
}

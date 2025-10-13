

import 'package:photobackup/utils/file_indexes.dart';

extension DismisskeyBoard on BuildContext {
  void dismissKeyBoard(){
    FocusScope.of(this).unfocus();
  }
}
extension KeyboardVisibility on BuildContext {
  bool get isKeyboardVisible {
    return MediaQuery.of(this).viewInsets.bottom > 0;
  }
}
extension CustomSizeBox on num{
  SizedBox get height => SizedBox(height: toDouble(),);
  SizedBox get width => SizedBox(width: toDouble(),);
}
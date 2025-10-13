import 'package:photobackup/utils/file_indexes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Space extends StatelessWidget {
  final double size;
  final Axis axis;

  const Space.vertical(this.size, {super.key}) : axis = Axis.vertical;

  const Space.horizontal(this.size, {super.key}) : axis = Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: axis == Axis.vertical ? size.h : null,
      width: axis == Axis.horizontal ? size.w : null,
    );
  }
}
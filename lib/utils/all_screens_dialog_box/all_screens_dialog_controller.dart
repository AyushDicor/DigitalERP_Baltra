import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/app_constant.dart';

import '../../screen/ui/home/order/order_controller.dart';

class CommonDialogBoxController extends AppBaseController {
  OrderController? orderController;

  bool isFilterByDate = true;
  final String _firstDate = AppString.dateTimeEmpty;
  final String _lastDate = AppString.dateTimeEmpty;
}

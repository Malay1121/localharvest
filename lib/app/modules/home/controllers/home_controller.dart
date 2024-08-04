import 'package:get/get.dart';
import 'package:local_harvest/app/helper/all_imports.dart';
import 'package:local_harvest/app/widgets/common_controller.dart';

class HomeController extends CommonController {
  TextEditingController searchController = TextEditingController();
  List<Map> products = [];
  List<Map> farmers = [];
  List<Map> filteredData = [];
  List categories = [
    AppStrings.products,
    AppStrings.farmers,
  ];
  String selectedCategory = AppStrings.products;
  void changeUserType(String userType) {
    selectedCategory = userType;
    getProducts();
    update();
  }

  void getProducts() async {
    bool farmer = selectedCategory == AppStrings.farmers;

    filteredData = (farmer ? farmers : products)
        .where(
          (element) => (farmer
                  ? (element["fName"] + " " + element["lName"])
                  : element["title"])
              .toString()
              .toLowerCase()
              .contains(searchController.text.toLowerCase()),
        )
        .toList();

    update();
  }

  void initData() async {
    products = await DatabaseHelper.getProducts();
    farmers = await DatabaseHelper.getFarmers();
    getProducts();
  }

  onChange(String value) {
    getProducts();
  }

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

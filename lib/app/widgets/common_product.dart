import 'package:local_harvest/app/helper/all_imports.dart';

class CommonProduct extends StatefulWidget {
  CommonProduct({
    super.key,
    required this.id,
    required this.farmerFirstName,
    required this.farmerLastName,
    required this.farmerImage,
    required this.productName,
    required this.image,
    required this.price,
    required this.quantity,
    required this.uid,
    this.data,
    this.edit = false,
  });
  String id;
  String image;
  String productName;
  String farmerFirstName;
  String farmerLastName;
  String uid;
  double price;
  double quantity;
  String farmerImage;
  Map? data;
  bool edit;
  @override
  State<CommonProduct> createState() => _CommonProductState();
}

class _CommonProductState extends State<CommonProduct> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        Routes.PRODUCT,
        arguments: {
          "productId": widget.id,
          "data": widget.data,
        },
      ),
      child: Container(
        width: 163.w(context),
        decoration: BoxDecoration(
          color: AppColors.lightBG,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w(context),
            vertical: 24.h(context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 20.w(context),
                    height: 20.h(context),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.farmerImage,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4.w(context),
                  ),
                  AppText(
                    text: "${widget.farmerFirstName} ${widget.farmerLastName}",
                    style: Styles.bold(
                      color: AppColors.fontGrey,
                      fontSize: 12.t(context),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4.h(context),
              ),
              Container(
                width: 115.w(context),
                height: 115.h(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.image,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 8.h(context)),
              AppText(
                text: "${widget.farmerFirstName}’s ${widget.productName}",
                style: Styles.bold(
                  color: AppColors.fontDark,
                  fontSize: 14.t(context),
                ),
              ),
              SizedBox(height: 2.h(context)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: "${widget.quantity} kg, ${widget.price}\$",
                    style: Styles.bold(
                      color: AppColors.secondary,
                      fontSize: 14.t(context),
                    ),
                    width: 75.w(context),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      if (widget.edit) {
                        Get.toNamed(Routes.ADD_PRODUCT, arguments: widget.data);
                      } else {
                        await DatabaseHelper.addToCart(
                            uid: widget.uid, productId: widget.id, quantity: 1);
                        showSnackbar(
                            title: "Added ${widget.productName} to cart");
                      }
                    },
                    child: Container(
                      width: 36.w(context),
                      height: 36.h(context),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w(context),
                          vertical: 10.h(context),
                        ),
                        child: SvgPicture.asset(
                          widget.edit ? AppImages.icEdit : AppImages.icAdd,
                          width: 16.w(context),
                          height: 16.h(context),
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

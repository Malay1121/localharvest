import 'package:local_harvest/app/helper/all_imports.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CommonFarmer extends StatefulWidget {
  CommonFarmer({
    super.key,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.sales,
    this.data,
  });
  String id;
  String image;
  String firstName;
  String lastName;
  int sales;
  Map? data;
  @override
  State<CommonFarmer> createState() => _CommonFarmerState();
}

class _CommonFarmerState extends State<CommonFarmer> {
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
                text: "${widget.firstName} ${widget.lastName}",
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
                    text: "${widget.sales} kg sales",
                    style: Styles.bold(
                      color: AppColors.secondary,
                      fontSize: 14.t(context),
                    ),
                    maxLines: 2,
                    width: 75.w(context),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async => await launchUrlString("tel://214324234"),
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
                        child: Icon(
                          Icons.call,
                          size: 16.t(context),
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

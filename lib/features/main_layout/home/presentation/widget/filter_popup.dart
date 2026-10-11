import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greengrocer/core/resources/app_assets/app_assets.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/features/main_layout/home/presentation/cubit/vendors_cubit.dart';

class FilterPopup {
  static void show(BuildContext context) {
    bool offers = false;
    bool freeDelivery = false;
    int selectedRegionId = 0;
    String selectedArea = "All Areas";

    final responsive = Responsive(context);
    final vendorsCubit = context.read<VendorsCubit>();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setLocalState) {
            final isLandscape =
                MediaQuery.of(context).orientation == Orientation.landscape;

            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(responsive.scaleWidth(25)),
              ),
              child: Container(
                width: isLandscape
                    ? MediaQuery.of(context).size.width * 0.6
                    : MediaQuery.of(context).size.width * 0.5,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                padding: EdgeInsets.all(
                  responsive.scaleWidth(isLandscape ? 15 : 20),
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(
                    responsive.scaleWidth(25),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Filter by",
                        style: TextStyle(
                          fontSize: responsive.scaleWidth(isLandscape ? 15 : 18),
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(
                        height: responsive.scaleHeight(isLandscape ? 8 : 20),
                      ),

                      Row(
                        children: [
                          Text(
                            "Delivered To",
                            style: TextStyle(
                              fontSize: responsive.scaleWidth(isLandscape ? 10 : 15),
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey,
                            ),
                          ),
                          SizedBox(width: responsive.scaleWidth(5)),
                          SvgPicture.asset(
                            AppAssets.deliveryIcon,
                            height: responsive.scaleHeight(isLandscape ? 40 : 18),
                            color: AppColors.green,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: responsive.scaleHeight(isLandscape ? 10 : 10),
                      ),

                      Container(
                        width: double.infinity,
                        height: isLandscape ? responsive.scaleHeight(125) : null,
                        padding: EdgeInsets.symmetric(
                          horizontal: responsive.scaleWidth(15),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            responsive.scaleWidth(25),
                          ),
                          border: Border.all(color: const Color(0xff858D9A)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedArea,
                            iconSize: responsive.scaleWidth(isLandscape ? 20 : 30),
                            items: const [
                              DropdownMenuItem(
                                value: "All Areas",
                                child: Text("All Areas"),
                              ),
                              DropdownMenuItem(
                                value: "Area 1",
                                child: Text("Area 1"),
                              ),
                              DropdownMenuItem(
                                value: "Area 2",
                                child: Text("Area 2"),
                              ),
                            ],
                            onChanged: (val) {
                              setLocalState(() {
                                selectedArea = val!;
                                if (val == "All Areas") {
                                  selectedRegionId = 0;
                                } else if (val == "Area 1") {
                                  selectedRegionId = 1;
                                } else if (val == "Area 2") {
                                  selectedRegionId = 2;
                                }
                              });
                            },
                          ),
                        ),
                      ),

                      SizedBox(
                        height: responsive.scaleHeight(isLandscape ? 10 : 10),
                      ),

                      isLandscape
                          ? Row(
                        children: [
                          Expanded(
                            child: _buildCheckbox(
                              "Offers",
                              offers,
                                  (val) => setLocalState(() => offers = val!),
                              responsive,
                              isLandscape,
                            ),
                          ),
                          Expanded(
                            child: _buildCheckbox(
                              "Free Delivery",
                              freeDelivery,
                                  (val) => setLocalState(
                                      () => freeDelivery = val!),
                              responsive,
                              isLandscape,
                            ),
                          ),
                        ],
                      )
                          : Column(
                        children: [
                          _buildCheckbox(
                            "Offers",
                            offers,
                                (val) => setLocalState(() => offers = val!),
                            responsive,
                            isLandscape,
                          ),
                          _buildCheckbox(
                            "Free Delivery",
                            freeDelivery,
                                (val) => setLocalState(
                                    () => freeDelivery = val!),
                            responsive,
                            isLandscape,
                          ),
                        ],
                      ),

                      SizedBox(
                        height: responsive.scaleHeight(isLandscape ? 15 : 20),
                      ),

                      SizedBox(
                        width: responsive.scaleWidth(isLandscape ? 160 : 244),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                responsive.scaleWidth(25),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: responsive.scaleHeight(isLandscape ? 14 : 14),
                            ),
                          ),
                          onPressed: () {
                            vendorsCubit.getVendors(
                              regionId: selectedRegionId,
                              isFreeDelivery: freeDelivery ? 1 : null,
                            );
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Apply Filter",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: responsive.scaleWidth(isLandscape ? 11 : 16),
                            ),
                          ),
                        ),
                      ),

                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Close",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: responsive.scaleWidth(isLandscape ? 10 : 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static Widget _buildCheckbox(
      String title,
      bool value,
      Function(bool?) onChanged,
      Responsive responsive,
      bool isLandscape,
      ) {
    return Row(
      children: [
        Transform.scale(
          scale: isLandscape ? 1.5 : 1.0,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        Flexible(
          child: Text(
            title,
            style: TextStyle(
              fontSize: responsive.scaleWidth(isLandscape ? 10 : 14),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
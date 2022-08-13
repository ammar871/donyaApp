import 'package:doniya/app-with-api/models/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../helpers/commens.dart';

class CustomDropDownWidget extends StatefulWidget {
  final List<dynamic> list;
  final Function(dynamic) onSelect;
  final String hint;
  final bool hasType;
  final bool isTwoIcons;
  final IconData icon1;
  final IconData icon2;
  final  actionBtn;
  final Color colorBackRound;
  final Color iconColor, textColor;
  final dynamic currentValue;
  final bool selectCar;

  const CustomDropDownWidget(
      {this.selectCar = false,
        required this.currentValue,
        required this.colorBackRound,
        required this.textColor,
        required this.iconColor,
        this.actionBtn,
        required this.icon2,
        required this.icon1,
        this.hasType=true,
        this.isTwoIcons = false,
        required this.list,
        required this.onSelect,
        required this.hint});

  @override
  _CustomDroopDownWidgetState createState() => _CustomDroopDownWidgetState();
}

class _CustomDroopDownWidgetState extends State<CustomDropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: [
            widget.isTwoIcons
                ? Icon(
              widget.icon1,
              color: widget.iconColor,
            )
                : SizedBox(),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                widget.hint,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: widget.textColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.list
            .map((item) => DropdownMenuItem<dynamic>(
            value: item,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
            Common.LANGCode == "ar"
                ? item.nameArbice!
                    : (Common.LANGCode == "en"
            ? "${item.nameEnglish}"
                : "${item.nameFrance}"),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                // if(widget.actionBtn!=null) IconButton(onPressed:(){
                //   widget.actionBtn(item.id);
                // } , icon: Icon(Icons.close,color: Colors.red,size: 20,))
              ],

            )))
            .toList(),
        value: widget.currentValue,
        onChanged: widget.onSelect,
        icon: Icon(
          Icons.keyboard_arrow_down_sharp,
          color: widget.iconColor,
        ),
        iconSize: 18,
        iconEnabledColor: Colors.white,
        iconDisabledColor: Colors.grey,
        buttonHeight: 50,
        buttonWidth: double.infinity,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: BoxDecoration(
          border: Border.all(color: Colors.grey,width: 1),
          borderRadius: BorderRadius.circular(10),
          color: widget.colorBackRound,
        ),
        itemHeight: 40,
        // itemWidth: MediaQuery.of(context).size.width-40.0,
        dropdownMaxHeight: 200,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color:Colors.white,
        ),
        dropdownElevation: 2,
        scrollbarRadius: const Radius.circular(30),
        scrollbarThickness: 4,
        scrollbarAlwaysShow: true,
        offset: Offset(0,-5),
      ),

    );
  }
}




class CustomDropDownWidgetSub extends StatefulWidget {
  final List<SubCategoryResponse> list;
  final Function(dynamic) onSelect;
  final String hint;
  final bool hasType;
  final bool isTwoIcons;
  final IconData icon1;
  final IconData icon2;
  final  actionBtn;
  final Color colorBackRound;
  final Color iconColor, textColor;
  final dynamic currentValue;
  final bool selectCar;

  const CustomDropDownWidgetSub(
      {this.selectCar = false,
        required this.currentValue,
        required this.colorBackRound,
        required this.textColor,
        required this.iconColor,
        this.actionBtn,
        required this.icon2,
        required this.icon1,
        this.hasType=true,
        this.isTwoIcons = false,
        required this.list,
        required this.onSelect,
        required this.hint});

  @override
  _CustomDropDownWidgetSubState createState() => _CustomDropDownWidgetSubState();
}

class _CustomDropDownWidgetSubState extends State<CustomDropDownWidgetSub> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: [
            widget.isTwoIcons
                ? Icon(
              widget.icon1,
              color: widget.iconColor,
            )
                : SizedBox(),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                widget.hint,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: widget.textColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.list
            .map((item) => DropdownMenuItem<SubCategoryResponse>(
            value: item,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Common.LANGCode == "ar"
                      ? item.subCategory!.nameArbice!
                      : (Common.LANGCode == "en"
                      ? "${item.subCategory!.nameEnglish}"
                      : "${item.subCategory!.nameFrance}"),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                // if(widget.actionBtn!=null) IconButton(onPressed:(){
                //   widget.actionBtn(item.id);
                // } , icon: Icon(Icons.close,color: Colors.red,size: 20,))
              ],

            )))
            .toList(),
        value: widget.currentValue,
        onChanged: widget.onSelect,
        icon: Icon(
          Icons.keyboard_arrow_down_sharp,
          color: widget.iconColor,
        ),
        iconSize: 18,
        iconEnabledColor: Colors.white,
        iconDisabledColor: Colors.grey,
        buttonHeight: 50,
        buttonWidth: double.infinity,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: BoxDecoration(
          border: Border.all(color: Colors.grey,width: 1),
          borderRadius: BorderRadius.circular(10),
          color: widget.colorBackRound,
        ),
        itemHeight: 40,
        // itemWidth: MediaQuery.of(context).size.width-40.0,
        dropdownMaxHeight: 200,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color:Colors.white,
        ),
        dropdownElevation: 2,
        scrollbarRadius: const Radius.circular(30),
        scrollbarThickness: 4,
        scrollbarAlwaysShow: true,
        offset: Offset(0,-5),
      ),

    );
  }
}
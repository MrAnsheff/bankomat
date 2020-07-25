import 'package:flutter/material.dart';
import 'package:bankomat/const/const.dart';
import 'package:bankomat/helpers/color_helpers.dart';

import '../const/const.dart';


class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _CustomAppBar createState() => _CustomAppBar();
  @override
  Size get preferredSize => const Size.fromHeight(157.0);
}

class _CustomAppBar extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: linearGradient(FIRST_COLOR, SECOND_COLOR),
      ),
      child: SafeArea(        
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[              
              Container(
                width: 66.79,
                height: 25.7,
                margin: EdgeInsets.only(left:16,top:16,bottom:16),
                child:
                    Image.asset('assets/icon.png')               
                ),
            ],
          ),
        ),
        
  
    );
  }
}

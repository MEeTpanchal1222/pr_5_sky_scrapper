import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class home_screen extends StatelessWidget {
  const home_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Color(0xffE5E5E5),
       body:  Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Container(
              width: 202,
              height: 40,
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 202,
                        height: 40,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadows: [
                            BoxShadow(
                              color: Color(0x0F000000),
                              blurRadius: 24,
                              offset: Offset(0, 12),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        left: 24,
                        top: 10,
                        child:
                            Text(
                              'Sukasari, Bandung',
                              style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 16,
                                fontFamily: 'Product Sans',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),

                        ),

                    ],
                  ),
                ],
              ),
            ),
         ],
       )

    );
  }
}

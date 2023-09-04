import 'package:flutter/material.dart';
import 'package:phincash/constants/app_string.dart';
import 'package:phincash/constants/colors.dart';
class CarouselWidget extends StatefulWidget {
  final String? imagePath;
  final String? message;
  final String? title;
  final List<Widget>? children;
  const CarouselWidget({Key? key, this.imagePath, this.message, this.title, this.children}) : super(key: key);

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height / 8,
          decoration: BoxDecoration(color: const Color(0xffD3EDFF), borderRadius: BorderRadius.circular(6)),
          padding: const EdgeInsets.all(10),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 60, width: 60, decoration: BoxDecoration(color: kPrimaryColorLight, borderRadius: BorderRadius.circular(4)),
                child: Image.asset(widget.imagePath!),
              ),
             const SizedBox(width: 15,),
             Expanded(
                 child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(widget.title!, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFF258DEE), fontSize: 16, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700),),
                     const SizedBox(height: 10,),
                     Text(widget.message!, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xff3A3A3A), fontSize: 14, fontFamily: AppString.latoFontStyle, overflow: TextOverflow.ellipsis),),
                   ],
                 ),
             ),
              Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.children!,
              )
            ],
          )
      ),
    );
  }
}

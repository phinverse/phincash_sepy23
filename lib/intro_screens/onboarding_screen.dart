import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:phincash/constants/app_string.dart';
import 'package:phincash/intro_screens/landing_page.dart';
import 'package:phincash/widget/button_widget.dart';
import '../constants/asset_path.dart';
import '../constants/colors.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  int _current = 0;

  final List<String> imgList = [
    AssetPath.onBoardImage1,
    AssetPath.onBoardImage2,
    AssetPath.onBoardImage3,
  ];

  _onBoardingHeader(){
    if(_current == 0){
      return AppString.onBoardingOneHeader;
    }else if(_current == 1){
      return AppString.onBoardingTwoHeader;
    }else if(_current == 2){
      return AppString.onBoardingThreeHeader;
    }
  }

  _onBoardingMessage(){
    if(_current == 0){
      return AppString.onBoardingOneMessage;
    }else if(_current == 1){
      return AppString.onBoardingTwoMessage;
    }else if(_current == 2){
      return AppString.onBoardingThreeMessage;
    }
  }

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      top: false, bottom: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20,10,20,30),
          child: Column(
            children: [
              const Spacer(flex: 1,),
              Align(
                alignment: Alignment.topRight,
                  child: TextButton(onPressed: (){
                    Get.to(()=>const LandingPage());
                  }, child: Text(AppString.skip,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13, fontFamily: AppString.latoFontStyle, fontWeight: FontWeight.w700)), )),
              const Spacer(flex: 4,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                    height: height*0.4,
                    child: CarouselSlider(
                      options: CarouselOptions(
                          height: height,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          autoPlay: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }
                      ),
                      items: imgList.map((item) => SvgPicture.asset(item, width: width, height: height, fit: BoxFit.cover,)).toList(),
                    )
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: opacity1,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: RichText(textAlign: TextAlign.center, text: TextSpan(
                        text: _onBoardingHeader(), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20,)
                    ))
                ),
              ),
              const Spacer(flex: 1,),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: opacity1,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: RichText(textAlign: TextAlign.center, text: TextSpan(
                        text: _onBoardingMessage(), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13,fontFamily: AppString.latoFontStyle)
                    ))
                ),
              ),
              const Spacer(flex: 1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.map((x) {
                  int index = imgList.indexOf(x);
                  return Container(
                    width: _current == index ? 16 : 6,
                    height: 6,
                    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _current == index ? kPrimaryColorLight : kGrey
                      //kPrimaryColor : kPrimaryColorLight,
                    ),
                  );
                }).toList(),
              ),
              const Spacer(flex: 1,),
              Column(
                children: [
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: opacity3,
                    child: ButtonWidget(
                      buttonText: AppString.next, height: 48, width: double.maxFinite,
                      onPressed: (){
                        if(_current == 0){
                          setState(() {
                            _current = 1;
                          });
                        }else if (_current == 1){
                          setState(() {
                            _current = 2;
                          });
                        }else if (_current == 2){
                          Get.to(()=>const LandingPage());
                        }
                      }
                    )
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

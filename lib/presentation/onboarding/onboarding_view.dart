
import 'package:complete_advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late final List<SliderObject> _list = _getSliderDate();

  final PageController _pageController = PageController(initialPage: 0);

  List<SliderObject> _getSliderDate() => [
        SliderObject(AppStrings.onBoardingTitle1,
            AppStrings.onBoardingSubTitle1, ImageManager.onBoardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2,
            AppStrings.onBoardingSubTitle2, ImageManager.onBoardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3,
            AppStrings.onBoardingSubTitle3, ImageManager.onBoardingLogo3),
        SliderObject(AppStrings.onBoardingTitle4,
            AppStrings.onBoardingSubTitle4, ImageManager.onBoardingLogo4),
      ];
  
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: AppSize.s1_5,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
          controller: _pageController,
          itemCount: _list.length,
          onPageChanged: (index){
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index){
            return OnBoardingPage(_list[index]);
          }),
      bottomSheet: Container(
        color: ColorManager.primary,
        height: AppSize.s100,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: (){},
                child: const Text(AppStrings.skip, textAlign: TextAlign.end,),
              ),
            ),

            /// TODO add layout for indicator and arrows
            _getBottomSheetWidget(),
          ],
        ),
      ),
    );
  }

  Widget _getBottomSheetWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // left arrow
        Padding(
          padding: const EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            child: SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: SvgPicture.asset(ImageManager.leftArrowIc),
            ),
            onTap: () {
              // go to previous slide
              _pageController.animateToPage(_getPreviousIndex(),
                  duration: const Duration(milliseconds: DurationConstant.d300),
                  curve: Curves.bounceInOut);
            },
          ),
        ),

        // circles indicator
        Row(
          children: [
            for (int i = 0; i < _list.length; i++)
              Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: _getProperCircle(i),
              )
          ],
        ),

        // right arrow
        Padding(
          padding: const EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            child: SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: SvgPicture.asset(ImageManager.rightArrowIc),
            ),
            onTap: () {
              // go to next slide
              _pageController.animateToPage(_getNextIndex(),
                  duration: const Duration(milliseconds: DurationConstant.d300),
                  curve: Curves.bounceInOut);
            },
          ),
        )
      ],
    );
  }

  int _getPreviousIndex() {
    int previousIndex = _currentIndex--; // -1
    if (previousIndex == -1) {
      _currentIndex =
          _list.length - 1; // infinite loop to go to the length of slider list
    }
    return _currentIndex;
  }

  int _getNextIndex() {
    int nextIndex = _currentIndex++; // +1
    if (nextIndex >= _list.length) {
      _currentIndex = 0; // infinite loop to go to first item inside the slider
    }
    return _currentIndex;
  }

  Widget _getProperCircle(int index) {
    if (index == _currentIndex) {
      return SvgPicture.asset(ImageManager.hollowCircleIc); // selected slider
    } else {
      return SvgPicture.asset(ImageManager.solidCircleIc); // unselected slider
    }
  }
}

class OnBoardingPage extends StatelessWidget {
   final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ///Vertical Empty Space
        const SizedBox(height: AppSize.s40,),

        /// Title Text
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(_sliderObject.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline1,),
        ),

        /// SubTitle Text
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(_sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,),
        ),

        ///Vertical Empty Space
        const SizedBox(height: AppSize.s60,),

        ///Image Widget
        SvgPicture.asset(_sliderObject.image)

      ],
    );
  }
}

class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

import 'package:mera_doost/main.dart';
import 'package:flutter/material.dart';
import 'package:mera_doost/Helper/Color.dart';
import 'package:mera_doost/Provider/systemProvider.dart';
import 'package:provider/provider.dart';
import '../../../widgets/bottomSheet.dart';

class LanguageBottomSheet extends StatelessWidget {
  LanguageBottomSheet({Key? key}) : super(key: key);
  List<String?> languageList = [];

  List<Widget> getLngList(
    BuildContext context,
    StateSetter setModalState,
  ) {
    context.read<SystemProvider>().getCurrentLanguage(context: context);
    return languageList
        .asMap()
        .map(
          (index, element) => MapEntry(
            index,
            InkWell(
              onTap: () {
                context
                    .read<SystemProvider>()
                    .changeCurrentLanguage(selectedLanguageIndex: index)
                    .then(
                  (value) {
                    MyApp.setLocale(context, value);
                    context
                        .read<SystemProvider>()
                        .getCurrentLanguage(context: context);
                  },
                );
                setModalState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Selector<SystemProvider, int>(
                          selector: (_, provider) => provider.currentLanguage,
                          builder: (context, selectedLanguage, child) {
                            return Container(
                              height: 25.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: selectedLanguage == index
                                    ? colors.primary
                                    : Theme.of(context).colorScheme.white,
                                border: Border.all(
                                  color: colors.grad2Color,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: selectedLanguage == index
                                    ? Icon(
                                        Icons.check,
                                        size: 17.0,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .fontColor,
                                      )
                                    : Icon(
                                        Icons.check_box_outline_blank,
                                        size: 17.0,
                                        color:
                                            Theme.of(context).colorScheme.white,
                                      ),
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            start: 15.0,
                          ),
                          child: Text(
                            languageList[index]!,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.lightBlack,
                                ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        .values
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    languageList = [
     'English',
     'Chinese',
      'Spanish',
      'French',
      'Hindi',
      'Arabic',
      'Russian',
     'Japanese',
     'German'
    ];
    return Wrap(
      children: [
        Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomBottomSheet.bottomSheetHandle(context),
              CustomBottomSheet.bottomSheetLabel(
                  context, 'CHOOSE_LANGUAGE_LBL'),
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: getLngList(
                        context,
                        setModalState,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

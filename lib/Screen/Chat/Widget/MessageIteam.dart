import 'package:mera_doost/Helper/Color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Helper/Constant.dart';
import '../../../Provider/SettingProvider.dart';
import '../../../Provider/chatProvider.dart';
import '../../../widgets/validation.dart';
import 'attachIteam.dart';

class MessageIteam extends StatefulWidget {
  int index;
  MessageIteam({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<MessageIteam> createState() => _MessageIteamState();
}

class _MessageIteamState extends State<MessageIteam> {
  Widget MsgContent(
    int index,
  ) {
    SettingProvider settingsProvider =
        Provider.of<SettingProvider>(context, listen: false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          context.read<ChatProvider>().chatList[widget.index].uid ==
                  settingsProvider.userId
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
      children: <Widget>[
        context.read<ChatProvider>().chatList[widget.index].uid ==
                settingsProvider.userId
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        StringValidation.capitalize(
                          context
                              .read<ChatProvider>()
                              .chatList[widget.index]
                              .name!,
                        ),
                        style: const TextStyle(
                          color: colors.primary,
                          fontSize: textFontSize12,
                          fontFamily: 'ubuntu',
                        ),
                      ),
                    )
                  ],
                ),
              ),
        ListView.builder(
            itemBuilder: (context, index) {
              return AttachIteam(
                attach:
                    context.read<ChatProvider>().chatList[widget.index].attach!,
                index: index,
                message: context.read<ChatProvider>().chatList[widget.index],
              );
            },
            itemCount: context
                .read<ChatProvider>()
                .chatList[widget.index]
                .attach!
                .length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true),
        context.read<ChatProvider>().chatList[widget.index].msg != null &&
                context
                    .read<ChatProvider>()
                    .chatList[widget.index]
                    .msg!
                    .isNotEmpty
            ? Card(
                elevation: 0.0,
                color: context
                            .read<ChatProvider>()
                            .chatList[widget.index]
                            .uid ==
                        settingsProvider.userId
                    ? Theme.of(context).colorScheme.fontColor.withOpacity(0.1)
                    : Theme.of(context).colorScheme.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Column(
                    crossAxisAlignment: context
                                .read<ChatProvider>()
                                .chatList[widget.index]
                                .uid ==
                            settingsProvider.userId
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${context.read<ChatProvider>().chatList[widget.index].msg}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(top: 5),
                        child: Text(
                          context
                              .read<ChatProvider>()
                              .chatList[widget.index]
                              .date!,
                          style: TextStyle(
                            fontFamily: 'ubuntu',
                            color: Theme.of(context).colorScheme.lightBlack,
                            fontSize: textFontSize9,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (context.read<ChatProvider>().chatList[widget.index].uid ==
        context.read<SettingProvider>().userId) {
      //Own message
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(),
          ),
          Flexible(
            flex: 2,
            child: MsgContent(
              widget.index,
            ),
          ),
        ],
      );
    } else {
      //Other's message
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 2,
            child: MsgContent(
              widget.index,
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(),
          ),
        ],
      );
    }
  }
}

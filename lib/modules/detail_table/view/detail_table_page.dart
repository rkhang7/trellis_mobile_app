import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:trellis_mobile_app/components/end_drawer_component.dart';
import 'package:trellis_mobile_app/models/board_model.dart';
import 'package:trellis_mobile_app/models/card_model.dart';
import 'package:trellis_mobile_app/routes/app_routes.dart';
import 'package:trellis_mobile_app/utils/app_colors.dart';
import 'package:trellis_mobile_app/utils/colors.dart';
import 'package:trellis_mobile_app/utils/drag_widget/drag_and_drop_list.dart';
import 'package:trellis_mobile_app/utils/widgets.dart';

class DetailTablePage extends StatefulWidget {
  const DetailTablePage({Key? key}) : super(key: key);

  @override
  State<DetailTablePage> createState() => _DetailTablePageState();
}

class _DetailTablePageState extends State<DetailTablePage> {
  String name = Get.arguments;
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  List<BoardModel> boards = [];
  List<List<CardModel?>> cards = [];
  TextEditingController _cardTextController = TextEditingController();
  TextEditingController _taskTextController = TextEditingController();
  bool isListEnable = false;
  bool isCardEnable = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        backgroundColor: backgroundColor,
        endDrawer: EndDrawerComponent(),
        appBar: _buildAppBar(),
        body: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: PageScrollPhysics(),
          itemCount: boards.length + 1,
          itemBuilder: (context, index) {
            if (index == boards.length) {
              return _addCardWidget(context);
            } else {
              return _buildCard(context, index);
            }
          },
        ),
      ),
    );
  }

  init() async {
    boards.add(BoardModel(name: 'Open', isSelected: true));
    cards.add([
      CardModel(name: "Task 1"),
      CardModel(name: "Task 4"),
      CardModel(name: "Task 3"),
      CardModel(name: "Task 7")
    ]);
    _cardTextController.text = "";
    boards.add(BoardModel(name: 'ToDo', isSelected: true));
    cards.add([CardModel(name: "Task 2"), CardModel(name: "Task 8")]);
    _cardTextController.text = "";
    boards.add(BoardModel(name: 'InProgress', isSelected: true));
    cards.add([CardModel(name: "Task 9")]);
    _cardTextController.text = "";
    boards.add(BoardModel(name: 'Completed', isSelected: true));
    cards.add([]);
    _cardTextController.text = "";
    boards.add(BoardModel(name: 'Closed', isSelected: true));
    cards.add([
      CardModel(name: "Task 11"),
      CardModel(name: "Task 12"),
      CardModel(name: "Task 13"),
      CardModel(name: "Task 14")
    ]);
    _cardTextController.text = "";
  }

  Widget _addCardWidget(context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {},
          child: Container(
            width: 270.0,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    blurRadius: 8,
                    offset: Offset(0, 0),
                    color: Color.fromRGBO(127, 140, 141, 0.5),
                    spreadRadius: 2)
              ],
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(16.0),
            child: !isListEnable
                ? Text("Add List",
                        style: boldTextStyle(color: buttonColor, size: 18))
                    .center()
                : TextFormField(
                    autofocus: true,
                    cursorColor: Colors.white,
                    maxLines: 1,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    onFieldSubmitted: (v) {
                      _addList("");
                      isListEnable = false;
                      setState(() {});
                    },
                    decoration: textFieldInputDecoration(
                        labelText: 'Add List', color: Colors.black),
                  ),
          ),
        ),
      ],
    );
  }

  _addList(String text) {
    boards.add(BoardModel(name: text, isSelected: true));
    cards.add([]);
    setState(() {});
  }

  Widget _buildCard(BuildContext context, int index) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            width: 270.0,
            decoration: boxDecorationWithShadow(
                borderRadius: BorderRadius.circular(10),
                blurRadius: 2,
                shadowColor: Colors.black45,
                spreadRadius: 0),
            margin: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      boards[index].name!.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ).paddingAll(16),
                    PopupMenuButton(
                      onSelected: (dynamic v) {
                        toast('Coming Soon');
                      },
                      itemBuilder: (context) {
                        List<PopupMenuEntry<Object>> list = [];
                        list.add(const PopupMenuItem(child: Text('Move list')));
                        list.add(const PopupMenuItem(child: Text('Copy')));
                        list.add(
                            const PopupMenuItem(child: Text('Archive list')));
                        list.add(const PopupMenuItem(child: Text('watch')));
                        return list;
                      },
                    ),
                  ],
                ),
                Container(
                  height: Get.height * 0.7,
                  child: DragAndDropList<CardModel?>(
                    cards[index],
                    itemBuilder: (BuildContext context, item) {
                      return _addTask(index, cards[index].indexOf(item));
                    },
                    onDragFinish: (oldIndex, newIndex) {
                      _handleReOrder(oldIndex!, newIndex!, index);
                    },
                    canBeDraggedTo: (one, two) => true,
                    dragElevation: 0.0,
                    tilt: .02,
                  ),
                ),
                10.height,
                _buildTaskWidget(context, index),
                10.height,
              ],
            ),
          ),
          Positioned.fill(
            child: DragTarget(
              onWillAccept: (data) {
                log(data);
                return true;
              },
              onLeave: (data) {},
              onAccept: (data) {
                /*if (data!['from'] == index) {
                  return;
                }
                cards[data['from']].remove(data['string']);
                cards[index].add(data['string']);*/
                setState(() {});
              },
              builder: (context, accept, reject) {
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Container _addTask(int index, int innerIndex) {
    return Container(
      width: 300.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Draggable(
        feedback: Material(
          elevation: 2.0,
          child: Container(
            width: 284.0,
            padding: EdgeInsets.all(16.0),
            color: Colors.white,
            child: Text(cards[index][innerIndex]!.name!),
          ),
        ),
        childWhenDragging: Container(),
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          decoration: boxDecorationWithShadow(
            shadowColor: Colors.black38,
            spreadRadius: 0,
            blurRadius: 1,
            borderRadius: BorderRadius.circular(5),
            backgroundColor: Colors.white,
          ),
          child: Text(cards[index][innerIndex]!.name!),
        ),
        data: {"from": index, "string": cards[index][innerIndex]},
      ).onTap(() {}),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: iconColorPrimary),
        onPressed: () {
          Get.back();
        },
      ),
      backgroundColor: backgroundColor,
      title: Text(
        name,
        style: boldTextStyle(size: 18, color: Colors.white),
      ),
      actions: [
        IconButton(
          onPressed: () {
            toast('Coming Soon');
          },
          icon: const Icon(Icons.search, color: iconColorPrimary),
        ),
        IconButton(
          onPressed: () {
            Get.toNamed(AppRoutes.NOTIFICATION);
          },
          icon: const Icon(Icons.notifications_none_outlined,
              color: iconColorPrimary),
        ),
        IconButton(
          onPressed: () {
            _handleDrawer();
          },
          icon: const Icon(Icons.more_horiz, color: iconColorPrimary),
        ),
      ],
    );
  }

  _handleReOrder(int oldIndex, int newIndex, int index) {
    var oldValue = cards[index][oldIndex];
    cards[index][oldIndex] = cards[index][newIndex];
    cards[index][newIndex] = oldValue;
    setState(() {});
  }

  Widget _buildTaskWidget(context, index) {
    return Container(
      height: 45,
      child: InkWell(
        onTap: () {
          boards[index].isToggle = true;
          isCardEnable = true;
          setState(() {});
        },
        child: !boards[index].isToggle
            ? Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.add, color: buttonColor),
                  8.width,
                  Text(
                    "Add Card",
                    style: boldTextStyle(color: buttonColor),
                  ),
                ],
              )
            : !isCardEnable
                ? Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.add, color: buttonColor),
                      8.width,
                      Text("Add Card",
                          style: boldTextStyle(color: buttonColor)),
                    ],
                  )
                : Container(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: TextFormField(
                      autofocus: true,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      onFieldSubmitted: (v) {
                        _addCard(index, v.trim());
                        isCardEnable = false;
                        boards[index].isToggle = false;

                        setState(() {});
                      },
                      decoration: textFieldInputDecoration(
                          labelText: 'Add card',
                          color: Colors.black,
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 8)),
                    ),
                  ),
      ),
    );
  }

  _addCard(int index, String text) {
    cards[index].add(CardModel(name: text, isSelected: true));

    setState(() {});
  }

  void _handleDrawer() {
    _key.currentState!.openEndDrawer();
  }
}

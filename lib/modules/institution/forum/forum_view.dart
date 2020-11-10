import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universy/model/account/profile.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/modules/institution/forum/items/filters/filter_button.dart';
import 'package:universy/modules/institution/forum/items/publication/publication_item.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/widgets/paddings/edge.dart';

import 'bloc/cubit.dart';

class ForumViewWidget extends StatefulWidget {
  final List<ForumPublication> _listPublications;
  final Profile _profile;

  const ForumViewWidget(
      {Key key, @required List<ForumPublication> forumPublications, Profile profile})
      : this._listPublications = forumPublications,
        this._profile = profile,
        super(key: key);

  @override
  _InstitutionForumModuleState createState() => _InstitutionForumModuleState();
}

class _InstitutionForumModuleState extends State<ForumViewWidget> {
  ScrollController _scrollController = ScrollController();
  List<DropdownMenuItem> items = List<DropdownMenuItem>();
  DropdownMenuItem _selected;
  List<ForumPublication> _listPublications = [];
  int offset;
  bool isLoading;
  bool noMorePages;

  @override
  void initState() {
    isLoading = false;
    noMorePages = false;
    offset = 0;
    _listPublications = widget._listPublications;
    DropdownMenuItem item1 = DropdownMenuItem(value: 0, child: Text("Más recientes"));
    DropdownMenuItem item2 = DropdownMenuItem(value: 1, child: Text("Más antiguos"));
    DropdownMenuItem item3 = DropdownMenuItem(value: 2, child: Text("Más comentados"));
    items.add(item1);
    items.add(item2);
    items.add(item3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget._profile.userId);
    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(context),
      body: SymmetricEdgePaddingWidget.horizontal(
        paddingValue: 6,
        child: Column(
          children: <Widget>[_buildOrderBy(), _buildPublications(), _buildProgressCircle()],
        ),
      ),
    );
  }

  Widget _buildProgressCircle() {
    if (isLoading) {
      return CircularProgressIndicator();
    } else {
      return Container();
    }
  }

  Widget _buildOrderBy() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              "Ordenar por:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Expanded(flex: 4, child: _getDropDown()),
          Expanded(
            flex: 3,
            child: FilterButtonWidget(
              callBack: _fetchFilters,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getDropDown() {
    GlobalKey key = GlobalKey();
    DropdownMenuItem dropdownValue;
    if (_selected != null) {
      dropdownValue = _selected;
    } else {
      dropdownValue = this.items[0];
    }
    return DropdownButton<DropdownMenuItem>(
      key: key,
      value: dropdownValue,
      style: TextStyle(color: Colors.black),
      onChanged: _onChangeDropDown,
      items: this.items.map<DropdownMenuItem<DropdownMenuItem>>((DropdownMenuItem value) {
        return DropdownMenuItem<DropdownMenuItem>(
          value: value,
          child: value.child,
        );
      }).toList(),
    );
  }

  void _onChangeDropDown(DropdownMenuItem newValue) {
    return setState(() {
      this._selected = newValue;
      _onChangedOrderBy(newValue.value);
    });
  }

  void _onChangedOrderBy(int newValue) {
    List<ForumPublication> orderedPublications = this._listPublications;
    switch (newValue) {
      case 0:
        {
          orderedPublications.sort((a, b) => a.date.compareTo(b.date));
        }
        break;
      case 1:
        {
          orderedPublications.sort((a, b) => b.date.compareTo(a.date));
        }
        break;
      case 2:
        {
          //orderedPublications.sort((a, b) => b.comments.length.compareTo(a.comments.length));
        }
    }
    setState(() {
      this._listPublications = orderedPublications;
    });
  }

  void _fetchFilters(Filters filters) {
    print(filters.selectedLevel);
    print(filters.selectedSubject);
    print(filters.dateFrom);
    print(filters.dateTo);
    Filters newFilter = filters;
    setState(() {
      //widget._callBack(newFilter);
    });
  }

  Widget _buildPublications() {
    return Expanded(flex: 10, child: _buildForumPublicationsList());
  }

  Widget _buildForumPublicationsList() {
    this._scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent == _scrollController.position.pixels) {
        if (isLoading == false && noMorePages==false) {
          setState(() {
            isLoading = !isLoading;
          });
          fetchMorePublications();
        }
      }
    });
    return ListView.builder(
      scrollDirection: Axis.vertical,
      controller: this._scrollController,
      itemCount: this._listPublications.length,
      itemBuilder: (BuildContext context, int index) {
        ForumPublication forumPublication = this._listPublications[index];
        return _buildStudentNoteCardWidget(forumPublication, index);
      },
    );
  }

  Widget _buildStudentNoteCardWidget(ForumPublication forumPublication, index) {
    bool isOwner = false;
    if (forumPublication.userId == widget._profile.userId) {
      isOwner = true;
    }
    return PublicationItemWidget(
      forumPublication: forumPublication,
      isOwner: isOwner,
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _onFloatingPressed(context);
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 40,
      ),
      backgroundColor: Colors.amber,
    );
  }

  void _onFloatingPressed(BuildContext context) async {
    BlocProvider.of<InstitutionForumCubit>(context).createNewForumPublicationState();
  }

  void fetchMorePublications() async {
    var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
    var careerService = sessionFactory.studentCareerService();
    var forumService = sessionFactory.forumService();
    var programId = await careerService.getCurrentProgram();
    List<ForumPublication> forumPublications =
        await forumService.getForumPublications(programId, this.offset + 10);
    if(forumPublications.isNotEmpty){
      setState(() {
        this.offset = this.offset + 10;
        widget._listPublications.addAll(forumPublications);
        this.isLoading = !isLoading;
      });
    }else{
      setState(() {
        noMorePages = true;
        this.isLoading = !isLoading;
      });
    }
  }
}

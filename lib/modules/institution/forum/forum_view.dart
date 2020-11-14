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
import 'package:universy/text/text.dart';
import 'package:universy/widgets/paddings/edge.dart';

import 'bloc/cubit.dart';

class ForumViewWidget extends StatefulWidget {
  final List<ForumPublication> _listPublications;
  final Profile _profile;
  final List<String> _filters;

  const ForumViewWidget(
      {Key key,
      @required List<ForumPublication> forumPublications,
      Profile profile,
      List<String> filters})
      : this._listPublications = forumPublications,
        this._profile = profile,
        this._filters = filters,
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
    DropdownMenuItem item1 = DropdownMenuItem(
        value: 0, child: Text(AppText.getInstance().get("institution.forum.filter.mostRecent")));
    DropdownMenuItem item2 = DropdownMenuItem(
        value: 1, child: Text(AppText.getInstance().get("institution.forum.filter.older")));
    DropdownMenuItem item3 = DropdownMenuItem(
        value: 2, child: Text(AppText.getInstance().get("institution.forum.filter.moreComment")));
    DropdownMenuItem item4 = DropdownMenuItem(
        value: 3, child: Text(AppText.getInstance().get("institution.forum.filter.morePopular")));
    DropdownMenuItem item5 = DropdownMenuItem(
        value: 4,
        child: Text(AppText.getInstance().get("institution.forum.filter.myPublications")));
    items.add(item1);
    items.add(item2);
    items.add(item3);
    items.add(item4);
    items.add(item5);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              AppText.getInstance().get("institution.forum.filter.orderBy"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Expanded(flex: 4, child: _getDropDown()),
          Expanded(
            flex: 3,
            child: FilterButtonWidget(),
          ),
        ],
      ),
    );
  }

  Widget _getDropDown() {
    GlobalKey key = GlobalKey();
    DropdownMenuItem dropdownValue;
    return DropdownButton<DropdownMenuItem>(
      key: key,
      hint: Text(
        "-",
        textAlign: TextAlign.center,
      ),
      value: (this._selected == null) ? dropdownValue : this._selected,
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
          orderedPublications.sort((a, b) => b.date.compareTo(a.date));
        }
        break;
      case 1:
        {
          orderedPublications.sort((a, b) => a.date.compareTo(b.date));
        }
        break;
      case 2:
        {
          orderedPublications.sort((a, b) => b.comments.compareTo(a.comments));
        }
        break;
      case 3:
        {
          orderedPublications.sort((a, b) => b.votes.compareTo(a.votes));
        }
        break;
      case 4:
        {
          List<ForumPublication> list = [];
          for (ForumPublication x in this._listPublications) {
            if (x.userId == widget._profile.userId) {
              list.add(x);
            }
          }
          for (ForumPublication x in this._listPublications) {
            if (x.userId != widget._profile.userId) {
              list.add(x);
            }
          }
          orderedPublications = list;
        }
        break;
    }
    setState(() {
      this._listPublications = orderedPublications;
    });
  }

  List<ForumPublication> _fetchMyPublication() {
    List<ForumPublication> list = [];
    for (ForumPublication x in this._listPublications) {
      if (x.userId == widget._profile.userId) {
        list.add(x);
      }
    }
    for (ForumPublication x in this._listPublications) {
      if (x.userId != widget._profile.userId) {
        list.add(x);
      }
    }
    return list;
  }

  Widget _buildPublications() {
    return Expanded(flex: 10, child: _buildForumPublicationsList());
  }

  Widget _buildForumPublicationsList() {
    this._scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent == _scrollController.position.pixels) {
        if (isLoading == false && noMorePages == false) {
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
    print(widget._filters);
    List<ForumPublication> forumPublications = await forumService.getForumPublications(
        programId, this.offset + 10, widget._profile.userId, widget._filters);
    if (forumPublications.isNotEmpty) {
      setState(() {
        this.offset = this.offset + 10;
        widget._listPublications.addAll(forumPublications);
        this.isLoading = !isLoading;
      });
    } else {
      setState(() {
        noMorePages = true;
        this.isLoading = !isLoading;
      });
    }
  }
}

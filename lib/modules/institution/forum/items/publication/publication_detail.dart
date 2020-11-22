import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:linkwell/linkwell.dart';
import 'package:universy/constants/regex.dart';
import 'package:universy/model/account/profile.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/modules/institution/forum/bloc/cubit.dart';
import 'package:universy/modules/institution/forum/items/comments/comments-list.dart';
import 'package:universy/modules/institution/forum/items/comments/date_item.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';
import 'package:universy/widgets/formfield/decoration/builder.dart';
import 'package:universy/widgets/formfield/text/custom.dart';
import 'package:universy/widgets/formfield/text/validators.dart';
import 'package:universy/widgets/paddings/edge.dart';

class PublicationDetailWidget extends StatefulWidget {
  final ForumPublication _forumPublication;
  final List<Comment> _listComments;
  final Profile _profile;

  PublicationDetailWidget(
      {Key key, ForumPublication forumPublication, Profile profile, List<Comment> listComments})
      : this._forumPublication = forumPublication,
        this._profile = profile,
        this._listComments = listComments,
        super(key: key);

  @override
  _PublicationDetailWidgetState createState() => _PublicationDetailWidgetState();
}

class _PublicationDetailWidgetState extends State<PublicationDetailWidget> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _newCommentController = TextEditingController();
  bool _newComment;
  List<Comment> _listComments;
  final _formKey = GlobalKey<FormState>();

  List<String> urlList = [];

  @override
  void initState() {
    _listComments = widget._listComments;
    _newComment = false;
    _checkUrl();
    super.initState();
  }

  @override
  void dispose() {
    _listComments = null;
    _newComment = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: _scrollController,
        child: SymmetricEdgePaddingWidget.vertical(
          paddingValue: 10,
          child: SymmetricEdgePaddingWidget.horizontal(
            paddingValue: 10,
            child: Column(
              children: <Widget>[
                _buildPublication(),
                _buildExtraInfoComments(),
                _buildComments(),
                _buildNewCommentBox(),
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildFloatingActionButton() {
    if (_newComment != true) {
      return FloatingActionButton(
        onPressed: onPressed,
        child: Icon(Icons.add_comment, color: Colors.white, size: 30),
      );
    } else {
      SizedBox.shrink();
    }
  }

  Widget _buildExtraInfoComments() {
    int comments = 0;
    if (widget._listComments != null) {
      comments = widget._listComments.length;
    }
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.comment,
            size: 30,
            color: Colors.grey,
          ),
          SymmetricEdgePaddingWidget.horizontal(
              paddingValue: 10,
              child: Text(
                "${comments}" + AppText.getInstance().get("institution.forum.publication.comments"),
                style: TextStyle(color: Colors.grey, fontSize: 18),
              )),
        ],
      ),
    );
  }

  Widget _buildNewCommentBox() {
    if (_newComment == true) {
      return Card(
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: new BorderSide(color: Colors.deepPurple, width: 2.0)),
        elevation: 1,
        child: SymmetricEdgePaddingWidget.vertical(
          paddingValue: 10,
          child: SymmetricEdgePaddingWidget.horizontal(
            paddingValue: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SymmetricEdgePaddingWidget.vertical(
                    paddingValue: 5,
                    child: Text(
                      widget._profile.alias,
                      style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                    )),
                CustomTextFormField(
                  controller: _newCommentController,
                  validatorBuilder: NotEmptyTextFormFieldValidatorBuilder(AppText.getInstance()
                      .get("institution.forum.publication.errorMessageComment")),
                  decorationBuilder: ForumInputNewCommentBuilder(
                      AppText.getInstance().get("institution.forum.publication.hintComment")),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  _buildActionButtons() {
    if (_newComment == true) {
      return SymmetricEdgePaddingWidget.vertical(
          paddingValue: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SaveButton(onSave: () => _createCommentAction()),
              CancelButton(onCancel: () => _cancelButtonAction()),
            ],
          ));
    } else {
      return Container();
    }
  }

  void _createCommentAction() {
    if (this._formKey.currentState.validate()) {
      BlocProvider.of<InstitutionForumCubit>(context).addComment(
          widget._forumPublication,
          widget._profile.userId,
          this._newCommentController.text,
          widget._forumPublication.idPublication);
    }
  }

  void _cancelButtonAction() {
    setState(() {
      _newComment = false;
      _scrollController.animateTo(
        0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 1000),
      );
    });
  }

  Widget _buildComments() {
    return CommentsListWidget(
      commentsList: _listComments,
      profile: widget._profile,
    );
  }

  Widget _buildPublication() {
    return Card(
      elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildPublicationHeader(),
          Divider(),
          _buildPublicationBody(),
          _buildPublicationVotes(),
        ],
      ),
    );
  }

  Widget _buildPublicationVotes() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          (widget._forumPublication.idVoteUser == null)
              ? IconButton(
                  icon: Icon(
                    Icons.thumb_up,
                    size: 30,
                    color: Colors.grey,
                  ),
                  onPressed: () => _onVote(),
                )
              : IconButton(
                  icon: Icon(
                    Icons.thumb_up,
                    size: 30,
                    color: Colors.black,
                  ),
                  onPressed: () => _onDeleteVote(),
                ),
          Text(
            widget._forumPublication.votes.toString(),
            style: TextStyle(fontSize: 23),
          ),
        ],
      ),
    );
  }

  Widget _buildPublicationBody() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildPublicationDescription(),
          (urlList.isNotEmpty) ? Divider(): Container(),
          _buildLinks(),
          Divider(),
          _buildTags(),
        ],
      ),
    );
  }

  Widget _buildPublicationHeader() {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: _buildUserName()),
          Expanded(flex: 4, child: _buildPublicationTitle()),
          _buildDate(),
        ],
      ),
    );
  }

  _buildLinks() {
    if (urlList.isNotEmpty) {
      String url = '';
      int count=1;
      for (String x in urlList) {
        url += "\nLink $count:  $x \n";
        count+=1;
      }
      return LinkWell("$url",style: TextStyle(fontSize: 14,color: Colors.black),linkStyle: TextStyle(fontSize: 15,color: Colors.lightBlue,fontStyle: FontStyle.italic),);
    } else {
      return Container();
    }
  }

  void _onVote() {
    BlocProvider.of<InstitutionForumCubit>(context).addVotePublication(
      widget._forumPublication,
      widget._profile.userId,
    );
    setState(() {
      widget._forumPublication.votes = widget._forumPublication.votes + 1;
      widget._forumPublication.idVoteUser = widget._profile.userId;
    });
  }

  void _onDeleteVote() {
    BlocProvider.of<InstitutionForumCubit>(context).deleteVotePublication(
      widget._forumPublication.idVoteUser,
      true,
    );
    setState(() {
      widget._forumPublication.votes = widget._forumPublication.votes - 1;
      widget._forumPublication.idVoteUser = null;
    });
  }

  Widget _buildUserName() {
    String alias = (widget._forumPublication.userAlias == null)
        ? AppText.getInstance().get("institution.forum.publication.defaultUser")
        : widget._forumPublication.userAlias;
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 10,
      child: Column(
        children: <Widget>[
          Icon(Icons.perm_identity),
          Text(
            alias,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPublicationTitle() {
    return Text(
      this.widget._forumPublication.title,
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget _buildDate() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 5,
      child: DateItemWidget(
        date: widget._forumPublication.date,
        withTime: true,
      ),
    );
  }

  Widget _buildPublicationDescription() {
    return Text(
      this.widget._forumPublication.description,
      style: TextStyle(fontSize: 16),
      overflow: TextOverflow.visible,
    );
  }

  Widget _buildTags() {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 10,
      child: Tags(
        spacing: 1.0,
        runSpacing: 1.5,
        alignment: WrapAlignment.start,
        itemCount: widget._forumPublication.tags.length,
        itemBuilder: (int index) {
          return ItemTags(
            key: Key(index.toString()),
            index: index,
            title: "${widget._forumPublication.tags[index]}",
            pressEnabled: false,
            activeColor: Colors.grey[350],
            color: Colors.grey[350],
            textActiveColor: Colors.black,
            textColor: Colors.black,
            elevation: 0,
            textStyle: TextStyle(
              fontSize: 10,
            ),
            combine: ItemTagsCombine.withTextBefore,
          );
        },
      ),
    );
  }

  void onPressed() {
    setState(() {
      _newComment = true;
      _scrollController.animateTo(
        500,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 1000),
      );
    });
  }

  void _checkUrl() {
    List<String> list = widget._forumPublication.description.split(" ");
    var pattern = Regex.URL_DETECT;
    for (String x in list) {
      if (pattern.hasMatch(x)) {
        Iterable<Match> matches = pattern.allMatches(x);
        urlList.add(matches.first.group(0));
      }
    }
    print(urlList);
  }
}

//while (match != null) {
//const link = textToCheck.substr(match.index, match[0].length);
//splitText.push(link);
//startIndex = match.index + match[0].length;
//match = regex.exec(textToCheck);
//}
//return
//splitText;

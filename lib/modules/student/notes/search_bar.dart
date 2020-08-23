import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/constants/strings.dart';
import 'package:universy/model/student/notes.dart';
import 'package:universy/modules/student/notes/bloc/cubit.dart';
import 'package:universy/text/comparators/search_comparator.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/paddings/edge.dart';

class SearchNotesBarWidget extends StatefulWidget {
  final List<StudentNote> notes;

  const SearchNotesBarWidget({Key key, @required this.notes}) : super(key: key);

  @override
  _SearchNotesBarWidgetState createState() => _SearchNotesBarWidgetState();
}

class _SearchNotesBarWidgetState extends State<SearchNotesBarWidget> {
  TextEditingController _searchTextEditingController;

  @override
  void initState() {
    _searchTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EdgePaddingWidget(
      EdgeInsets.all(15.0),
      TextField(
        onChanged: _filterSearchResults,
        maxLength: 40,
        controller: _searchTextEditingController,
        decoration: _buildNameSearchBarDecoration(),
      ),
    );
  }

  InputDecoration _buildNameSearchBarDecoration() {
    return InputDecoration(
      counterText: EMPTY_STRING,
      labelText: AppText.getInstance().get("student.notes.searchBar.title"),
      hintText: AppText.getInstance().get("student.notes.searchBar.input"),
      prefixIcon: Icon(Icons.search),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
    );
  }

  void _filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<StudentNote> filteredNotes = widget.notes
          .where(
            (note) => _notesMatchesQuery(note, query),
          )
          .toList();
      _filteredStudentNotesEvent(filteredNotes);
    } else {
      _filteredStudentNotesEvent(widget.notes);
    }
  }

  bool _notesMatchesQuery(StudentNote note, String query) {
    var nameComparator = TextSearchComparator(note.title);
    var descriptionComparator = TextSearchComparator(note.description);
    return nameComparator.isQueryInText(query) ||
        descriptionComparator.isQueryInText(query);
  }

  void _filteredStudentNotesEvent(List<StudentNote> filteredNotes) {
    BlocProvider.of<NotesCubit>(context).filterNotes(filteredNotes);
  }
}

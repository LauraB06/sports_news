import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';
import 'package:sports_news/modules/home_module/blocs/home_bloc.dart';
import 'package:sports_news/modules/home_module/blocs/home_bloc_events.dart';
import 'package:sports_news/shared/widgets/solid_app_bar_widget.dart';

class HomeFilterPage extends StatefulWidget {

  const HomeFilterPage({
    Key key,
    @required this.bloc,
  }) : super(key: key);

  final HomeBloc bloc;

  @override
  State<StatefulWidget> createState() => _HomeFilterPageState();
}

class _HomeFilterPageState extends State<HomeFilterPage> {
  List<DateTime> timeFilter = <DateTime>[];
  bool onlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    final TextStyle labelStyle = GoogleFonts.roboto(
      fontSize: 17,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    );

    return Scaffold(
      appBar: SolidAppBar(
        title: 'Filtro',
        onCancel: () => Navigator.of(context).pop(),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Limpar',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () => _clearFilters(context),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Data', style: labelStyle),
                    Expanded(
                      child: InkWell(
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                        onTap: () async {
                          final List<DateTime> picked =
                              await DateRagePicker.showDatePicker(
                            context: context,
                            initialFirstDate: DateTime.now()
                                .subtract(const Duration(days: 1)),
                            initialLastDate: DateTime.now(),
                            firstDate: DateTime(2010),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null && picked.length == 2) {
                            setState(() {
                              timeFilter = picked;
                            });
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                timeFilter.length == 2
                                    ? '${formatDate(timeFilter.first)} ~ ${formatDate(timeFilter.last)}'
                                    : 'Todas',
                                textAlign: TextAlign.end,
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 17,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            const IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xFFC7C7CC),
                              ),
                              onPressed: null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Apenas favoritos', style: labelStyle),
                    Switch(
                      value: onlyFavorites,
                      onChanged: (bool value) {
                        setState(() => onlyFavorites = value);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Material(
            color: const Color(0xFF010A53),
            child: InkWell(
              onTap: () => _filter(context),
              child: Container(
                // width: MediaQuery.of(context).size.width,
                child: SafeArea(
                  child: Align(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Text(
                        'Filtrar',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(DateTime time) {
    return DateFormat('dd/MM/yyyy').format(time);
  }

  void _filter(BuildContext context) {
    widget.bloc.add(
      HomeBlocEventFilter(
        time: timeFilter,
        onlyHighlighted: onlyFavorites,
      ),
    );
    Navigator.of(context).pop();
  }

  void _clearFilters(BuildContext context) {
    setState(() {
      onlyFavorites = false;
      timeFilter = <DateTime>[];
    });
  }
}

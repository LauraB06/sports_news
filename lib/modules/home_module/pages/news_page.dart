import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_news/modules/home_module/blocs/home_bloc.dart';
import 'package:sports_news/modules/home_module/blocs/home_bloc_events.dart';
import 'package:sports_news/shared/models/article_model.dart';
import 'package:sports_news/shared/widgets/solid_app_bar_widget.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({
    Key key,
    @required this.model,
    @required this.highligtedArticles,
  }) : super(key: key);

  final ArticleModel model;
  final List<ArticleModel> highligtedArticles;

  @override
  State<StatefulWidget> createState() => NewsPageState();
}

class NewsPageState extends State<NewsPage> {
  bool oposeList = false;

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat("dd/MM/yyyy kk'h'mm").format(
      widget.model.publishedAt.toUtc(),
    );
    return Scaffold(
      appBar: SolidAppBar(
        title: widget.model.title,
        subtitle: widget.model.url,
        onCancel: () => Navigator.of(context).pop(),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: <Widget>[
          _imageFromNetwork(widget.model.imageUrl),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  widget.highligtedArticles.contains(widget.model)
                      ? Icons.bookmark
                      : Icons.bookmark_outline,
                ),
                onPressed: () {
                  BlocProvider.of<HomeBloc>(context).add(
                    HomeBlocEventHighlight(article: widget.model),
                  );
                  setState(() => oposeList = !oposeList);
                },
              ),
              Text(
                formattedDate,
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          Text(
            widget.model.title,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.model.content,
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF010A53),
        onPressed: () => Share.share(widget.model.url),
        child: const Align(
          child: Icon(
            Icons.share,
          ),
        ),
      ),
    );
  }

  Widget _imageFromNetwork(String url) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (BuildContext context, Object exception, StackTrace _) {
        return const Align(child: Icon(Icons.warning));
      },
      loadingBuilder: (
        BuildContext context,
        Widget widget,
        ImageChunkEvent event,
      ) {
        if (event != null) {
          if (event.expectedTotalBytes == event.cumulativeBytesLoaded) {
            return widget;
          } else {
            return const Align(child: CircularProgressIndicator());
          }
        } else {
          return widget ?? const Align(child: CircularProgressIndicator());
        }
      },
    );
  }
}

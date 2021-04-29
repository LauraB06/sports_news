import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_news/core/interpreters.dart';
import 'package:sports_news/modules/home_module/blocs/home_bloc.dart';
import 'package:sports_news/modules/home_module/blocs/home_bloc_events.dart';
import 'package:sports_news/shared/models/article_model.dart';
import 'package:sports_news/shared/widgets/generic_button_widget.dart';
import 'package:sports_news/shared/widgets/solid_app_bar_widget.dart';

import 'home_filter_page.dart';
import 'news_page.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key key,
    this.highlights = const <ArticleModel>[],
    this.lastNews = const <ArticleModel>[],
    this.userHighlighted = const <ArticleModel>[],
    this.initialLoading = false,
  }) : super(key: key);

  final List<ArticleModel> highlights;
  final List<ArticleModel> lastNews;
  final List<ArticleModel> userHighlighted;
  final bool initialLoading;
  HomeBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<HomeBloc>(context);


    return Scaffold(
      appBar: SolidAppBar(
        title: 'Mesa News',
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () => _openFilterPage(context),
          ),
        ],
      ),
      body: initialLoading
          ? const Align(child: CircularProgressIndicator())
          : ListView(
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                _highlightArea(context),
                _lastNewsArea(context),
              ],
            ),
    );
  }

  Widget _highlightArea(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: _sectionText('Destaques'),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: highlights
                  .map(
                      (ArticleModel model) => _highlightArticle(model, context))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionText(String text) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  void _openArticle(ArticleModel model, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<NewsPage>(
        builder: (BuildContext context) => NewsPage(
          model: model,
          highligtedArticles: userHighlighted,
        ),
      ),
    );
  }

  Widget _highlightArticle(ArticleModel model, BuildContext context) {
    return InkWell(
      onTap: () => _openArticle(model, context),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width * 0.85,
        child: ConstrainedBox(
          constraints: const BoxConstraints.tightFor(height: 140),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 120,
                width: 120,
                child: _imageFromNetwork(model.imageUrl),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 16),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          model.title,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    _saveArticleWidget(model, context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _lastNewsArea(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 6),
          child: _sectionText('Últimas notícias'),
        ),
        ...lastNews
            .map((ArticleModel model) => _article(model, context))
            .toList(),
        GenericButton(
          title: 'Load more',
          onPressed: () {
            BlocProvider.of<HomeBloc>(context).add(HomeBlocEventLoadMore());
          },
        ),
      ],
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

  Widget _article(ArticleModel model, BuildContext context) {
    return InkWell(
      onTap: () => _openArticle(model, context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 6 / 2.2,
              child: _imageFromNetwork(model.imageUrl),
            ),
            _saveArticleWidget(model, context, expanded: true),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                model.title,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                model.description,
                style: GoogleFonts.roboto(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Divider(
                color: Color(0xFFD3D3D3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _saveArticleWidget(ArticleModel model, BuildContext context,
      {bool expanded = false}) {
    final bool isHighlighted = userHighlighted.contains(model);
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: Icon(
            !isHighlighted ? Icons.bookmark_outline : Icons.bookmark,
            color: const Color(0xFF010A53),
          ),
          onPressed: () {
            BlocProvider.of<HomeBloc>(context).add(
              HomeBlocEventHighlight(article: model),
            );
          },
        ),
        Expanded(
          child: Text(
            Interpreters.timeDelta(model.publishedAt.toUtc()),
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              fontStyle: FontStyle.italic,
            ),
            textAlign: expanded ? TextAlign.right : TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  void _openFilterPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<HomeFilterPage>(
        builder: (BuildContext context) => HomeFilterPage(
          bloc: bloc,
        ),
      ),
    );
  }
}

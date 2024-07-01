import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constant/colors.dart';
import '../../domain/entities/book/book.dart';
import '../../core/constant/size.dart';

class BookCard extends StatelessWidget {
  final Book? book;
  final Function? onFavoriteToggle;
  final Function? onClick;

  const BookCard({
    super.key,
    this.book,
    this.onFavoriteToggle,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return book == null ? _buildShimmerCard(context) : _buildBookCard(context);
  }

  Widget _buildShimmerCard(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade100,
      highlightColor: Colors.white,
      child: _buildCardContent(context),
    );
  }

  Widget _buildBookCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onClick != null) {
          onClick!();
        }
      },
      child: _buildCardContent(context),
    );
  }

  Widget _buildCardContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildBookImage(context),
        _buildAuthorName(context),
        _buildBookTitle(context),
      ],
    );
  }

  Widget _buildBookImage(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(defaultRadius / 2),
        child: book == null
            ? Material(
                child: GridTile(
                  footer: Container(),
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
              )
            : Hero(
                tag: book!.id,
                child: CachedNetworkImage(
                  imageUrl: book!.getCoverImageUrl() ?? '',
                  fit: BoxFit.contain,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade100,
                    highlightColor: Colors.white,
                    child: Container(),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: FaIcon(
                      FontAwesomeIcons.circleExclamation,
                      color: kGreyColor,
                      size: 20,
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildAuthorName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
      child: SizedBox(
        child: book == null
            ? Container(
                height: 12,
                width: 77,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              )
            : Text(
                book?.authors.isNotEmpty ?? false
                    ? book!.authors.first.name ?? ''
                    : 'Unknown Author',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: Theme.of(context).textTheme.labelSmall,
              ),
      ),
    );
  }

  Widget _buildBookTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
      child: SizedBox(
        child: book == null
            ? Container(
                height: 20,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              )
            : Text(
                book?.title ?? 'Unknown Title',
                maxLines: 3,
                textAlign: TextAlign.center,
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.labelLarge,
              ),
      ),
    );
  }
}

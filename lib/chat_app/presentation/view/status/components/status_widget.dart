import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:whatsapp/chat_app/domain/entities/status_entity.dart';
import 'package:whatsapp/chat_app/domain/entities/user_entity.dart';
import 'package:whatsapp/chat_app/presentation/viewmodel/user_info_viewmodel.dart';
import 'package:whatsapp/core/resources/colors_manager.dart';
import 'package:whatsapp/core/resources/widgets/app_images.dart';

class StatusItemWidget extends ConsumerWidget {
  const StatusItemWidget(
      {super.key,
      required this.status,
      required this.onTap,
      this.onOwnStatusTap,
      this.ownHasStatus = false,
      this.isOwn = false});
  final StatusEntity status;
  final VoidCallback? onOwnStatusTap;
  final VoidCallback onTap;
  final bool ownHasStatus;
  final bool isOwn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            !ownHasStatus
                ? Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 54,
                          height: 54,
                          child: CustomPaint(
                            painter: DottedBorder(numberOfStories: status.photoUrl.length),
                          ),
                        ),
                        AppCachedImage(
                          url: status.photoUrl[0],
                          width: 48,
                          height: 48,
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ],
                    ),
                  )
                : Stack(
                    children: [
                      (status.profilePic == '' || status.profilePic == null)
                          ? AppAssetImage(
                              AppImages.defaultProfilePicture,
                              width: 48,
                              height: 48,
                              borderRadius: BorderRadius.circular(24),
                            )
                          : AppCachedImage(
                              url: status.profilePic!,
                              width: 48,
                              height: 48,
                              borderRadius: BorderRadius.circular(24),
                            ),
                    ],
                  ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    status.username,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      // fontWeight: FontWeight.w500,
                      fontFamily: 'Neue Helvetica',
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (!isOwn)
                    Text(
                      DateFormat("hh:m a").format(status.createdAt),
                      style: TextStyle(
                        color: AppColors.colors.neutral14, // AppColors.colors.black.withAlpha(145),
                        fontSize: 14,
                      ),
                    )
                  else
                    Text(
                      'Tap to add status update',
                      style: TextStyle(
                        color: AppColors.colors.neutral14, // AppColors.colors.black.withAlpha(145),
                        fontSize: 14,
                      ),
                    )
                ],
              ),
            ),
            if (onOwnStatusTap != null)
              IconButton(
                onPressed: onOwnStatusTap,
                icon: const Icon(Icons.more_horiz),
                color: AppColors.colors.primary,
                splashColor: AppColors.colors.transparent,
              )
          ],
        ),
      ),
    );
  }
}

// 01024015950
class DottedBorder extends CustomPainter {
  //number of stories
  final int numberOfStories;
  //length of the space arc (empty one)
  final int seenStatusCount;
  //start of the arc painting in degree(0-360)
  double startOfArcInDegree = 90;

  DottedBorder({required this.numberOfStories, this.seenStatusCount = 0});

  //drawArc deals with rads, easier for me to use degrees
  //so this takes a degree and change it to rad
  double inRads(double degree) {
    return (degree * pi) / 180;
  }

  @override
  bool shouldRepaint(DottedBorder oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    //circle angle is 360, remove all space arcs between the main story arc (the number of spaces(stories) times the  space length
    //then subtract the number from 360 to get ALL arcs length
    //then divide the ALL arcs length by number of Arc (number of stories) to get the exact length of one arc
    double arcLength = (360 - (numberOfStories * 6)) / numberOfStories;

    //be careful here when arc is a negative number
    //that happens when the number of spaces is more than 360
    //feel free to use what logic you want to take care of that
    //note that numberOfStories should be limited too here
    if (arcLength <= 0) {
      arcLength = 360 / 6 - 1; //
    }

    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    //looping for number of stories to draw every story arc
    for (int i = 1; i <= numberOfStories; i++) {
      //printing the arc
      canvas.drawArc(
          rect,
          inRads(startOfArcInDegree),
          //be careful here is:  "double sweepAngle", not "end"
          inRads(arcLength),
          false,
          Paint()
            //here you can compare your SEEN story index with the arc index to make it grey
            ..color = i <= seenStatusCount ? AppColors.colors.grey : AppColors.colors.primary
            ..strokeWidth = 2.0
            ..style = PaintingStyle.stroke);

      //the logic of spaces between the arcs is to start the next arc after jumping the length of space
      startOfArcInDegree += arcLength + 6;
    }
  }
}

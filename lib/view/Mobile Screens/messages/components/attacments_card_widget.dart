import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:visitors/resource/constants/app_colors.dart';


class AttachmentCard extends StatelessWidget {
  final String filePath;
  final void Function()? onDeletePressed;

  const AttachmentCard(
      {super.key, required this.filePath, this.onDeletePressed});

  bool _isImageFile(String path) {
    final extension = p.extension(path).toLowerCase();
    return ['.jpg', '.jpeg', '.png', '.gif'].contains(extension);
  }

  Widget _buildFilePreview() {
    if (_isImageFile(filePath)) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          File(filePath),
          fit: BoxFit.cover,
          height: 60,
          width: 60,
        ),
      );
    } else {
      IconData fileIcon;
      switch (p.extension(filePath).toLowerCase()) {
        case '.pdf':
          fileIcon = Icons.picture_as_pdf;
          break;
        case '.doc':
        case '.docx':
          fileIcon = Icons.description;
          break;
        case '.xls':
        case '.xlsx':
          fileIcon = Icons.table_chart;
          break;
        default:
          fileIcon = Icons.insert_drive_file;
      }
      return Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          fileIcon,
          size: 30,
          color: Colors.grey[700],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0,vertical: 3.0),
          child: Column(
            children: [
              Stack( 
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  _buildFilePreview(),
                  InkWell(
                    onTap: onDeletePressed,
                    child: Container(
                      padding:const  EdgeInsets.all(4.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle, 
                      color:AppColors.white,
                      //withValues(alpha: 0.5),
                    ),
                    child: const Icon(Icons.close, color: AppColors.red,),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}

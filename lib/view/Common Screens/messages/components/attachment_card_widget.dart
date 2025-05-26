import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import '../../../../resource/constants/app_colors.dart';

class AttachmentCardWidget extends StatelessWidget {
  final String filePath;
  final void Function()? onDeletePressed;

  const AttachmentCardWidget({super.key, required this.filePath, this.onDeletePressed});

  bool _isImageFile(String path) {
    final extension = p.extension(path).toLowerCase();
    return ['.jpg', '.jpeg', '.png', '.gif'].contains(extension);
  }

  Widget _buildFilePreview() {
    if (_isImageFile(filePath)) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(
          File(filePath),
          fit: BoxFit.cover,
          height: 80,
          width: 80,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported_outlined, color: AppColors.darkGrey,),
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
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Icon(
            fileIcon,
            size: 40,
            color: Colors.grey[700],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 80,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                _buildFilePreview(),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: AppColors.darkGrey, width: 0.3)
                    ),
                    child: IconButton(
                      focusColor: Colors.transparent,
                      color:  Colors.transparent,
                      hoverColor:  Colors.transparent,
                      splashColor:  Colors.transparent,
                      highlightColor:  Colors.transparent,
                      icon: const Icon(Icons.close, color: Colors.red, size: 16),
                      onPressed: onDeletePressed,
                      padding: const EdgeInsets.all(4),
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

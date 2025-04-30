import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/resource/styles/styles.dart';

import '../../../../resource/constants/app_colors.dart';
class ServicesDocumentsCardWidget extends StatelessWidget {
  final String? name;
  const ServicesDocumentsCardWidget({super.key,
    this.name,
  });
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Icon(CupertinoIcons.doc_text_fill,color: AppColors.primary,size: 20,),
        Gap(5),
        Text(name ?? "",style: AppTextStyles.style12Black600,),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    var iconColor = Colors.lime.shade300;

    return ListTile(
      onTap: onPress,
      leading: Container(
        width: screenWidth * 0.12,
        height: screenWidth * 0.12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth * 0.06),
          color: iconColor.withOpacity(0.1),
        ),
        child: Icon(icon, color: iconColor, size: screenWidth * 0.06),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText2?.apply(color: textColor),
      ),
      trailing: endIcon
          ? Container(
              width: screenWidth * 0.08,
              height: screenWidth * 0.08,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Icon(
                LineAwesomeIcons.angle_right,
                size: screenWidth * 0.04,
                color: Colors.grey,
              ),
            )
          : null,
    );
  }
}

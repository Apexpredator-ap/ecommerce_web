import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/profile_controller.dart';
import '../../utils/colors.dart';
import '../auth/login_screen.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: Column(
        children: [
          // Drawer Header with Close Button
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            color: AppColors.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<AuthProvider>(
                  builder: (context, auth, child) {
                    return Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: AppColors.accent,
                              child: auth.userName != null
                                  ? Text(
                                auth.userName!.substring(0, 1).toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                                  : const Icon(Icons.person, color: Colors.white),
                            ),
                            Positioned(
                              bottom: -2,
                              right: -2,
                              child: GestureDetector(
                                onTap: () {
                                  ProfileController.showEditProfileDialog(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: AppColors.accent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              auth.userName ?? "User",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              auth.userEmail ?? "user@example.com",
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Menu Options
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                _buildDrawerItem(
                  icon: Icons.person_outline,
                  label: "Edit Profile",
                  onTap: () => ProfileController.showEditProfileDialog(context),
                ),
                _buildDrawerItem(
                  icon: Icons.lock_outline,
                  label: "Change Password",
                  onTap: () => ProfileController.showChangePasswordDialog(context),
                ),
                _buildDrawerItem(
                  icon: Icons.notifications_outlined,
                  label: "Notifications",
                  onTap: () {
                    // TODO: Implement notifications settings
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.help_outline,
                  label: "Help & Support",
                  onTap: () {
                    // TODO: Implement help section
                  },
                ),
              ],
            ),
          ),

          // Sign Out Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () => ProfileController.showSignOutDialog(context),
              icon: const Icon(Icons.logout),
              label: const Text("Sign Out"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 28),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      onTap: onTap,
      horizontalTitleGap: 20,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }
}


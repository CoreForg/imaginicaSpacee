import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../services/auth_service.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final authService = context.read<AuthService>();
    final success = await authService.login(
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      context.go('/admin/dashboard');
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Invalid email or password';
      });
    }
  }

  InputDecoration _inputDecoration(
    String label, {
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 14),
      floatingLabelStyle: GoogleFonts.inter(color: AppColors.accent, fontSize: 12),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: AppColors.surfaceHighlight,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      errorStyle: GoogleFonts.inter(fontSize: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        gradient: AppColors.accentGradient,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.admin_panel_settings_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Imaginica ',
                            style: GoogleFonts.inter(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                            ),
                          ),
                          TextSpan(
                            text: 'Space',
                            style: GoogleFonts.inter(
                              color: AppColors.accent,
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Admin Portal',
                      style: GoogleFonts.inter(
                        color: AppColors.secondaryText,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 36),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 14),
                      decoration: _inputDecoration(
                        'Email',
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: AppColors.mutedText,
                          size: 20,
                        ),
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) return 'Email is required';
                        final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                        if (!emailRegex.hasMatch(val.trim())) return 'Enter a valid email address';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 14),
                      decoration: _inputDecoration(
                        'Password',
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                          color: AppColors.mutedText,
                          size: 20,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.mutedText,
                            size: 20,
                          ),
                          onPressed: () =>
                              setState(() => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                      validator: (val) =>
                          (val == null || val.isEmpty) ? 'Password is required' : null,
                      onFieldSubmitted: (_) => _login(),
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline_rounded, color: Colors.red, size: 16),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _errorMessage!,
                                style: GoogleFonts.inter(color: Colors.red, fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: AppColors.accent.withValues(alpha: 0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'Login',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

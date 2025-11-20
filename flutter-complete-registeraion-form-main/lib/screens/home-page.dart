import 'package:flutter/material.dart';
import 'package:hw1mobile/screens/colors.dart';
import 'package:hw1mobile/widgets/buttons.dart';
import 'package:hw1mobile/widgets/text_form.dart';

//الاسم:رامي شيخ
class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formstate = GlobalKey<FormState>();

  String? _fullName;
  String? _emailAddress;
  String? _password;
  String? _phoneNumber;
  int? _age;
  String? _gender;
  String? _country;
  DateTime? _birthDate;
  TimeOfDay? _preferredTime;
  String? _experienceLevel;
  final List<String> _selectedSkills = [];
  String? _bio;
  double _satisfactionRating = 3.0;
  double _progressLevel = 50.0;
  RangeValues _budgetRange = const RangeValues(20, 80);
  bool _isSubscribed = true;
  bool _agreedToTerms = false;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _countries = [
    'Sanaa',
    'Aden',
    'Taiz',
    'Hodeidah',
    'Ibb',
    'Dhamar',
    'Lahij',
    'Marib',
    'Al Hudaydah',
    'Al Mahwit',
    'Other',
  ];
  final List<String> _experienceLevels = ['Beginner', 'Intermediate', 'Expert'];
  final List<String> _availableSkills = [
    'Flutter',
    'Dart',
    'Firebase',
    'API Integration',
    'State Management',
    'UI/UX Design',
    'Testing',
  ];

  String? _requiredValidator(String? value) {
    if (value == null || value.isEmpty) return 'هذا الحقل مطلوب';
    return null;
  }

  String? _dropdownValidator(dynamic value) {
    if (value == null) return 'الرجاء اختيار قيمة';
    return null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _birthDate) {
      setState(() => _birthDate = picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _preferredTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _preferredTime) {
      setState(() => _preferredTime = picked);
    }
  }

  Widget _buildSkillChip(String skill) {
    final isSelected = _selectedSkills.contains(skill);
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
      child: ChoiceChip(
        label: Text(skill),
        selected: isSelected,
        selectedColor: AppColors.Ban,
        backgroundColor: AppColors.greyLight,
        labelStyle: TextStyle(
          color: isSelected ? AppColors.buttonSecondary : AppColors.greyDark,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        onSelected: (selected) {
          setState(() {
            if (selected)
              _selectedSkills.add(skill);
            else
              _selectedSkills.remove(skill);
          });
        },
      ),
    );
  }

  void _submitForm() {
    if (_formstate.currentState!.validate()) {
      _formstate.currentState!.save();

      if (!_agreedToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'You must agree to the Terms and Conditions to submit.',
            ),
          ),
        );
        return;
      }

      debugPrint('--- Form Submission Data ---');
      debugPrint('Full Name: $_fullName');
      debugPrint('Email Address: $_emailAddress');
      debugPrint('Password: $_password');
      debugPrint('Phone Number: $_phoneNumber');
      debugPrint('Age: $_age');
      debugPrint('Gender: $_gender');
      debugPrint('Country: $_country');
      debugPrint('-----------------------------');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Form Submitted Successfully! Data printed to Terminal.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formstate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Personal Information",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 10),
                TextForm(
                  plceHolder: 'Full Name',
                  icon: Icons.person,
                  validator: _requiredValidator,
                  onSaved: (value) => _fullName = value,
                ),
                TextForm(
                  plceHolder: 'Email Address',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'هذا الحقل مطلوب';
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))
                      return 'الرجاء إدخال بريد إلكتروني صحيح';
                    return null;
                  },
                  onSaved: (value) => _emailAddress = value,
                ),
                TextForm(
                  plceHolder: 'Password',
                  icon: Icons.lock,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.length < 6)
                      return 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';
                    return null;
                  },
                  onSaved: (value) => _password = value,
                ),
                TextForm(
                  plceHolder: 'Phone Number',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  onSaved: (value) => _phoneNumber = value,
                ),
                TextForm(
                  plceHolder: 'Age',
                  icon: Icons.cake,
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _age = int.tryParse(value ?? ''),
                ),

                const SizedBox(height: 24),
                Text(
                  'Demographics',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 16),

                DropdownForm(
                  plceHolder: 'Select your gender',
                  options: _genders,
                  icon: Icons.wc,
                  validator: _dropdownValidator,
                  onSaved: (value) => _gender = value,
                ),

                DropdownForm(
                  plceHolder: 'Select your country',
                  options: _countries,
                  icon: Icons.location_on,
                  validator: _dropdownValidator,
                  onSaved: (value) => _country = value,
                ),

                const SizedBox(height: 24),
                Text(
                  'Date & Time',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: const Icon(
                          Icons.calendar_today,
                          color: Colors.blue,
                        ),
                        label: Text(
                          _birthDate == null
                              ? 'Birth Date'
                              : '${_birthDate!.year}-${_birthDate!.month}-${_birthDate!.day}',
                          style: TextStyle(
                            color: _birthDate == null
                                ? AppColors.greyDark
                                : AppColors.textDark,
                          ),
                        ),
                        onPressed: () => _selectDate(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18.0),
                          side: BorderSide(color: AppColors.textLight),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.access_time, color: Colors.blue),
                        label: Text(
                          _preferredTime == null
                              ? 'Preferred Time'
                              : _preferredTime!.format(context),
                          style: TextStyle(
                            color: _preferredTime == null
                                ? AppColors.greyDark
                                : AppColors.textDark,
                          ),
                        ),
                        onPressed: () => _selectTime(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18.0),
                          side: BorderSide(color: AppColors.textLight),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                Text(
                  'Skills & Experience',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 16),

                DropdownForm(
                  plceHolder: 'Select your experience level',
                  options: _experienceLevels,
                  icon: Icons.business_center,
                  validator: _dropdownValidator,
                  onSaved: (value) => _experienceLevel = value,
                ),

                const SizedBox(height: 8),
                Text(
                  'Select Your Skills:',
                  style: TextStyle(fontSize: 16, color: AppColors.greyDark),
                ),
                const SizedBox(height: 8),

                Wrap(children: _availableSkills.map(_buildSkillChip).toList()),

                const SizedBox(height: 16),
                TextForm(
                  plceHolder: 'Bio/Description',
                  maxLines: 5,
                  icon: Icons.description,
                  onSaved: (value) => _bio = value,
                ),

                const SizedBox(height: 24),
                Text(
                  'Ratings & Preferences',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                  'Satisfaction Rating: ${_satisfactionRating.toStringAsFixed(1)}',
                  style: const TextStyle(fontSize: 16),
                ),
                Slider(
                  value: _satisfactionRating,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: _satisfactionRating.round().toString(),
                  activeColor: AppColors.buttonPrimary,
                  inactiveColor: AppColors.textLight,
                  onChanged: (double value) =>
                      setState(() => _satisfactionRating = value),
                ),

                const SizedBox(height: 16),

                Text(
                  'Progress Level: ${_progressLevel.round()}%',
                  style: const TextStyle(fontSize: 16),
                ),
                Slider(
                  value: _progressLevel,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: _progressLevel.round().toString(),
                  activeColor: AppColors.buttonPrimary,
                  inactiveColor: AppColors.textLight,
                  onChanged: (double value) =>
                      setState(() => _progressLevel = value),
                ),

                const SizedBox(height: 24),

                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: Icon(Icons.notifications, color: Colors.blue),
                  title: const Text('Subscribe to Newsletter'),
                  value: _isSubscribed,
                  activeColor: AppColors.Ban,
                  onChanged: (bool value) =>
                      setState(() => _isSubscribed = value),
                ),

                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('I agree to the Terms and Conditions'),
                  value: _agreedToTerms,
                  activeColor: AppColors.Ban,
                  onChanged: (bool? value) =>
                      setState(() => _agreedToTerms = value!),
                  controlAffinity: ListTileControlAffinity.leading,
                ),

                const SizedBox(height: 24),

                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.Ban,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(250, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Submit Form',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

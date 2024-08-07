import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transparent',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 3,
          shadowColor: Colors.black,
        ),
        cardTheme: CardTheme(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[100],
          title: Text('Heartland', style: TextStyle(fontWeight: FontWeight.bold)),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Active Referrals'),
              Tab(text: 'Pending Referrals'),
            ],
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
          ),
        ),
        body: TabBarView(
          children: [
            ActiveProjectsTab(),
            PendingProjectsTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddProjectScreen()),
    );
  },
  icon: Icon(Icons.create, color: Colors.black),
  label: Text(
    'Create Referral',
    style: TextStyle(color: Colors.black),
  ),
  backgroundColor: Colors.grey[100],
),
      ),
    );
  }
}

class AddProjectScreen extends StatefulWidget {
  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  String _projectTitle = '';
  String _clientName = '';
  String _address = '';
  String _projectType = 'Water Damage';
  String _description = '';
  String _phone = '';

  List<String> _projectTypes = ['Water Damage', 'Fire Damage', 'Mold Remediation', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[100],
        title: Text('Add New Project', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width > 600 ? 600 : double.infinity,
                    child: Column(
                      children: [
                        _buildTextFormField('Project Title', (value) => _projectTitle = value!),
                        _buildTextFormField('Client Name', (value) => _clientName = value!),
                        _buildTextFormField('Address', (value) => _address = value!),
                        _buildTextFormField('Phone Number', (value) => _phone = value!),
                        _buildDropdownField(),
                        _buildTextFormField('Project Description', (value) => _description = value!, maxLines: 3),
                        SizedBox(height: 24),
                        ElevatedButton(
                          child: Text('Create Project'),
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(String label, Function(String?) onSaved, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        style: TextStyle(color: Colors.black),
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
        onSaved: onSaved,
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _buildDropdownField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Project Type',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        value: _projectType,
        items: _projectTypes.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _projectType = newValue!;
          });
        },
        style: TextStyle(color: Colors.black),
        alignment: Alignment.center,
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Here you would typically save the project to your database
      // For now, we'll just print the values and go back to the previous screen
      print('Project Title: $_projectTitle');
      print('Client Name: $_clientName');
      print('Address: $_address');
      print('Project Type: $_projectType');
      print('Description: $_description');
      print('Phone: $_phone');
      Navigator.pop(context);
    }
  }
}

class PendingProjectsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        PendingProjectCard(
          title: 'Chris Daughtery',
          address: '123 Maple St',
          status: 'Awaiting Approval',
          date: 'Submitted: July 5, 2024',
        ),
        PendingProjectCard(
          title: 'John Smith',
          address: '456 Pine Ave',
          status: 'Pending Inspection',
          date: 'Submitted: July 6, 2024',
        ),
        PendingProjectCard(
          title: 'Sarah Johnson',
          address: '789 Cedar Ln',
          status: 'Awaiting Documents',
          date: 'Submitted: July 7, 2024',
        ),
      ],
    );
  }
}

class ActiveProjectsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        ActiveProjectCard(
          title: 'Chris Ismert: Water Damage',
          address: '789 Oak St',
          progress: 0.7,
          daysRemaining: 5,
        ),
        ActiveProjectCard(
          title: 'Hadeel Alawadi: Water damage',
          address: '123 Main St',
          progress: 0.3,
          daysRemaining: 10,
        ),
        ActiveProjectCard(
          title: 'Kenny Chesney: Mold Remediation',
          address: '456 Elm St',
          progress: 0.9,
          daysRemaining: 2,
        ),
      ],
    );
  }
}

class PendingProjectCard extends StatelessWidget {
  final String title;
  final String address;
  final String status;
  final String date;

  PendingProjectCard({
    required this.title,
    required this.address,
    required this.status,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(address),
            SizedBox(height: 8),
            Text(status, style: TextStyle(color: Colors.orange)),
            SizedBox(height: 4),
            Text(date, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PendingProjectDetailsScreen(
              title: title,
              address: address,
              status: status,
              date: date,
            )),
          );
        },
      ),
    );
  }
}

class ActiveProjectCard extends StatelessWidget {
  final String title;
  final String address;
  final double progress;
  final int daysRemaining;

  ActiveProjectCard({
    required this.title,
    required this.address,
    required this.progress,
    required this.daysRemaining,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(address),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            SizedBox(height: 4),
            Text('$daysRemaining days remaining', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProjectDetailsScreen()),
          );
        },
      ),
    );
  }
}

class PendingProjectDetailsScreen extends StatelessWidget {
  final String title;
  final String address;
  final String status;
  final String date;

  PendingProjectDetailsScreen({
    required this.title,
    required this.address,
    required this.status,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text('Pending Project Details', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          Card(
            color: Colors.grey[100],
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(address),
                  SizedBox(height: 16),
                  Text('Status: $status', style: TextStyle(color: Colors.orange, fontSize: 18)),
                  SizedBox(height: 8),
                  Text(date, style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Card(
            color: Colors.grey[100],
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Project Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Detailed description of the pending project...'),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Card(
            color: Colors.grey[100],
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Next Steps', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  ListTile(
                    leading: Icon(Icons.check_circle_outline),
                    title: Text('Review submitted documents'),
                  ),
                  ListTile(
                    leading: Icon(Icons.check_circle_outline),
                    title: Text('Schedule initial assessment'),
                  ),
                  ListTile(
                    leading: Icon(Icons.check_circle_outline),
                    title: Text('Prepare cost estimate'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String address;

  ProjectCard({required this.title, required this.address});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(address),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProjectDetailsScreen()),
          );
        },
      ),
    );
  }
}
class ClaimCard extends StatelessWidget {
    final String title;
    final String status;

    ClaimCard({required this.title, required this.status});

    @override
    Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      title: Center(child: Text('File a claim?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
      subtitle: Padding(
      padding: EdgeInsets.only(top: 8),
      child: Container(
      decoration: BoxDecoration(
      color: Colors.green.withOpacity(0.4),
      borderRadius: BorderRadius.circular(12), // Adjusted the border radius
      ),
      padding: EdgeInsets.all(8),
      child: Text(
      'Recommended',
      style: TextStyle(color: Colors.white),
      textAlign: TextAlign.center,
      ),
      ),
      ),
      ),
    );
    }


}

class ProjectDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text('Project Details', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          ClaimCard(title: 'Chris Daughtery', status: 'Pending...'),
          TechAssignedWidget(
            techName: 'Kaleb B.',
            techImagePath: 'lib/assets/tech3.jpg',
          ),
          SizedBox(height: 16),
          CostBreakdownWidget(),
          SizedBox(height: 16),
          TimelineWidget(),
          SizedBox(height: 16),
          EndorsedItemsDashboard(),
          SizedBox(height: 16),
          ScopeHighlightsDashboard(),
          SizedBox(height: 16),
          CustomerCommunicationLog(),
          SizedBox(height: 16),
          TwoCardsWidget(),
        ],
      ),
    );
  }
}

class CostBreakdownWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Cost Estimate', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Tap to view detailed costs'),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              // Navigate to detailed cost breakdown
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CostEstimateDetailsScreen()),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Estimated: \$5,000', style: TextStyle(fontSize: 16)),
                Text('Actual: \$4,800', style: TextStyle(fontSize: 16, color: Colors.green)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TimelineWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Expected Mitigation Timeline', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Estimated completion: July 15, 2024'),
          ),
          TimelineTile(title: 'Initial Assessment', date: 'July 1, 2024', isCompleted: true, isCurrent: false,),
          TimelineTile(title: 'Stabalization', date: 'July 3, 2024', isCompleted: true, isCurrent: false),
          TimelineTile(title: 'Drying', date: 'July 7, 2024', isCompleted: false, isCurrent: true),
          TimelineTile(title: 'Restoration', date: 'July 15, 2024', isCompleted: false, isCurrent: false),
        ],
      ),
    );
  }
}

class TimelineTile extends StatelessWidget {
  final String title;
  final String date;
  final bool isCompleted;
  final bool isCurrent;

  TimelineTile({required this.title, required this.date, required this.isCompleted, required this.isCurrent});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: isCurrent
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            )
          : Icon(
              isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isCompleted ? Colors.green : Colors.grey,
            ),
      title: Text(title),
      subtitle: Text(date),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
      onTap: () {
        // Add your logic here for when the tile is tapped
        Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TimelineDetailsScreen()),
    );
      },
    );
  }
}

class ImageThumbnail extends StatelessWidget {
  final String imagePath;

  ImageThumbnail({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      width: 107, // Increased width
      height: 144, // Increased height
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center the image vertically
        children: [
          Container(
            width: 120,
            height: 130,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScopeHighlightsDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Scope Highlights', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Expected mitigation requirements'),
          ),
          ComplianceItem(title: 'Emergency Service Call', isCompliant: false),
          ComplianceItem(title: 'Asbestos/Mold Testing', isCompliant: false),
          ComplianceItem(title: 'Insured Health Concerns', isCompliant: false),
          ComplianceItem(title: 'Non-Standard Dry Times', isCompliant: true),
          ComplianceItem(title: 'PPE Required', isCompliant: false),
          ComplianceItem(title: 'Category 2 Class 4 loss', isCompliant: true),
        ],
      ),
    );
  }
}

class EndorsedItemsDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Endorsements', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Expected endorsements'),
          ),
          InsuredEndorsementsItem(title: 'Sump Pump', isCompliant: true),
          InsuredEndorsementsItem(title: 'General Homeowners', isCompliant: true),
          InsuredEndorsementsItem(title: 'Flood', isCompliant: true),
          InsuredEndorsementsItem(title: 'Specialty Clause', isCompliant: true),
        ],
      ),
    );
  }
}

class InsuredEndorsementsItem extends StatelessWidget {
  final String title;
  final bool isCompliant;

  InsuredEndorsementsItem({required this.title, required this.isCompliant});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Add your logic here
       Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EndorsementsDetailsScreen()),
    );
      },
      child: ListTile(
        leading: Icon(
          Icons.monetization_on,
          color:Colors.green[200]
        ),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
      ),
    );
  }
}

class ComplianceItem extends StatelessWidget {
  final String title;
  final bool isCompliant;

  ComplianceItem({required this.title, required this.isCompliant});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Add your logic here
        Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ScopeHighlightsDetailsScreen()),
    );
      },
      child: ListTile(
        leading: Icon(
          isCompliant ? Icons.check_circle : Icons.cancel,
          color: isCompliant ? Colors.green : Colors.red[00],
        ),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
      ),
    );
  }
}
class CustomerCommunicationLog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Communication History', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Tap to view all communications'),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CommunicationHistoryScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class TwoCardsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              // Add your logic here
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ServiceTechChatScreen()),
              );
            },
            child: Card(
              color: Colors.grey[100],
              child: Column(
          children: [
            ListTile(
              title: Text('Service Tech', style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.chat, color: Colors.black),
            ),
            // Add more widgets for the first card here
          ],
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: InkWell(
            onTap: () {
              // Add your logic here
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ServiceManagerChatScreen()),
              );
            },
            child: Card(
              color: Colors.grey[100],
              child: Column(
          children: [
            ListTile(
              title: Text('Service Manager', style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.chat, color: Colors.black),
            ),
            // Add more widgets for the first card here
            
          ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ManagerCommunication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Chat with our Service Manager', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Tap to view all communications'),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              // Navigate to full communication log
            },
          ),
        ],
      ),
    );
  }
}

class TechCommunication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Communication History', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Tap to view all communications'),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              // Navigate to full communication log
            },
          ),
        ],
      ),
    );
  }
}

//Request update button is a communication that goes to the service manager
//Chat with tech is a communication that goes to the tech

class CommunicationItem extends StatelessWidget {
  final String date;
  final String message;

  CommunicationItem({required this.date, required this.message});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(date, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(message),
    );
  }
}

class TechAssignedWidget extends StatelessWidget {
  final String techName;
  final String techImagePath;

  TechAssignedWidget({required this.techName, required this.techImagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TechDetailsScreen(techName: techName)),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(techImagePath),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tech Assigned',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      techName,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}

// Enhance the existing TechDetailsScreen
class TechDetailsScreen extends StatelessWidget {
  final String techName;

  TechDetailsScreen({required this.techName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text('Tech Details', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          Card(
            color: Colors.grey[100],
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('lib/assets/tech3.jpg'),
                  ),
                  SizedBox(height: 16),
                  Text(techName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text('Water Damage Specialist', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Card(
            color: Colors.grey[100],
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Experience', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('5 years of experience in water damage restoration'),
                  Text('Certified by IICRC in Water Damage Restoration'),
                  Text('Specializes in residential and commercial properties'),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Card(
            color: Colors.grey[100],
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(// Continuing from where we left off in the TechDetailsScreen

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Skills', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(label: Text('Water Extraction')),
                    Chip(label: Text('Moisture Detection')),
                    Chip(label: Text('Dehumidification')),
                    Chip(label: Text('Mold Prevention')),
                    Chip(label: Text('Structural Drying')),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        Card(
          color: Colors.grey[100],
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Contact', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('(555) 123-4567'),
                ),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text('$techName@example.com'.toLowerCase()),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
}

class CostEstimateDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text('Cost Estimate Details', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          CostDetailCard(category: 'Labor', estimated: 2500, actual: 2300),
          CostDetailCard(category: 'Materials', estimated: 1500, actual: 1600),
          CostDetailCard(category: 'Equipment', estimated: 800, actual: 700),
          CostDetailCard(category: 'Miscellaneous', estimated: 200, actual: 200),
          SizedBox(height: 16),
          Card(
            color: Colors.grey[100],
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Estimated: \$5,000', style: TextStyle(fontSize: 16)),
                      Text('Actual: \$4,800', style: TextStyle(fontSize: 16, color: Colors.green)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CostDetailCard extends StatelessWidget {
  final String category;
  final int estimated;
  final int actual;

  CostDetailCard({required this.category, required this.estimated, required this.actual});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(category, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Estimated: \$${estimated}'),
                Text('Actual: \$${actual}', style: TextStyle(color: actual <= estimated ? Colors.green : Colors.red)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TimelineDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text('Timeline Details', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TimelineDetailCard(
            title: 'Initial Assessment',
            date: 'July 1, 2024',
            description: 'Completed initial assessment of water damage.',
            isCompleted: true,
          ),
          TimelineDetailCard(
            title: 'Stabilization',
            date: 'July 3, 2024',
            description: 'Stabilized affected areas to prevent further damage.',
            isCompleted: true,
          ),
          TimelineDetailCard(
            title: 'Drying',
            date: 'July 7, 2024',
            description: 'Started drying process using industrial equipment.',
            isCompleted: false,
            isCurrent: true,
          ),
          TimelineDetailCard(
            title: 'Restoration',
            date: 'July 15, 2024',
            description: 'Planned restoration of damaged areas.',
            isCompleted: false,
          ),
        ],
      ),
    );
  }
}

class TimelineDetailCard extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final bool isCompleted;
  final bool isCurrent;

  TimelineDetailCard({
    required this.title,
    required this.date,
    required this.description,
    required this.isCompleted,
    this.isCurrent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                isCurrent
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      )
                    : Icon(
                        isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                        color: isCompleted ? Colors.green : Colors.grey,
                      ),
                SizedBox(width: 8),
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            SizedBox(height: 8),
            Text(date, style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 8),
            Text(description),
          ],
        ),
      ),
    );
  }
}

class ScopeHighlightsDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text('Scope Highlights', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          ScopeHighlightDetailCard(
            title: 'Emergency Service Call',
            isCompliant: false,
            description: 'Immediate response required due to severe water damage.',
          ),
          ScopeHighlightDetailCard(
            title: 'Asbestos/Mold Testing',
            isCompliant: false,
            description: 'Testing required to ensure safety before proceeding with repairs.',
          ),
          ScopeHighlightDetailCard(
            title: 'Insured Health Concerns',
            isCompliant: false,
            description: 'Special considerations needed due to resident health issues.',
          ),
          ScopeHighlightDetailCard(
            title: 'Non-Standard Dry Times',
            isCompliant: true,
            description: 'Extended drying time may be necessary due to the extent of damage.',
          ),
          ScopeHighlightDetailCard(
            title: 'PPE Required',
            isCompliant: false,
            description: 'Personal Protective Equipment necessary for worker safety.',
          ),
          ScopeHighlightDetailCard(
            title: 'Category 2 Class 4 loss',
            isCompliant: true,
            description: 'Significant water damage requiring extensive restoration efforts.',
          ),
        ],
      ),
    );
  }
}

class ScopeHighlightDetailCard extends StatelessWidget {
  final String title;
  final bool isCompliant;
  final String description;

  ScopeHighlightDetailCard({
    required this.title,
    required this.isCompliant,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isCompliant ? Icons.check_circle : Icons.cancel,
                  color: isCompliant ? Colors.green : Colors.red[300],
                ),
                SizedBox(width: 8),
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            SizedBox(height: 8),
            Text(description),
          ],
        ),
      ),
    );
  }
}

class EndorsementsDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text('Endorsements', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          EndorsementDetailCard(
            title: 'Sump Pump',
            description: 'Coverage for damage caused by sump pump failure.',
            coverageLimit: 5000,
          ),
          EndorsementDetailCard(
            title: 'General Homeowners',
            description: 'Standard coverage for various home-related incidents.',
            coverageLimit: 250000,
          ),
          EndorsementDetailCard(
            title: 'Flood',
            description: 'Additional coverage for flood-related damages.',
            coverageLimit: 50000,
          ),
          EndorsementDetailCard(
            title: 'Specialty Clause',
            description: 'Custom coverage for specific high-value items.',
            coverageLimit: 10000,
          ),
        ],
      ),
    );
  }
}

class EndorsementDetailCard extends StatelessWidget {
  final String title;
  final String description;
  final int coverageLimit;

  EndorsementDetailCard({
    required this.title,
    required this.description,
    required this.coverageLimit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.monetization_on, color: Colors.green[200]),
                SizedBox(width: 8),
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            SizedBox(height: 8),
            Text(description),
            SizedBox(height: 8),
            Text('Coverage Limit: \$${coverageLimit.toString()}', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class CommunicationHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text('Communication History', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          CommunicationHistoryCard(
            date: 'July 1, 2024',
            sender: 'Service Tech',
            message: 'Initial assessment completed. Water damage more extensive than initially thought.',
          ),
          CommunicationHistoryCard(
            date: 'July 2, 2024',
            sender: 'Customer',
            message: 'When will the drying equipment be set up?',
          ),
          CommunicationHistoryCard(
            date: 'July 2, 2024',
            sender: 'Service Manager',
            message: 'Drying equipment will be set up tomorrow morning. Our team will arrive at 9 AM.',
          ),
          CommunicationHistoryCard(
            date: 'July 3, 2024',
            sender: 'Service Tech',
            message: 'Drying equipment installed and running. Will monitor progress daily.',
          ),
          CommunicationHistoryCard(
            date: 'July 5, 2024',
            sender: 'Customer',
            message: 'How long will the drying process take?',
          ),
          CommunicationHistoryCard(
            date: 'July 5, 2024',
            sender: 'Service Manager',
            message: 'Based on current readings, we estimate 3-4 more days for complete drying.',
          ),
        ],
      ),
    );
  }
}

class CommunicationHistoryCard extends StatelessWidget {
  final String date;
  final String sender;
  final String message;

  CommunicationHistoryCard({
    required this.date,
    required this.sender,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date, style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 8),
            Text(sender, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(message),
          ],
        ),
      ),
    );
  }
}

class ServiceTechChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text('Chat with Service Tech', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                _buildChatMessage('Hello! How can I assist you today?', false),
                _buildChatMessage('Hi! I have a question about the water extraction process.', true),
                _buildChatMessage('Of course! What would you like to know?', false),
                // Add more messages as needed
              ],
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }
}

class ServiceManagerChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text('Chat with Service Manager', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                _buildChatMessage('Good morning! How may I help you today?', false),
                _buildChatMessage('Hello! I\'d like an update on the project timeline.', true),
                _buildChatMessage('Certainly! Let me pull up the latest information for you.', false),
                // Add more messages as needed
              ],
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }
}

Widget _buildChatMessage(String message, bool isUser) {
  return Align(
    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUser ? Colors.blue[100] : Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        message,
        style: TextStyle(color: Colors.black),
      ),
    ),
  );
}

Widget _buildMessageInput() {
  return Container(
    padding: EdgeInsets.all(8),
    color: Colors.grey[200],
    child: Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Type a message...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        ),
        SizedBox(width: 8),
        CircleAvatar(
          backgroundColor: Colors.black,
          child: IconButton(
            icon: Icon(Icons.send, color: Colors.white),
            onPressed: () {
              // Add send message logic here
            },
          ),
        ),
      ],
    ),
  );
}
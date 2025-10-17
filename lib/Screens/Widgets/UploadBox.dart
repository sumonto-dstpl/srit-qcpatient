import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:intl/intl.dart';

class UploadBox extends StatefulWidget {
  @override
  _UploadBoxState createState() => _UploadBoxState();
}

class _UploadBoxState extends State<UploadBox> {
  List<Map<String, dynamic>> uploadedFiles = [];
  // Each map: {'file': PlatformFile, 'time': DateTime}

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf'],
      withData: true,
    );

    if (result != null) {
      final file = result.files.first;
      if (file.size > 10 * 1024 * 1024) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("File must be less than 10MB")),
        );
        return;
      }

      setState(() {
        uploadedFiles.add({
          'file': file,
          'time': DateTime.now(),
        });
      });
    }
  }

  String getTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) return 'Now';
    if (difference.inHours < 1) return '${difference.inMinutes} minutes ago';
    if (difference.inHours < 24) return '${difference.inHours} hours ago';
    if (difference.inDays == 1) return 'Yesterday';
    return DateFormat('dd MMM yyyy').format(time);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Upload Box
        GestureDetector(
          onTap: pickFile,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02,
              horizontal: screenHeight * 0.02,
            ),
            child: DottedBorder(
              color: Color(0xFF343434).withOpacity(0.3),
              strokeWidth: 1,
              borderType: BorderType.RRect,
              radius: Radius.circular(8),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: screenHeight * 0.02,
                        bottom: screenHeight * 0.01,
                      ),
                      width: screenHeight * 0.04,
                      height: screenHeight * 0.04,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/homecare.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Text(
                      "choose file to upload",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F1F1F),
                        fontSize: screenHeight * 0.014,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.006),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: screenHeight * 0.012,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF000000).withOpacity(0.4),
                        ),
                        children: [
                          TextSpan(text: 'image or pdf Should be less than'),
                          TextSpan(
                            text: ' 10MB',
                            style: TextStyle(color: Color(0xFF126086)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Display list of uploaded files
        Container(
          padding: EdgeInsets.only(
            top: screenHeight * 0.015,
            bottom: 0,
            left: screenHeight * 0.01,
            right: screenHeight * 0.01,
          ),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: uploadedFiles.length,
            itemBuilder: (context, index) {
              final fileData = uploadedFiles[index];
              final file = fileData['file'] as PlatformFile;
              final uploadTime = fileData['time'] as DateTime;

              return Dismissible(
                key: Key(file.name + uploadTime.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.white,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.delete, color: Colors.red),
                ),
                onDismissed: (direction) {
                  setState(() {
                    uploadedFiles.removeAt(index);
                  });
                },
                child: Card(
                  elevation: 0.0,
                  color: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black.withOpacity(0.1),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(screenHeight * 0.012),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Custom image for file
                        SizedBox(width: screenHeight * 0.01),
                        Container(
                          height: screenHeight * 0.04,
                          width: screenHeight * 0.04,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/medicationjpg.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: screenHeight * 0.015),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                file.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenHeight * 0.014,
                                  color: Colors.black87,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${(file.size / 1024 / 1024).toStringAsFixed(2)} MB",
                                style: TextStyle(
                                  fontSize: screenHeight * 0.012,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Upload time instead of close icon
                        Text(
                          getTimeAgo(uploadTime),
                          style: TextStyle(
                            fontSize: screenHeight * 0.011,
                            color: Color(0xFF126086),
                            fontWeight: FontWeight.w500,
                          ),

                        ),
                        SizedBox(width: screenHeight * 0.01),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}








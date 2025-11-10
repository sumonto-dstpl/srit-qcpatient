import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:dotted_border/dotted_border.dart';

class UploadBoxExpanded extends StatefulWidget {
  final Function(List<Map<String, dynamic>>) onFilesChanged;

  const UploadBoxExpanded({Key? key, required this.onFilesChanged}) : super(key: key);

  @override
  _UploadBoxExpandedState createState() => _UploadBoxExpandedState();
}

class _UploadBoxExpandedState extends State<UploadBoxExpanded> {
  List<Map<String, dynamic>> uploadedFiles = [];

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
          const SnackBar(content: Text("File must be less than 10MB")),
        );
        return;
      }

      setState(() {
        uploadedFiles.add({
          'file': file,
          'time': DateTime.now(),
        });
      });

      widget.onFilesChanged(uploadedFiles);
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
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        // The exact enlarged dotted box chunk you provided
        GestureDetector(
          onTap: pickFile,
          child: Container(
            width: double.infinity,
            height: screenHeight * 0.32, // same as your commented code
            margin: EdgeInsets.only(
              top: screenHeight * 0.03,
              bottom: 0,
              left: 0,
              right: 0,
            ),
            padding: EdgeInsets.only(
              top: 0,
              bottom: 0,
              right: screenHeight * 0.020,
              left: screenHeight * 0.02,
            ),
            child: DottedBorder(
              color: const Color(0xFF343434).withOpacity(0.3),
              strokeWidth: 1,
              borderType: BorderType.RRect,
              radius: const Radius.circular(8),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        left: 0,
                        right: 0,
                        top: screenHeight * 0.07,
                        bottom: screenHeight * 0.01,
                      ),
                      width: screenHeight * 0.04,
                      height: screenHeight * 0.04,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/homecare.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: screenHeight * 0.006,
                          ),
                          child: Text(
                            "choose file to upload",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1F1F1F),
                              fontSize: screenHeight * 0.014,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: screenHeight * 0.07,
                          ),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: screenHeight * 0.012,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF000000).withOpacity(0.4),
                              ),
                              children: const [
                                TextSpan(text: 'image or pdf Should be less than'),
                                TextSpan(
                                  text: ' 10MB',
                                  style: TextStyle(color: Color(0xFF126086)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // File list area (keeps same look as your original file listing)
        Container(
          padding: EdgeInsets.only(
            top: screenHeight * 0.015,
            left: screenHeight * 0.01,
            right: screenHeight * 0.01,
          ),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.red),
                ),
                onDismissed: (direction) {
                  setState(() {
                    uploadedFiles.removeAt(index);
                  });
                  widget.onFilesChanged(uploadedFiles);
                },
                child: GestureDetector(
                  onTap: () {},
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
                      padding: EdgeInsets.only(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        top: 0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [0.5, 0.9],
                            colors: [Color(0xFFffffff), Color(0xFFffffff)],
                          ),
                        ),
                        margin: EdgeInsets.only(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          top: 0,
                        ),
                        padding: EdgeInsets.only(
                          left: screenHeight * 0.005,
                          right: screenHeight * 0.005,
                          bottom: screenHeight * 0.005,
                          top: screenHeight * 0.005,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                left: screenHeight * 0.005,
                                right: screenHeight * 0.005,
                                top: 0,
                                bottom: 0,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: screenHeight * 0.06,
                                    width: screenHeight * 0.06,
                                    padding: EdgeInsets.only(left: 0),
                                    margin: EdgeInsets.only(
                                      left: screenHeight * 0.01,
                                      top: screenHeight * 0.005,
                                      bottom: screenHeight * 0.005,
                                      right: screenHeight * 0.01,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(130.0),
                                      child: Image.asset(
                                        'assets/medicationjpg.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: screenHeight * 0.010),
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            file.name,
                                            style: TextStyle(
                                              color: Colors.black87,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.bold,
                                              fontSize: screenHeight * 0.014,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "${(file.size / 1024 / 1024).toStringAsFixed(2)} Mb",
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: screenHeight * 0.012,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: screenHeight * 0.01),
                                    child: Text(
                                      getTimeAgo(uploadTime),
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.011,
                                        color: const Color(0xFF126086),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
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
            },
          ),
        ),
      ],
    );
  }
}

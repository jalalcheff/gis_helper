import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/model/image_document_model.dart';
import '../../cubit/image_document_cubit.dart';

class AddImageDocumentScreen extends StatefulWidget {
  const AddImageDocumentScreen({Key? key}) : super(key: key);

  @override
  _AddImageDocumentScreenState createState() => _AddImageDocumentScreenState();
}

class _AddImageDocumentScreenState extends State<AddImageDocumentScreen> {
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();

  @override
  void dispose() {
    _imageUrlController.dispose();
    _titleController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // خلفية بيضاء أو رمادية فاتحة جدًا
      appBar: AppBar(
        title: const Text(
          '📤 إضافة صورة جديدة',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocConsumer<ImageDocumentCubit, ImageDocumentState>(
        listener: (context, state) {
          if (state is ImageDocumentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تمت إضافة الصورة بنجاح!')), // تمت إضافة الصورة بنجاح!
            );
            _imageUrlController.clear();
            _titleController.clear();
            _subtitleController.clear();
          } else if (state is ImageDocumentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('فشل إضافة الصورة: ${state.error}')), // فشل إضافة الصورة:
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _imageUrlController,
                          decoration: InputDecoration(
                            labelText: 'رابط الصورة',
                            hintText: 'أدخل رابط الصورة...',
                            prefixIcon: const Icon(Icons.link),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: 'العنوان',
                            hintText: 'اكتب العنوان هنا',
                            prefixIcon: const Icon(Icons.title),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _subtitleController,
                          maxLines: null, // لجعلها متعددة الأسطر
                          minLines: 3, // الحد الأدنى 3 أسطر
                          decoration: InputDecoration(
                            labelText: 'التفاصيل',
                            hintText: 'أدخل التفاصيل',
                            prefixIcon: const Icon(Icons.description),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton.icon(
                    onPressed: state is ImageDocumentLoading
                        ? null
                        : () {
                            final imageUrl = _imageUrlController.text;
                            final title = _titleController.text;
                            final subtitle = _subtitleController.text;

                            if (imageUrl.isNotEmpty &&
                                title.isNotEmpty &&
                                subtitle.isNotEmpty) {
                              context.read<ImageDocumentCubit>().addImageDocument(
                                    ImageDocumentModel(title: title, imageUrl: imageUrl, subtitle: subtitle, id: imageUrl)
                                  );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('الرجاء ملء جميع الحقول.')), // الرجاء ملء جميع الحقول.
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent, // لون مميز
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      shadowColor: Colors.blueAccent.withOpacity(0.5),
                    ),
                    icon: state is ImageDocumentLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(Icons.upload_file),
                    label: Text(
                      state is ImageDocumentLoading ? 'جاري الرفع...' : 'رفع الصورة',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
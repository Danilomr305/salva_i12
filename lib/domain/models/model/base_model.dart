import 'package:i12mobile/domain/models/shared/descrition_model.dart';

abstract class BaseModel {
  final String id;
  final Descrition descritionDto;

  BaseModel({required this.id, required this.descritionDto});
}

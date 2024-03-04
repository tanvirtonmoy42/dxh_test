// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderProductModelAdapter extends TypeAdapter<OrderProductModel> {
  @override
  final int typeId = 1;

  @override
  OrderProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderProductModel(
      product: fields[0] as ProductModel,
      count: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, OrderProductModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.product)
      ..writeByte(1)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

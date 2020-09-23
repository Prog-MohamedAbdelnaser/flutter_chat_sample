import 'dart:async';

StreamController controller = StreamController();

void main() {
  print('start');

  requestOrder('cho');

  StreamTransformer transFormars =
      StreamTransformer.fromHandlers(handleData: (type, snik) {
    if (type == 'choc') {
      snik.add(Cacke());
    } else {
      snik.addError(Exception('cant bake this type '));
    }
  });

  controller.stream.map((ordr) => ordr.type).transform(transFormars).listen(
        (value) => print('baker have finish $value'),
        onError: (err) => print(err),
      );

  print('finish');
}

void requestOrder(String type) {
  controller.sink.add(Order(type));
}

class Cacke {}

class Order {
  String type;
  Order(this.type);
}

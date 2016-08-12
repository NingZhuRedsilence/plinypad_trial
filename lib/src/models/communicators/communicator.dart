part of pad_models;

/*
* An interface
* generic programming
* generics
* parameterized types
* make methods more specific for pliny
* */
abstract class Communicator <T> {

  final T _destination;
  T _message;


  T get message => _message;

  Communicator(this._destination);

  void connect();
  dynamic send(T message);
  dynamic receive();

}
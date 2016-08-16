part of pad_models;

class CodeSearchHandler
{
  DefaultIdeController _controller;
  //Todo: ?? make it abstract class here but also can use the getPrimarySourceFileContent method
  String _code = "";
  String _destination = "";
  Communicator _connection;

  CodeSearchHandler(DefaultIdeController controller, String destination){
    _controller = controller;
    _destination = destination;
    _connection = new HttpCommunicator(_destination);
  }

  dynamic call () async  {
    _code = _controller.getPrimarySourceFileContent();
    print("in CodeSearchHandler call(): _code = " + _code);
    await _connection.send(_code); // https://www.dartlang.org/tutorials/language/futures
    // according to Dart doc, the next function won't execute until this line
    // finishes, but _connection.message will still be null if the http_communicator
    // doesn't use await
    await print("in CodeSearchHandler call(): answerFromPliny = " + _connection.message);
    await _controller.appendTextLineToConsole(_connection.message);
  }

}
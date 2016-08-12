part of pad_models;

class CodeSearchHandler
{
  DefaultIdeController _controller;
  String _code = "";
  String _destination = "";
  Communicator _connection;
  String _answerFromPliny = "";

  CodeSearchHandler(DefaultIdeController controller, String destination){
    _controller = controller;
    _destination = destination;
    _connection = new HttpCommunicator(_destination);
  }

  dynamic call () async  {
    _code = _controller.getPrimarySourceFileContent();
    print("in CodeSearchHandler call(): _code = " + _code);
    await _connection.send(_code);
    await print("in CodeSearchHandler call(): answerFromPliny = " + _connection.message);
    await _controller.appendTextLineToConsole(_connection.message);
  }

}
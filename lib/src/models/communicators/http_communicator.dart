part of pad_models;

class HttpCommunicator extends Communicator <String> {
  //final HttpRequest _request = new HttpRequest();
  var _message; //=""; //if leave null here, will cause exceptions when first accessing the variable?
  get message => _message;

  //if communicator says "final T _destination;", error here "the argument type
  // string xxxx cannot be assigned to the parameter type dart"
  HttpCommunicator(String destination): super(destination);

  @override
  void start() {

  }

  @override
  void connect() {
    HttpRequest.getString(_destination).then(_onConnected);
  }

  @override
  dynamic receive() async {
    //periodical pull?
    print("in receive");
    //don't need a Get?

    return (await HttpRequest.getString(_destination).then((answer) {
      if (null != answer) {
        //print("before assignment" + _message);
        _message = answer;
        print("after assignment" + _message);

        //mark: 08/02 1:15 pm get response from jetty Note servlet
        //??? how to use Future? Need to use future?
        // design switch statement for get, post for extensibility?
        //todo: make Jetty Note Servlet send message to pliny server & get message back to Jetty then to Dart
      }
      else {
        _message = "no returned answer";
      }
      print("end of future" + _message);

    }));
  }

  @override
  dynamic send(String message) async {
    // POST the data to the server
//    _request.open("POST", _destination, async: true);
//    _request.send(message); // perform the async POST
//    _request.onReadyStateChange.listen((_) {
//      if (_request.readyState == HttpRequest.DONE &&
//          (_request.status == 200 || _request.status == 0)) {
//        print("the other end returns: " + _request.responseText); // output the response from the server
//      }
//    });
    var data = { 'req_type' : 'repair', 'func_name' : 'test', "code" : message };

    await HttpRequest.postFormData(_destination, data).then((HttpRequest resp) {
      //do something with the response
      print("in postFormData, inside then, response is: " + resp.responseText);
      Map data = JSON.decode(resp.responseText);
      _message = data["completed_code"];

    });
  }

  void _onConnected(String message){
    if (null != message) {
      print(message);
    }
  }

}
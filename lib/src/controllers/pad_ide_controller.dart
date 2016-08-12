//part of pad_controllers;
//
///*
//* Topmost controller for the whole IDE, currently the same as Vellum IDE except
//* having an additional event pathway for "submit" button
//* */
//class PadIdeController extends DefaultIdeController {
//  //Todo server URL should sit here? Probably not. Highest level knowledge, from the author
//  // should be in main.dart? --> PadIdeController constructor needs change
//  final String _serverURL = "http://localhost:8080/note";
//  //PadToolbarController instead of the DefaulToolbarController to control the submit button
//  PadToolbarController _toolbarController;
//
//  factory PadIdeController()
//  {
//    PadToolbarController toolbarController = new PadToolbarController();
//    return new PadIdeController.allParams(toolbarController);
//  }
//
//  //redirecting constructor?
//  //arguements for constructor: makeEditorView, FileEditorController sourceEditorController, ToolbarController toolbarController,
////  ConsoleController consoleController,
////      ProjectExplorerController projectExplorerController, Set<EditorFile<String>> initialFiles,
////      String consoleInitialMessage, NewSourceFileFactory newFileFactory)
//  PadIdeController.allParams(PadToolbarController toolbarController)
//      : super(makeEditorView, toolbarController)
//  {
//    _toolbarController = toolbarController;
//    new PadIdeController();
//  }
//
//  @override
//  void start() {
//    super.start(); // start everything that default_ide_controller has
//    //bind additional listeners to additional buttons
//    _toolbarController.onSubmissionRequested.listen((_) { _handleSubmissionRequest(); });
//  }
//
//  void _handleSubmissionRequest(){
//    //get file content
//    var message_to_send = super.getPrimarySourceFileContent();
//    //create httprequest
//    HttpRequest request = new HttpRequest(); // create a new XHR
//    request.open("POST", _serverURL, async: false); //todo false or true?
//    // create json message
//    var mapData = new Map();
//    mapData["content"] = message_to_send;
//    String jsonData = JSON.encode(mapData); // convert map to String
//    // send
//    request.send(jsonData); // perform the async POST
//    //Todo display return
//
//  }
//
//  void _onDataLoaded(String responseText) {
//    var jsonString = responseText;
//    print(jsonString);
//  }
//
//
//}

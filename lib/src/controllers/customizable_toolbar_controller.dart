part of pad_controllers;


class CustomizableToolbarController extends DefaultToolbarController
{


  factory CustomizableToolbarController()
  {
//    var newButtons = new List<ButtonElement>();

    return new CustomizableToolbarController.customized();
  }

//named constructor with (this._variable) (what does it call again?)
  CustomizableToolbarController.customized(): super.allParams("new-file-button");

  void addButton(String buttonId, void handlerFunction())
  {
    ButtonElement newButton = querySelector('#' + buttonId);
    print("in customizable_toolbar_controller");
    newButton.onClick.listen((MouseEvent e) {
      print("in click listener");
      handlerFunction(); });
  }

//  void setDocumentSource( DefaultIdeController content )
//  {
//    _documentSource = content;
//  }
}


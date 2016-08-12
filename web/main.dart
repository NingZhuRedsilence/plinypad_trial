/**
 * Copyright 2016 Rice University
 *
 *  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
 *  the License. You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed
 *  on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for
 *  the specific language governing permissions and limitations under the License.
 */

import 'package:vellum/default_controllers.dart';
import 'package:vellum/models_editor_file.dart';
import 'package:vellum/models_file_types.dart';
import 'package:path/src/style/posix.dart';
import 'package:path/src/parsed_path.dart';
import 'package:vellum/view_models.dart';
import 'dart:html';
import 'package:vellum/views.dart';
import 'package:plinypad_trial/pad_controllers.dart';
import 'package:plinypad_trial/models.dart';

/**
 * Program entry point.  Creates and renders a web based IDE in the browser.
 */
String serverURL = "http://localhost:8080/note";

void main()
{
  /**
   * Create the initial JavaScript file that should be shown in the IDE upon start.
   */
  String initialFileContents = "function foo()\n{\n\n}";
  ParsedPath initialFilePath = new ParsedPath.parse("program.js", new PosixStyle());
  EditorFile initialFile = new EditorFile(initialFilePath, initialFileContents, FileType.JavaScript);
  Set<EditorFile> initialFiles = new Set()..add(initialFile);
  CustomizableToolbarController customizableToolbarController = new CustomizableToolbarController();

  /**
   * Create and show the IDE.
   */
  /*make PadIdeController take all params*/
  DefaultIdeController controller =
  new DefaultIdeController(_makeAceEditorView, toolbarController: customizableToolbarController,
      initialFiles: initialFiles, consoleInitialMessage: "Welcome to Vellum!");

  var handleSubmissionRequest = new CodeSearchHandler(controller, serverURL);

  customizableToolbarController.addButton("submit-button", handleSubmissionRequest);
  controller.start();

}

/**
 * Make an [FileEditorView] backed by the Ace editor (https://ace.c9.io/) tied to the given [vm].
 *
 * Assumes Ace should be placed inside a div with the id "editor".
 */
FileEditorView _makeAceEditorView(FileEditorViewModel vm) {
  DivElement editorDiv = new Element.div();
  editorDiv.id =
      "editorDiv-" + new DateTime.now().millisecondsSinceEpoch.toString();
  editorDiv.classes.add("ace-editor");

  DivElement editorsParentElement = querySelector("#editors-parent-div");
  editorsParentElement.children.add(editorDiv);

  return new JavaScriptFileEditorElementView(vm, editorDiv);
}


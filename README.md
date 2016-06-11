# Apex 5 Tree Search and Show

Plugin Details:
- Name: Tree Search and Show
- Code: TP.DA.TREESEARCHSHOW
- Version: v1.0
- Apex compatibility: 5

In Apex 5 a new tree widget has been introduced which replaces the previous implementation of jstree. This means that all code which was used to interact with the jstree implementation is no longer valid. However, much of the functionality is perfectly reproducable with the new widget.  
For example, searching the tree is still possible, with one caveat: the widget will return a list of matching nodes and that's that. There is no built-in way to have the tree search nodes, highlight them or assign a class, and open up all parent nodes so the found nodes become visible.  
This plugin contains a javascript file which will extend the treeView widget with a new function, "findAndShow", which will do just those things. The apex plugin then facilitates the use of this by exposing it to the dynamic action framework and removing the need to configure things through javascript.  

Demo: https://apex.oracle.com/pls/apex/f?p=90922:11 

## Features:

- Choose which item to get the search text from
- Assign a css class to matching nodes
- Define a javascript function to test nodes with
- Specify a text and background color for matching nodes (for ease of use! Not specifying = no effect)
- Opens up all parent branches of matching nodes
- Plays nice with multiple tree since all settings only affect the region (tree) specified

## To use:

1. Install the plugin in the shared components of your application
2. Create a dynamic action on the page which reacts to some event. For example a button.
3. As a true action, select the "Tree Search and Show" action, found under "Execute"
4. Adjust the settings
5. Select the affected region (the tree region)
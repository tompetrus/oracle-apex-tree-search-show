/**
 * @author Tom Petrus
 * @fileoverview Extends the apex treeView widget. A new function "findAndShow" will be added for availability on the standard widget. It is used to search for nodes in a (static) tree, set a class on the DOM nodes, and open up all branches leading up to the found nodes - increasing visibility to the end user. 
 * Be aware that the extend has to occur before a tree instance is initialized, otherwise that tree instance will not have this extra available.
 */
( function ( $, undefined ) {
  $.widget("apex.treeView", $.apex.treeView, {
    /**
     * new options on the widget:
     * @param options.matchClass {String} The class to assign to elements matching the search pattern. Don't forget that you need to actually define a CSS rule if you want to see anything being colored!
     * @param options.matchFunction {Function} The function to used for searching the tree. Recieves two input parameters: the tree DATA node and the search term. A boolean value is expected as return. The DEFAULT functionality is to search the node label for the occurence of the search term, both in lowercase
     */
    options: {
      matchFunction: function(n,term){ return n.label.toLowerCase().indexOf(term.toLowerCase())!==-1;}
    , matchClass : "tss-search-match"
    }
    , 
    /**
     * This function will perform a search on the new apex 5 tree widget, assign a class to the element(s), and will open up their parent branches so the results are all visible to the user.
     * The tree widget's standard "find" functionality will look through the datanodes and then return the matching set of dom elements, so it takes extra work on the developer's part to actually present this found set, which this snippet tries to alleviate.
     * @param pTerm {String} The term to search the tree's nodes with
     * @example 
     * With CSS:
     * .matchClass {
     *   color: red !important;
     *   background-color: purple;
     * }
     *
     * !! with the STATIC REGION ID set to myTree !!
     *
     * JS code:
     * apex.jQuery("#myTree div[role=tree]").treeView("option", {matchClass:"matchClass"});
     * apex.jQuery("#myTree div[role=tree]").treeView("findAndShow","ab")
     *
     * This will search for all nodes where ab appears and color them in red and purple, and opens up their parent nodes
     */
    findAndShow: function ( pTerm ) {
      var self = this;
      
      //perform the search operation on the tree
      var sel = self.find({depth: -1, match: function(n){ return self.options.matchFunction(n, pTerm); }, findAll: true});
      
      //if a matchClass has been specified, remove previously found nodes and tag new results
      if ( self.options.matchClass ) {
        $("."+self.options.matchClass, self.element).removeClass(self.options.matchClass);
        sel.find("span.a-TreeView-label").addClass(self.options.matchClass);
      };
      
      //get the datanodes for each found treenode
      var selNodes = self.getNodes(sel);
      
      function getParentArray(n){
        var arr = [], ln = n;
        while (ln._parent !== null)
          arr.push(ln = ln._parent);
        return arr.reverse(); // in correct order
      };

      //loop over the data nodes
      selNodes.forEach(function(n){
        //retrieve the node path
        //console.log(getParentArray(n));
        getParentArray(n).forEach(function(p){
          //get the DOM element for the datanode
          var ex = self.getTreeNode(p);
          //expand each node along the path
          self.expand(ex);
        });
      })
    }
  })
} ) ( apex.jQuery )
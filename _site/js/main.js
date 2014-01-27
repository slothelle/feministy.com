$(function(){

  var ClickListener = function ClickListener() {
    this.constructor;
  }

  ClickListener.prototype = {
    activate: function(klass) {
      $('a.' + klass).click(function(e) {
        e.preventDefault();
        $('div.' + klass).toggleClass('hidden');
      });
    }
  }

  collections = new ClickListener();
  collections.activate('collectionsMenu');

  patterns = new ClickListener();
  patterns.activate('patternsMenu');
});
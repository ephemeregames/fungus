(function() {
  var Random;
  Random = (function() {
    function Random() {}
    Random.prototype.next = function(from, to) {
      return Math.floor(Math.random() * (to - from + 1) + from);
    };
    return Random;
  })();
}).call(this);

(function() {
  Array.prototype.removeAt = function(from, to) {
    var rest, _ref;
    rest = this.slice((to || from) + 1 || this.length);
    this.length = (_ref = from < 0) != null ? _ref : this.length + {
      from: from
    };
    return this.push.apply(this(rest));
  };
  Array.prototype.clear = function() {
    return this.length = 0;
  };
}).call(this);

(function() {
  var Canvas;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  Canvas = (function() {
    function Canvas(tag) {
      this.tag = tag;
      this.resize = __bind(this.resize, this);
      this.draw = __bind(this.draw, this);
      this.addToDraw = __bind(this.addToDraw, this);
      this.initialize = __bind(this.initialize, this);
      this.context = tag.getContext('2d');
      this.width = this.context.canvas.width;
      this.height = this.context.canvas.height;
      this.toDraw = new Array;
      window.onresize = __bind(function() {
        return this.resize();
      }, this);
    }
    Canvas.prototype.initialize = function() {
      return this.resize();
    };
    Canvas.prototype.addToDraw = function(drawable) {
      return this.toDraw.push(drawable);
    };
    Canvas.prototype.draw = function() {
      var item, _i, _len, _ref;
      this.context.fillStyle = '#000000';
      this.context.fillRect(0, 0, this.width, this.height);
      _ref = this.toDraw;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        item = _ref[_i];
        item.draw(this.context);
      }
      return this.toDraw.clear();
    };
    Canvas.prototype.resize = function() {
      this.width = this.context.canvas.width = window.innerWidth;
      this.height = this.context.canvas.height = window.innerHeight;
      return this.draw();
    };
    return Canvas;
  })();
}).call(this);

(function() {
  var Canvas2D;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  Canvas2D = (function() {
    function Canvas2D(container) {
      var canvas;
      this.container = container;
      this.resize = __bind(this.resize, this);
      this.draw = __bind(this.draw, this);
      this.addToDraw = __bind(this.addToDraw, this);
      canvas = document.createElement('canvas');
      canvas.setAttribute('id', 'canvas');
      canvas.style.position = 'absolute';
      canvas.style.left = '0px';
      canvas.style.right = '0px';
      document.body.appendChild(canvas);
      this.context = canvas.getContext('2d');
      this.width = this.context.canvas.width;
      this.height = this.context.canvas.height;
      this.toDraw = new Array;
      $(window).bind('resize', __bind(function() {
        return this.resize();
      }, this));
      this.resize();
    }
    Canvas2D.prototype.addToDraw = function(drawable) {
      return this.toDraw.push(drawable);
    };
    Canvas2D.prototype.draw = function() {
      var item, _i, _len, _ref;
      this.context.clearRect(0, 0, this.width, this.height);
      _ref = this.toDraw;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        item = _ref[_i];
        item.draw(this.context);
      }
      return this.toDraw.clear();
    };
    Canvas2D.prototype.resize = function() {
      this.width = this.context.canvas.width = window.innerWidth;
      this.height = this.context.canvas.height = window.innerHeight;
      return this.draw();
    };
    return Canvas2D;
  })();
}).call(this);

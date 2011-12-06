(function() {
  var Text;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  Text = (function() {
    function Text(data) {
      this.data = data != null ? data : '';
      this.draw = __bind(this.draw, this);
      this.color = '#FF0000';
      this.position = [0, 0];
      this.size = 20;
      this.font = 'Lucida Sans Unicode';
    }
    Text.prototype.draw = function(canvas) {
      canvas.font = "" + this.size + "pt " + this.font;
      canvas.fillStyle = this.color;
      return canvas.fillText(this.data, this.position[0], this.position[1]);
    };
    return Text;
  })();
}).call(this);

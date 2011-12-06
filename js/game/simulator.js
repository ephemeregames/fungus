(function() {
  var Simulator;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  Simulator = (function() {
    function Simulator() {
      this.update = __bind(this.update, this);
    }
    Simulator.prototype.update = function() {};
    return Simulator;
  })();
}).call(this);

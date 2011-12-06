(function() {
  var Fungus;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  Fungus = (function() {
    function Fungus() {
      this.setTargetFPS = __bind(this.setTargetFPS, this);
      this.stop = __bind(this.stop, this);
      this.start = __bind(this.start, this);
      this.draw = __bind(this.draw, this);
      this.update = __bind(this.update, this);
      this.initialize = __bind(this.initialize, this);      this.scenes = new Scenes();
      this._timerVisual = new Timer(60);
      this._timerVisual.skipFrames = true;
      this._timerSimulator = new Timer(60);
    }
    Fungus.prototype.initialize = function() {
      this.scenes.initialize();
      this._timerVisual.callback = this.update;
      return this._timerSimulator.callback = this.draw;
    };
    Fungus.prototype.update = function() {};
    Fungus.prototype.draw = function() {
      return this.scenes.draw();
    };
    Fungus.prototype.start = function() {
      this._timerVisual.start();
      return this._timerSimulator.start();
    };
    Fungus.prototype.stop = function() {
      this._timerVisual.stop();
      return this._timerSimulator.stop();
    };
    Fungus.prototype.setTargetFPS = function(fps) {
      this._timerVisual.target = fps;
      return this._timerSimulator.target = fps;
    };
    Fungus.random = new Random();
    return Fungus;
  })();
}).call(this);

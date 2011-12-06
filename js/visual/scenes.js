(function() {
  var Scenes;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  Scenes = (function() {
    function Scenes() {
      this.resize = __bind(this.resize, this);
      this.draw = __bind(this.draw, this);
      this.setActive = __bind(this.setActive, this);
      this.createScene = __bind(this.createScene, this);
      this.initialize = __bind(this.initialize, this);      this.canvas = new Canvas3D($(window));
      this.canvas2d = new Canvas2D($(window));
      this._data = {};
      this.active = null;
      $(window).bind('resize', __bind(function() {
        return this.resize();
      }, this));
    }
    Scenes.prototype.initialize = function() {
      return this.canvas.initialize();
    };
    Scenes.prototype.createScene = function(name) {
      var scene;
      scene = new Scene();
      scene.initialize(this.canvas.size);
      this._data[name] = scene;
      return scene;
    };
    Scenes.prototype.setActive = function(name) {
      return this.active = this._data[name];
    };
    Scenes.prototype.draw = function() {
      this.canvas2d.draw();
      return this.canvas.draw(this.active, this.active.camera);
    };
    Scenes.prototype.resize = function() {
      var height, scene, width, _i, _len, _ref, _results;
      width = window.innerWidth;
      height = window.innerHeight;
      _ref = this._data;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        scene = _ref[_i];
        _results.push(scene.setSize({
          x: window.innerWidth,
          y: innerHeight
        }));
      }
      return _results;
    };
    return Scenes;
  })();
}).call(this);

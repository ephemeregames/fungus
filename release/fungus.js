(function() {
  var Canvas2D, Canvas3D, Fungus, Random, Scene, Scenes, Text, Timer;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; }, __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
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
  Timer = (function() {
    function Timer(target) {
      this.fps = __bind(this.fps, this);
      this.stop = __bind(this.stop, this);
      this.update = __bind(this.update, this);
      this.start = __bind(this.start, this);      this.target = target;
      this.average = 0;
      this.callback = null;
      this.skipFrames = false;
      this._currentTime = 0;
      this._accumulatedTime = 0;
    }
    Timer.prototype.start = function() {
      this._currentTarget = this.target;
      this._gameLoopTimer = setInterval(this.update, this._currentTarget);
      return this._currentTime = (new Date).getTime();
    };
    Timer.prototype.update = function() {
      var deltaTime, newTime, _results;
      if (this.target !== this._currentTarget) {
        stop();
        start();
        return;
      }
      newTime = (new Date).getTime();
      deltaTime = newTime - this._currentTime;
      this.average = this.average * 0.9 + deltaTime * 0.1;
      this._currentTime = newTime;
      this._accumulatedTime += deltaTime;
      if (this._accumulatedTime < this.target) {
        return;
      }
      if (this.skipFrames) {
        if (this._accumulatedTime >= this.target) {
          this.callback();
          this._accumulatedTime = 0;
        }
        return;
      }
      _results = [];
      while (this._accumulatedTime >= this.target) {
        this.callback();
        _results.push(this._accumulatedTime -= this.target);
      }
      return _results;
    };
    Timer.prototype.stop = function() {
      return clearInterval(this._gameLoopTimer);
    };
    Timer.prototype.fps = function() {
      return (this.target / this.average) * this.target;
    };
    return Timer;
  })();
  Random = (function() {
    function Random() {}
    Random.prototype.next = function(from, to) {
      return Math.floor(Math.random() * (to - from + 1) + from);
    };
    return Random;
  })();
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
  Canvas3D = (function() {
    function Canvas3D(container) {
      this.container = container;
      this.resize = __bind(this.resize, this);
      this.draw = __bind(this.draw, this);
      this.initialize = __bind(this.initialize, this);
      this.size = {
        x: this.container.width(),
        y: this.container.height()
      };
      this.renderer = new THREE.WebGLRenderer();
      this.renderer.setSize(this.size.x, this.size.y);
      this.renderer.setClearColor('#000000', 1);
      document.body.appendChild(this.renderer.domElement);
      this.container.bind('resize', __bind(function() {
        return this.resize();
      }, this));
    }
    Canvas3D.prototype.initialize = function() {
      return this.resize();
    };
    Canvas3D.prototype.draw = function(scene, camera) {
      return this.renderer.render(scene, camera);
    };
    Canvas3D.prototype.resize = function() {
      this.size.x = this.container.width();
      this.size.y = this.container.height();
      return this.renderer.setSize(this.size.x, this.size.y);
    };
    return Canvas3D;
  })();
  Scene = (function() {
    __extends(Scene, THREE.Scene);
    function Scene() {
      this.setSize = __bind(this.setSize, this);
      this.initialize = __bind(this.initialize, this);
      Scene.__super__.constructor.apply(this, arguments);
    }
    Scene.prototype.initialize = function(size) {
      this.camera = new THREE.PerspectiveCamera(75, size.x / size.y, 1, 10000);
      this.camera.position.z = 500;
      return this.scene.add(this.camera);
    };
    Scene.prototype.setSize = function(size) {
      this.camera.aspect = size.x / size.y;
      return this.camera.updateProjectionMatrix();
    };
    return Scene;
  })();
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

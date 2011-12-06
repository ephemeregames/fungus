(function() {
  var Scene;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; }, __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
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
}).call(this);

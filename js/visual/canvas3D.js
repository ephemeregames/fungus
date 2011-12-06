(function() {
  var Canvas3D;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
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
}).call(this);

(function() {
  var Timer;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
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
}).call(this);

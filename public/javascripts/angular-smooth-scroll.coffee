###*
 * angular smooth-scroll
 * 
 * @author atomita
 * @license MIT
 * @version 0.0.3
###
class SmoothScroll
  @$inject = []
  
  constructor: ()->
    @duration = "normal"
    @easing = "swing"
    
  normal: (target, easing, complete, step)->
    @to(target, "normal", easing, complete, step)
    return
    
  slow: (target, easing, complete, step)->
    @to(target, "slow", easing, complete, step)
    return
    
  fast: (target, easing, complete, step)->
    @to(target, "fast", easing, complete, step)
    return
    
  to: (target, duration, easing, complete, step)->
    position = angular.element(target).offset().top
    
    opt =
      "duration": duration or @duration
      "easing": easing or @easing
    is_comepleted = false
    if angular.isFunction(complete)
      opt.complete = (args...)->
        complete.apply(null, args) if not is_comepleted
        is_comepleted = true
    opt.step = ((args...)-> step.apply(null, args) if not is_comepleted) if angular.isFunction(step)
    
    angular.element("html, body").animate({"scrollTop": position}, opt)
    return
    
angular.module("smooth-scroll", []).service("$smoothScroll", SmoothScroll)



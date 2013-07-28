controller = ($rootScope, $s) ->
    $rootScope.section = 'home'

    # properties

    # methods
    $s.greetings = ->
    	alert 'HomeController'
controller.$inject = ['$rootScope', '$scope']
window.module.controller 'HomeController', controller
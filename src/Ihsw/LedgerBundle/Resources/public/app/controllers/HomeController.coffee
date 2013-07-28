controller = ($rootScope, $s) ->
    $rootScope.section = 'home'

    # properties

    # methods
    $s.greetings = ->
    	console.log 'HomeController'
controller.$inject = ['$rootScope', '$scope']
window.module.controller 'HomeController', controller
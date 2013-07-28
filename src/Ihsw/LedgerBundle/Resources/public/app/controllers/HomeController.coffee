controller = ($rootScope, $s) ->
    $rootScope.section = 'home'

    # properties

    # methods
    $s.greet = (message) ->
    	alert message
controller.$inject = ['$rootScope', '$scope']
window.module.controller 'HomeController', controller
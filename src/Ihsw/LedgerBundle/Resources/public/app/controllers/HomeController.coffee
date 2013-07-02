controller = ($rootScope) ->
    $rootScope.section = 'home'
controller.$inject = ['$rootScope']
window.module.controller 'HomeController', controller
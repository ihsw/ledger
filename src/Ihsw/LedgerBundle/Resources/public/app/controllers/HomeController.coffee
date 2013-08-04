controller = ($rootScope, $s, GeneralService) ->
    $rootScope.section = 'home'

    # properties
    $s.loading = false
    $s.summary = {}
    $s.pizza = true

    # methods
    $s.refresh = ->
        $s.loading = true

        GeneralService.summary().then (summary) ->
            $s.loading = false
            $s.summary = summary
    $s.greetings = ->
        console.log 'lol'

    # refreshing the page
    $s.refresh()
controller.$inject = ['$rootScope', '$scope', 'GeneralService']
window.module.controller 'HomeController', controller
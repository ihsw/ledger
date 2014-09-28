controller = ($rootScope, $s, EntryService, $filter) ->
    # nav
    $rootScope.section = 'entries'

    # properties
    $s.loading = false
    $s.list = {}

    # methods
    $s.refresh = ->
        $s.loading = true

        EntryService.query().then (list) ->
            $s.loading = false
            $s.list = list

    # initial load
    $s.refresh()
controller.$inject = ['$rootScope', '$scope', 'EntryService', '$filter']
window.module.controller 'Entry/IndexController', controller
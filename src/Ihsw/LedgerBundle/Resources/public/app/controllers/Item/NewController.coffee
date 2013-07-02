controller = ($rootScope, $s, $l, ItemService) ->
    # nav
    $rootScope.section = 'items'

    # properties
    $s.submitDisabled = true
    $s.name = ''

    # functions
    $s.refresh = ->
        $s.name = ''
        $s.submitDisabled = false
    $s.create = ->
        if $s.submitDisabled
            return
        $s.submitDisabled = true

        ItemService.create({ name: $s.name }).then (item) ->
            $s.refresh()
            $l.path '/items'

    # initial load
    $s.refresh()
controller.$inject = ['$rootScope', '$scope', '$location', 'ItemService']
window.module.controller 'ItemNewController', controller
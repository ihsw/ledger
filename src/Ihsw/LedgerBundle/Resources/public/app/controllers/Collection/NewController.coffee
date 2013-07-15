controller = ($rootScope, $s, $l, CollectionService) ->
    # nav
    $rootScope.section = 'collections'

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

        CollectionService.create({ name: $s.name }).then (collection) ->
            $s.refresh()
            $l.path '/collections'

    # initial load
    $s.refresh()
controller.$inject = ['$rootScope', '$scope', '$location', 'CollectionService']
window.module.controller 'Collection/NewController', controller
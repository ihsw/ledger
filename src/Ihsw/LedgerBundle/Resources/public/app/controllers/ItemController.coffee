controller = ($rootScope, $timeout, $s, ItemService) ->
    # nav
    $rootScope.section = 'items'

    # properties
    $s.loading = false
    $s.listMetadata = {}
    $s.list = {}
    $s.hasError = false

    # functions
    $s.refresh = ->
        $s.loading = true

        ItemService.query().then (list) ->
            $s.loading = false
            $s.list = list

            listMetadata = {}
            for itemId, item of list.values
                listMetadata[itemId] = { deleteDisabled: false }
            $s.listMetadata = listMetadata
    $s.delete = (item) ->
        if $s.listMetadata[item.id].deleteDisabled
            return
        $s.listMetadata[item.id].deleteDisabled = true

        ItemService.delete(item).then(->
            delete $s.listMetadata[item.id]
        , (response) ->
            $s.hasError = true
        )

    # initial load
    $s.refresh()
controller.$inject = ['$rootScope', '$timeout', '$scope', 'ItemService',]
window.module.controller 'ItemController', controller
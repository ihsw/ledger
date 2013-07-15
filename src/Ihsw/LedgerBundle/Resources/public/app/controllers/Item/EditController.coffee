controller = ($rootScope, $s, $l, $r, ItemService) ->
    # nav
    $rootScope.section = 'collections'

    # properties
    $s.loading = false
    $s.submitDisabled = true
    $s.name = ''
    $s.hasError = false
    $s.item = {}

    # functions
    $s.refresh = (itemId) ->
        $s.loading = true
        $s.submitDisabled = true
        $s.name = ''
        $s.hasError = false
        $s.item = {}

        ItemService.get(itemId).then((item) ->
            $s.loading = false
            $s.submitDisabled = false
            $s.name = item.name
            $s.item = item
        , (response) ->
            $s.loading = false
            $s.hasError = true
        )
    $s.update = (item) ->
        if $s.submitDisabled
            return
        $s.submitDisabled = true

        ItemService.update(item, { name: $s.name }).then (item) ->
            $l.path "/collection/#{item.collection.id}"

    # initial load
    $s.refresh($r.itemId)
controller.$inject = ['$rootScope', '$scope', '$location', '$routeParams', 'ItemService']
window.module.controller 'Item/EditController', controller
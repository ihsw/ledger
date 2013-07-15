controller = ($rootScope, $s, $l, $r, CollectionService, ItemService) ->
    # nav
    $rootScope.section = 'collections'

    # properties
    $s.loading = false
    $s.collection = {}
    $s.submitDisabled = true
    $s.hasError = false
    $s.name = ''

    # methods
    $s.refresh = ->
        $s.loading = true

        CollectionService.get($r.collectionId).then (collection) ->
            $s.submitDisabled = false
            $s.loading = false
            $s.collection = collection
    $s.create = ->
        if $s.submitDisabled
            return
        $s.submitDisabled = true

        item =
            name: $s.name
            collection: $s.collection
        ItemService.create(item).then (item) ->
            $l.path "/collection/#{$s.collection.id}"

    # initial load
    $s.refresh()
controller.$inject = ['$rootScope', '$scope', '$location', '$routeParams', 'CollectionService', 'ItemService']
window.module.controller 'Collection/AddItemController', controller
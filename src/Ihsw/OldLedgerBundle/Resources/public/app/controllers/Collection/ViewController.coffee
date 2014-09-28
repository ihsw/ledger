controller = ($rootScope, $s, $r, CollectionService, ItemService, $filter) ->
    # nav
    $rootScope.section = 'collections'

    # properties
    $s.loading = false
    $s.hasError = false
    $s.itemMetadata = {}

    # methods
    $s.refresh = (collectionId) ->
        $s.loading = true

        CollectionService.get(collectionId).then((collection) ->
            $s.loading = false
            $s.collection = collection

            itemMetadata = {}
            for itemId, item of collection.items
                deleteDisabled =
                    value: false
                    tooltip: 'Delete'
                if item.entry_items.length > 0
                    deleteDisabled =
                        value: true
                        tooltip: 'Has >0 entry-items'
                itemMetadata[itemId] = { deleteDisabled: deleteDisabled }
            $s.itemMetadata = itemMetadata
        , (response) ->
            $s.hasError = true
        )
    $s.deleteItem = (item) ->
        if $s.itemMetadata[item.id].deleteDisabled.value
            return
        $s.itemMetadata[item.id].deleteDisabled =
            value: true
            tooltip: 'Deleting'

        ItemService.delete(item).then (response) ->
            CollectionService.onItemDelete item
    $s.meta = (item) ->
        return $s.itemMetadata[item.id]

    # initial load
    $s.refresh($r.collectionId)
controller.$inject = ['$rootScope', '$scope', '$routeParams', 'CollectionService', 'ItemService', '$filter']
window.module.controller 'Collection/ViewController', controller
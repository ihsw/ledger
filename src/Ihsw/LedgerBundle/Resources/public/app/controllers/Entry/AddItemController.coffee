controller = ($rootScope, $s, $l, $r, EntryService, CollectionService, EntryItemService) ->
    # nav
    $rootScope.section = 'entries'

    # properties
    $s.loading = -1
    $s.items = []
    $s.item = {}
    $s.submitDisabled = false
    $s.hasError = false
    $s.cost = 0
    $s.quantity = 1

    # methods
    $s.refresh = () ->
        $s.loading = 2
        $s.submitDisabled = true

        EntryService.get($r.entryId).then (entry) ->
            $s.loading--
            $s.entry = entry
        CollectionService.get($r.collectionId).then (collection) ->
            $s.loading--
            $s.collection = collection
    $s.add = () ->
        if $s.submitDisabled
            return
        $s.submitDisabled = true

        entryItem =
            entry: $s.entry
            item: $s.item
            cost: $s.cost
            quantity: $s.quantity
        EntryItemService.create(entryItem).then((response) ->
            $l.path "/entry/#{entryItem.entry.id}"
        , (response) ->
            $s.hasError = true
        )
    $s.change = () ->
        $s.submitDisabled = false

    # initial load
    $s.refresh()
controller.$inject = ['$rootScope', '$scope', '$location', '$routeParams', 'EntryService', 'CollectionService', 'EntryItemService']
window.module.controller 'Entry/AddItemController', controller
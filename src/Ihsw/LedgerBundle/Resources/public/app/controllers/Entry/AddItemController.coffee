controller = ($rootScope, $s, $l, $r, EntryService, ItemService, EntryItemService) ->
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
    $s.refresh = (entryId) ->
        $s.loading = 2

        EntryService.get(entryId).then (entry) ->
            $s.loading--
            $s.entry = entry
        ItemService.query().then (items) ->
            $s.loading--
            $s.items = items
    $s.add = () ->
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

    # initial load
    $s.refresh($r.entryId)
controller.$inject = ['$rootScope', '$scope', '$location', '$routeParams', 'EntryService', 'ItemService', 'EntryItemService']
window.module.controller 'EntryAddItemController', controller
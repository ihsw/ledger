controller = ($rootScope, $s, $l, $r, EntryService, ItemService, EntryItemService) ->
    # nav
    $rootScope.section = 'entries'

    # properties
    $s.loading = -1
    $s.items = []
    $s.itemId = -1
    $s.submitDisabled = false
    $s.hasError = false
    $s.cost = 0
    $s.quantity = 1

    # methods
    $s.refresh = (entryItemId) ->
        $s.loading = 2

        EntryItemService.get(entryItemId).then (entryItem) ->
            $s.loading--
            $s.entryItem = entryItem

            $s.itemId = entryItem.item.id
            $s.cost = entryItem.cost
            $s.quantity = entryItem.quantity
        ItemService.query().then (items) ->
            $s.loading--
            $s.items = items
    $s.update = (entryItem) ->
        newEntryItem =
            entry: entryItem.entry
            item: $s.items[$s.itemId]
            cost: $s.cost
            quantity: $s.quantity
        EntryItemService.update(entryItem, newEntryItem).then((response) ->
            $l.path "/entry/#{entryItem.entry.id}"
        , (response) ->
            $s.hasError = true
        )

    # initial load
    $s.refresh($r.entryItemId)
controller.$inject = ['$rootScope', '$scope', '$location', '$routeParams', 'EntryService', 'ItemService', 'EntryItemService']
window.module.controller 'EntryItemEditController', controller
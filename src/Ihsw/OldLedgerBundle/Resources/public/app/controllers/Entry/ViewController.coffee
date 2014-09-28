controller = ($rootScope, $s, $r, EntryService, EntryItemService, $filter, $l) ->
    # nav
    $rootScope.section = 'entries'

    # properties
    $s.loading = false
    $s.hasError = false
    $s.entryItemMetadata = {}
    $s.entry = {}

    # methods
    $s.refresh = (entryId) ->
        $s.loading = true

        EntryService.get(entryId).then((entry) ->
            $s.loading = false
            $s.entry = entry

            entryItemMetadata = {}
            for entryItemId, entryItem of entry.entry_items
                entryItemMetadata[entryItemId] = { deleteDisabled: false }
            $s.entryItemMetadata = entryItemMetadata
        , (response) ->
            $s.hasError = true
        )
    $s.deleteEntryItem = (entryItem) ->
        if $s.entryItemMetadata[entryItem.id].deleteDisabled
            return
        $s.entryItemMetadata[entryItem.id].deleteDisabled = true

        EntryItemService.delete(entryItem).then (response) ->
            EntryService.onEntryItemDelete entryItem
    $s.delete = (entry) ->
        EntryService.delete(entry).then ->
            $l.path '/entries'

    # initial load
    $s.refresh($r.entryId)
controller.$inject = ['$rootScope', '$scope', '$routeParams', 'EntryService', 'EntryItemService', '$filter', '$location']
window.module.controller 'Entry/ViewController', controller
controller = ($rootScope, $s, $r, EntryService, EntryItemService) ->
    # nav
    $rootScope.section = 'entries'

    # properties
    $s.loading = false
    $s.hasError = false

    # methods
    $s.refresh = (entryId) ->
        $s.loading = true

        EntryService.get(entryId).then((entry) ->
            $s.loading = false
            $s.entry = entry
        , (response) ->
            $s.hasError = true
        )
    $s.deleteEntryItem = (entryItem) ->
        EntryItemService.delete(entryItem).then (response) ->
            EntryService.onEntryItemDelete entryItem

    # initial load
    $s.refresh($r.entryId)
controller.$inject = ['$rootScope', '$scope', '$routeParams', 'EntryService', 'EntryItemService']
window.module.controller 'EntryViewController', controller
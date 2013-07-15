controller = ($rootScope, $s, EntryService, $filter) ->
    # nav
    $rootScope.section = 'entries'

    # properties
    $s.loading = false
    $s.listMetadata = {}
    $s.list = {}

    # methods
    $s.refresh = ->
        $s.loading = true

        EntryService.query().then (list) ->
            $s.loading = false
            $s.list = list

            listMetadata = {}
            for entryId, entry of list
                deleteDisabled =
                    value: false
                    tooltip: 'Delete'
                if $filter('dictLength')(entry.entry_items) > 0
                    deleteDisabled =
                        value: true
                        tooltip: 'Has >0 entry-items'
                listMetadata[entryId] = { deleteDisabled: deleteDisabled }
            $s.listMetadata = listMetadata
    $s.delete = (entry) ->
        if $s.listMetadata[entry.id].deleteDisabled.value
            return
        $s.listMetadata[entry.id].deleteDisabled =
            value: true
            tooltip: 'Deleting'

        EntryService.delete(entry).then ->
            delete $s.listMetadata[entry.id]

    # utility
    $s.meta = (entry) ->
        return $s.listMetadata[entry.id]

    # initial load
    $s.refresh()
controller.$inject = ['$rootScope', '$scope', 'EntryService', '$filter']
window.module.controller 'Entry/IndexController', controller
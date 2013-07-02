controller = ($rootScope, $s, EntryService) ->
    # nav
    $rootScope.section = 'entries'

    # properties
    $s.loading = false
    $s.listMetadata = {}
    $s.list = {}

    # functions
    $s.refresh = ->
        $s.loading = true

        EntryService.query().then (list) ->
            $s.loading = false
            $s.list = list

            listMetadata = {}
            for entryId, entry of list.values
                listMetadata[entryId] = { deleteDisabled: false }
            $s.listMetadata = listMetadata
    $s.delete = (entry) ->
        if $s.listMetadata[entry.id].deleteDisabled
            return
        $s.listMetadata[entry.id].deleteDisabled = true

        EntryService.delete(entry).then ->
            delete $s.listMetadata[entry.id]

    # initial load
    $s.refresh()
controller.$inject = ['$rootScope', '$scope', 'EntryService']
window.module.controller 'EntryController', controller
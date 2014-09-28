controller = ($rootScope, $s, $l, $r, EntryService, CollectionService) ->
    # nav
    $rootScope.section = 'entries'

    # properties
    $s.loading = -1
    $s.collections = {}
    $s.collection = {}
    $s.submitDisabled = false
    $s.hasError = false

    # methods
    $s.refresh = () ->
        $s.loading = 2

        $s.submitDisabled = true
        EntryService.get($r.entryId).then (entry) ->
            $s.loading--
            $s.entry = entry
        CollectionService.query().then (collections) ->
            $s.loading--
            $s.collections = collections
    $s.change = () ->
        $s.submitDisabled = false
    $s.continue = (collection) ->
        if $s.submitDisabled
            return

        $l.path "/entry/#{$s.entry.id}/collection/#{collection.id}/add-item"

    # initial load
    $s.refresh()
controller.$inject = ['$rootScope', '$scope', '$location', '$routeParams', 'EntryService', 'CollectionService']
window.module.controller 'Entry/SelectCollectionController', controller
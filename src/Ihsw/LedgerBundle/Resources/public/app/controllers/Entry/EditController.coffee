controller = ($rootScope, $s, $l, $r, EntryService, $filter) ->
    # nav
    $rootScope.section = 'entries'

    # properties
    $s.loading = false
    $s.submitDisabled = true
    $s.occurredAt = ''
    $s.hasError = false
    $s.entry = {}

    # methods
    $s.refresh = (entryId) ->
        $s.loading = true
        $s.submitDisabled = true
        $s.occurredAt = ''
        $s.hasError = false
        $s.entry = {}

        EntryService.get(entryId).then((entry) ->
            $s.loading = false
            $s.submitDisabled = false
            $s.occurredAt = $filter('date') entry.occurred_at, 'MMM d, y h:mma'
            $s.entry = entry
        , (response) ->
            $s.loading = false
            $s.hasError = true
        )
    $s.update = (entry) ->
        if $s.submitDisabled
            return
        $s.submitDisabled = true

        EntryService.update(entry, {occurred_at: $s.occurredAt}).then (entry) ->
            $l.path '/entries'

    # initial load
    $s.refresh($r.entryId)
controller.$inject = ['$rootScope', '$scope', '$location', '$routeParams', 'EntryService', '$filter']
window.module.controller 'Entry/EditController', controller
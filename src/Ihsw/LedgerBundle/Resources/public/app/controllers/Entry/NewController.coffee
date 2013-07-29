controller = ($rootScope, $s, $l, EntryService) ->
    # nav
    $rootScope.section = 'entries'

    # properties
    $s.submitDisabled = true
    $s.occurredAt = ''
    $s.occurredAtPlaceholder = new Date()

    # methods
    $s.refresh = ->
        $s.occurredAt = ''
        $s.submitDisabled = false
    $s.create = ->
        if $s.submitDisabled
            return
        $s.submitDisabled = true

        EntryService.create({occurredAt: $s.occurredAt}).then (entry) ->
            $s.refresh()
            $l.path "/entry/#{entry.id}/select-collection"

    # initial load
    $s.refresh()
controller.$inject = ['$rootScope', '$scope', '$location', 'EntryService']
window.module.controller 'Entry/NewController', controller
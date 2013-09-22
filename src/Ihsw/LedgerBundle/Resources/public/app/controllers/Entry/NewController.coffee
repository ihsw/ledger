controller = ($rootScope, $s, $l, EntryService) ->
    # nav
    $rootScope.section = 'entries'

    # misc
    currentYear = new Date().getFullYear()

    # properties
    $s.submitDisabled = true
    $s.years = (year for year in [currentYear..currentYear-1])
    $s.months = (month for month in [1..12])
    $s.year = -1
    $s.month = -1

    # methods
    $s.refresh = ->
        $s.submitDisabled = true
        $s.change()
    $s.change = ->
        values = [$s.year, $s.month]
        submitDisabled = false
        for value in values
            if value == -1 or typeof value == 'undefined'
                submitDisabled = true
                break
        $s.submitDisabled = submitDisabled
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
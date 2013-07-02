window.module.controller 'BullshitController', ['$rootScope', '$scope', 'BullshitService', ($rootScope, $s, BullshitService) ->
    # nav
    $rootScope.section = 'bullshit'

    # properties
    $s.loading = false
    $s.list = []
    $s.listMetadata = {}

    # methods
    $s.refresh = ->
        $s.loading = true

        BullshitService.query($s).then (shits) ->
            $s.loading = false
            $s.list = shits

            listMetadata = {}
            for i, shit of shits
                listMetadata[shit.id] = { deleteDisabled: false }
            $s.listMetadata = listMetadata
    $s.delete = (shit) ->
        if !(String(shit.id) in Object.keys($s.listMetadata)) or $s.listMetadata[shit.id].deleteDisabled
            return
        $s.listMetadata[shit.id].deleteDisabled = true

        BullshitService.delete($s, shit).then ->
            delete $s.listMetadata[shit.id]

    # initial load
    $s.refresh()
]
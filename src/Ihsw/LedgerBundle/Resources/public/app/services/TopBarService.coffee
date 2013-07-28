service = ->
    S = {}

    # properties
    S.$directiveScope = {}

    # methods
    S.initialize = ($directiveScope) ->
        S.$directiveScope = $directiveScope
    S.setGroups = (groups) ->
        S.$directiveScope.setGroups groups
    S.resetGroups = ->
        if 'resetGroups' not of S.$directiveScope
            return
        S.$directiveScope.resetGroups()

    return S
window.module.service 'TopBarService', service
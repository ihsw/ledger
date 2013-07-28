service = ->
    S = {}

    # properties
    S.$directiveScope = {}

    # methods
    S.initialize = ($directiveScope) ->
        S.$directiveScope = $directiveScope
    S.addButton = (button) ->
        S.$directiveScope.buttons.push button
    S.resetButtons = ->
        if 'resetButtons' not of S.$directiveScope
            return
        S.$directiveScope.resetButtons()

    return S
window.module.service 'TopBarService', service
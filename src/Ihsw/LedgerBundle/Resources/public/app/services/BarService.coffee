service = ->
    S = {}

    # properties
    S.bars = {}

    # methods
    S.initialize = (name) ->
        S.bars[name] =
            name: name
            groups: {}
        return S.bars[name]
    S.setBarGroups = (name, groups) ->
        if !(name of S.bars)
            throw "tried to assign a bar to #{name} which does not exist"
        S.bars[name].groups = groups
    S.resetBarGroups = ->
        for name, bar of S.bars
            S.bars[name].groups = {}

    return S
window.module.service 'BarService', service
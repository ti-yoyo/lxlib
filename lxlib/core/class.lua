
local lx, _M, mt = oo{
    _cls_ = ''
}

local app, lf, tb, str, new = lx.kit()
local objectBase = require('lxlib.core.object')

function _M:new()

    local this = {
    }

    return oo(this, mt)
end

function _M:ctor(className)

    if lf.isObj(className) then
        className = className.__cls
    end

    local clsInfo = app:getClsInfo(className)
    self.bindInfo = app:getBind(className)
    self.path = self.bindInfo.bag
    self.clsInfo = clsInfo
    self.baseMt = clsInfo.baseMt
    self.clsBaseInfo = app:getClsBaseInfo(className)
end

function _M:hasMethod(name)

    return self.baseMt[name] and true or false
end

function _M:getPath()

    return self.path
end

function _M:getName()

    return self.className
end

function _M.c__:getMethods()

    local methods = {}
    for k, v in pairs(self.baseMt) do
        if type(v) == 'function' then
            if not (str.startsWith(k, '__')
                or (str.startsWith(k, '_') and str.endsWith(k, '_'))) then
                if not (k == 'new' or k == 'ctor') then
                    methods[k] = k
                end
            end
        end
    end

    return methods
end

function _M:isBond()

    return false
end

function _M:isAbstract()

    local baseInfo = self.clsBaseInfo

    return baseInfo.isAbstract and true or false
end

function _M:getBonds()
    
    return self.baseMt.__bonds
end

function _M:getMixins()

    local mixins = self.baseMt.__mixins
    local ret = {}
    for k, v in ipairs(mixins) do
        local cls = v.__cls
        ret[cls] = cls
    end

    return ret
end

function _M:is(cls)

    return objectBase.isInstanceOf(self.baseMt, cls)
end

return _M


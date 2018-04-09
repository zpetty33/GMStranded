--[[
	Name: sh_class.lua
	For:
	By: Ultra
]]--

g_ClassRegistry = g_ClassRegistry or {}

local _g 			= getfenv()
local setmetatable 	= setmetatable 
local getmetatable 	= getmetatable 
local pairs 		= pairs 
local type 			= type 
local error 		= error 
local tableMerge 	= table.Merge 
local tableCopy 	= table.Copy 
local tableinsert	= table.insert

local FindSuperFunc, NewClassInstance, DeleteClassInstance, DefineClass, ClassName
local InstanceClassRegistry, Singletons, cmeta = {}, {}, {}
local ClassIndex = 0
local meta_funcs = {
	["__tostring"] 	= true,
	["__newindex"] 	= true,
	["__mode"]  	= true,
	["__call"]  	= true,
	["__gc"] 		= true,
	["__eq"] 		= true,
	["__unm"]		= true,
	["__add"]		= true,
	["__sub"]		= true,
	["__mul"]		= true,
	["__div"]		= true,
	["__pow"]		= true,
	["__concat"]	= true,
	["__lt"] 		= true,
	["__le"] 		= true,
}

--Locals
--Finds a function in a parent(super) class
local function FindSuperFunc( tblClass, strFunc )
	local cur = tblClass
	while type( cur.super ) == "table" do
		if type( cur.super[strFunc] ) == "function" then
			return cur, cur.super[strFunc]
		end

		if cur == cur.super then break end
		cur = cur.super
	end

	return nil
end

--Gets all instances of a defined class object
local function GetClassInstances( tblClass )
	local t = InstanceClassRegistry
	if tblClass.__cmeta.namespace then
	    if t[tblClass.__cmeta.namespace] then
	        t = t[tblClass.__cmeta.namespace]
	    end
	end
	
	return t[tblClass.__cmeta.uid] or {}
end

local function IsAClass( tblClass, strClassName )
	return tblClass.__cmeta.name == strClassName
end

local function ClassName( tblClass )
	return tblClass.__cmeta.name
end

--Makes a new instance of a class (Class:New())
local function NewClassInstance( tblClassMeta, ... )
	if tblClassMeta.__cmeta.singleton and Singletons[tblClassMeta.__cmeta.uid] then
		return Singletons[tblClassMeta.__cmeta.uid]
	end

	local instance = tableCopy( tblClassMeta.__cmeta.members )
	local meta = { __index = tblClassMeta }
	for k, v in pairs( tblClassMeta ) do
		if meta_funcs[k] and type( v ) == "function" then
			meta[k] = v
		end
	end
	setmetatable( instance, meta )

	if type( instance.Initialize ) == "function" then
		instance.Initialize( instance, ... )
	else
		local _, func = FindSuperFunc( tblClassMeta, "Initialize" )
		if func then func( instance, ... ) end
	end

	local t = InstanceClassRegistry
	if tblClassMeta.__cmeta.namespace then
		if not t[tblClassMeta.__cmeta.namespace] then
			t[tblClassMeta.__cmeta.namespace] = {}
		end

		t = t[tblClassMeta.__cmeta.namespace]
	end
	
	if not t[tblClassMeta.__cmeta.uid] then
		t[tblClassMeta.__cmeta.uid] = {}
		setmetatable( t[tblClassMeta.__cmeta.uid], {__mode = "k"} ) --Weak keys make this act like auto unref.
	end

	t[tblClassMeta.__cmeta.uid][instance] = true
	if tblClassMeta.__cmeta.singleton then
		Singletons[tblClassMeta.__cmeta.uid] = instance
	end
	
	return instance
end

--Deletes a class instance (Class:Remove())
local function DeleteClassInstance( tblClassInst, ... )
	if type( tblClassInst.OnRemove ) == "function" then
		tblClassInst.OnRemove( tblClassInst, ... )
	else
		local _, func = FindSuperFunc( tblClassInst, "OnRemove" )
		if func then func( tblClassInst, ... ) end
	end

	--DeReference from instance registry
	local t = InstanceClassRegistry
	if tblClassInst.__cmeta.namespace then
		if t[tblClassInst.__cmeta.namespace] then
			t = t[tblClassInst.__cmeta.namespace]
		else
			tblClassInst = nil
			return
		end
	end
	
	if t[tblClassInst.uid] then
		t[tblClassInst.uid][tblClassInst] = nil
	end
	tblClassInst = nil
end

--Called after class vars are declared ( <tblClassMeta:DefineClass({Member Vars}) )
local function DefineClass( tblClassMeta, tblVars )
	if tblClassMeta.__cmeta.namespace then
		_g[tblClassMeta.__cmeta.namespace] = _g[tblClassMeta.__cmeta.namespace] or {}
		_g[tblClassMeta.__cmeta.namespace][tblClassMeta.__cmeta.name] = tblClassMeta
	else
		_g[tblClassMeta.__cmeta.name] = tblClassMeta
	end
    
	if tblClassMeta.super then
		tblClassMeta.__cmeta.members = tableCopy( tblClassMeta.super.__cmeta.members )
		if tblVars then
			tableMerge( tblClassMeta.__cmeta.members, tblVars )
		end
	else
		tblClassMeta.__cmeta.members = tblVars
	end

	tblClassMeta.__index 	= tblClassMeta
	tblClassMeta.SuperCall	= FindSuperFunc
	tblClassMeta.IsA 		= IsAClass
	tblClassMeta.ClassName 	= ClassName
	tblClassMeta.static 	= tblClassMeta.__cmeta.members
	if not tblClassMeta.__cmeta.abstract then
		tblClassMeta.New 			= NewClassInstance
		tblClassMeta.Remove 		= DeleteClassInstance
		tblClassMeta.GetInstances 	= GetClassInstances
	end
end

--Meta
--Sets the namespace of a class meta (Returned by Class(<string>))
function cmeta:Namespace( strNamespace )
	self.__cmeta.namespace = strNamespace
	return self
end

--Extends a class meta off of another class meta, optional namespace for the parent
--If no parent namespace is given, uses the child's namespace or _G
function cmeta:Extends( strParent, strNamespace )
	if strNamespace then
		strParent = _g[strNamespace][strParent]
	elseif self.__cmeta.namespace then
		strParent = _g[self.__cmeta.namespace][strParent]
	else
		strParent = _g[strParent]
	end

	if type( strParent ) ~= "table" or not strParent.__cmeta then
		print( "Invalid parent class for ".. self.__cmeta.name.. ", skipping." )
		return self
	end

	strParent.__cmeta.members = strParent.__cmeta.members or {}
	self.super = strParent
	setmetatable( self, {__index = strParent, __call = DefineClass} )

	return self
end

--Globals
--Checks if a var contains a class meta
function ValidClass( tblClass )
	if type( tblClass ) == "table" and type( tblClass.__cmeta ) == "table" then
		return true
	end

	return false
end

function Class( strClassName )
	ClassIndex = ClassIndex +1
	local obj = setmetatable( {
		__cmeta = {
			name = strClassName,
			uid = ClassIndex,
			members = {},
		},
	}, { 
		__index = cmeta,
		__call = DefineClass,
	} )

	g_ClassRegistry[ClassIndex] = obj
	return obj
end

--Just a class without a New() function
function AbstractClass( strClassName )
	local obj = Class( strClassName )
	obj.__cmeta.abstract = true
	return obj
end

--Keeps track of the first created instance and returns it for all other calls to New()
function Singleton( strClassName )
	local obj = Class( strClassName )
	obj.__cmeta.singleton = true
	return obj
end
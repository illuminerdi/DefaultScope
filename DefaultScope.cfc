<cfcomponent output="false">
  <cffunction name="init">
    <cfscript>
      this.version = "1.0";
      return this;
    </cfscript>
  </cffunction>

  <cffunction name="$validArguments">
    <cfscript>
      return listToArray( "where,order,select,distinct,include,maxRows,page,perPage,count,handle,cache,reload,parameterize,returnAs,returnIncluded");
    </cfscript>
  </cffunction>

  <cffunction name="findAlly" access="public" mixin="model">
    <cfargument name="where" type="string" required="false" default="" />
    <cfargument name="order" type="string" required="false" default="#application.wheels.functions.findAll.order#" />
    <cfargument name="select" type="string" required="false" default="" />
    <cfargument name="distinct" type="boolean" required="false" default="false" />
    <cfargument name="include" type="string" required="false" default="" />
    <cfargument name="maxRows" type="numeric" required="false" default="-1" />
    <cfargument name="page" type="numeric" required="false" default="0" />
    <cfargument name="perPage" type="numeric" required="false" default="#application.wheels.functions.findAll.perPage#" />
    <cfargument name="count" type="numeric" required="false" default="0" />
    <cfargument name="handle" type="string" required="false" default="query" />
    <cfargument name="cache" type="any" required="false" default="" />
    <cfargument name="reload" type="boolean" required="false" default="#application.wheels.functions.findAll.reload#" />
    <cfargument name="parameterize" type="any" required="false" default="#application.wheels.functions.findAll.parameterize#" />
    <cfargument name="returnAs" type="string" required="false" default="#application.wheels.functions.findAll.returnAs#" />
    <cfargument name="returnIncluded" type="boolean" required="false" default="#application.wheels.functions.findAll.returnIncluded#" />
    <cfscript>
      var loc = {};
      loc.validArguments = $validArguments();
      loc.arguments = {};

      // pull any defaults from the defaultScope
      if(structKeyExists(variables.wheels.class,'defaultscope')){
        for(loc.i = 1; loc.i lte arrayLen(loc.validArguments); loc.i = loc.i+1){
          if(structKeyExists(variables.wheels.class.defaultscope,loc.validArguments[loc.i])){
            loc.arguments[loc.validArguments[loc.i]] = variables.wheels.class.defaultscope[loc.validArguments[loc.i]];
          }
        }
      }

      // pull the args from the actual call - can override the defaultScope settings
      for(loc.i = 1; loc.i lte arrayLen(loc.validArguments); loc.i = loc.i+1){
      }

      return core.findAll(arguments.where, arguments.order, arguments.select, arguments.distinct, arguments.include, arguments.maxRows, arguments.page, arguments.perPage, arguments.count, arguments.handle, arguments.cache, arguments.reload, arguments.parameterize, arguments.returnAs, arguments.returnIncluded);
    </cfscript>
  </cffunction>

  <cffunction name="findAll" access="public" mixin="model">
    <cfscript>
      var loc = {};
      var findAllOriginal = core.findAll;
      loc.validArguments = $validArguments();
      loc.arguments={};

      // pull any defaults from the defaultScope
      if(structKeyExists(variables.wheels.class,'defaultscope')){
        for(loc.i = 1; loc.i lte arrayLen(loc.validArguments); loc.i = loc.i+1){
          if(structKeyExists(variables.wheels.class.defaultscope,loc.validArguments[loc.i])){
            loc.arguments[loc.validArguments[loc.i]] = variables.wheels.class.defaultscope[loc.validArguments[loc.i]];
          }
        }
      }

      // pull the args from the actual call - can override the defaultScope settings
      for(loc.i = 1; loc.i lte arrayLen(loc.validArguments); loc.i = loc.i+1){
        if(structKeyExists(arguments,loc.validArguments[loc.i])){
          loc.arguments[loc.validArguments[loc.i]] = arguments[loc.validArguments[loc.i]];
        }
      }

      // now create a string of args to pass to the super
      loc.arg_keys = structKeyArray(loc.arguments);
      loc.arg_list = "";
      for(loc.i = 1; loc.i lte arrayLen(loc.arg_keys); loc.i=loc.i+1){
        loc.arg_list = listAppend(loc.arg_list,"#loc.arg_keys[loc.i]#=loc.arguments['#loc.arg_keys[loc.i]#']");
      }

      return findAllOriginal(argumentCollection=loc.arguments);
    </cfscript>
  </cffunction>

  <cffunction name="defaultScope" access="public">
    <cfscript>
      loc = {};
      loc.validArguments = $validArguments();
      variables.wheels.class.defaultscope = {};
      for(loc.i = 1; loc.i lte arrayLen(loc.validArguments); loc.i=loc.i+1){
        if(structKeyExists(arguments,loc.validArguments[loc.i])){
          variables.wheels.class.defaultscope[loc.validArguments[loc.i]] = arguments[loc.validArguments[loc.i]];
        }
      }
    </cfscript>
  </cffunction>
</cfcomponent>
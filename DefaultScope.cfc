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

  <cffunction name="findAll" access="public" mixin="model">
    <cfscript>
      loc = {};
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

      return evaluate("core.findAll(#loc.arg_list#)");
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
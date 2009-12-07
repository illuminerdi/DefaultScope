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
      var loc = {};
      // this is to avoid a bug where a method called as part of a struct will throw an error when you pass it an argument collection.
      var findAllOriginal = core.findAll;
      loc.validArguments = $validArguments();
      // this is our argumentCollection struct.
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
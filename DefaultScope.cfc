<cfcomponent output="false">
  <cffunction name="init">
    <cfscript>
      this.version = "0.1";
      this.VALID_ARGUMENTS = listToArray( "where,order,select,distinct,include,maxRows,page,perPage,count,handle,cache,reload,parameterize,returnAs,returnIncluded");
      return this;
    </cfscript>
  </cffunction>

  <cffunction name="findAll" access="public">
    loc = {};
    loc.arguments={};

    // pull any defaults from the defaultScope
    if(structKeyExists(variables.wheels.class,'defaultscope')){
      for(loc.i = 1; loc.i lte arrayLen(this.VALID_ARGUMENTS); loc.i = loc.i+1){
        if(structKeyExists(variables.wheels.class.defaultscope,this.VALID_ARGUMENTS[loc.i])){
          loc.arguments[this.VALID_ARGUMENTS[loc.i]] = variables.wheels.class.defaultscope[this.VALID_ARGUMENTS[loc.i]];
        }
      }
    }

    // pull the args from the actual call - can override the defaultScope settings
    for(loc.i = 1; loc.i lte arrayLen(this.VALID_ARGUMENTS); loc.i = loc.i+1){
      if(structKeyExists(arguments,this.VALID_ARGUMENTS[loc.i])){
        loc.arguments[this.VALID_ARGUMENTS[loc.i]] = arguments[this.VALID_ARGUMENTS[loc.i]];
      }
    }

    // now create a string of args to pass to the super
    loc.arg_keys = structKeyArray(loc.arguments);
    loc.arg_list = "";
    for(loc.i = 1; loc.i lte arrayLen(loc.arg_keys); loc.i=loc.i+1){
      loc.arg_list = listAppend(loc.arg_list,"#loc.arg_keys[loc.i]#=loc.arguments['#loc.arg_keys[loc.i]#']");
    }

    return evaluate("core.findAll(#loc.arg_list#)");
  </cffunction>

  <cffunction name="defaultScope" access="public" mixin="model">
    <cfscript>
      var loc = {};
      variables.wheels.class.defaultscope = {};
      for(loc.i = 1; loc.i lte arrayLen(this.VALID_ARGUMENTS); loc.i=loc.i+1){
        if(structKeyExists(arguments,this.VALID_ARGUMENTS[loc.i])){
          variables.wheels.class.defaultscope[this.VALID_ARGUMENTS[loc.i]] = arguments[this.VALID_ARGUMENTS[loc.i]];
        }
      }
    </cfscript>
  </cffunction>
</cfcomponent>
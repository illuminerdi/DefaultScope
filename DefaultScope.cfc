<cfcomponent output="false">

	<cffunction name="init">
		<cfscript>
			this.version = "1.0";
			return this;
		</cfscript>
	</cffunction>

	<cffunction name="findAll" access="public" mixin="model">
		<cfscript>
			var findAllOriginal = core.findAll; // this is to avoid a bug in CF8 where a method called as part of a struct will throw an error when passed an argument collection.
			var key = "";
			// loop over the default arguments
			if (StructKeyExists(variables.wheels.class,"defaultScope")) {
				for(key in variables.wheels.class.defaultScope) {
					// if not present in the arguments, copy the default value
					if (not StructKeyExists(arguments,key) and $IsValidFindAllArgument(key)) {
						arguments[key] = variables.wheels.class.defaultScope[key];
					}
				}
			}
			return findAllOriginal(argumentCollection=arguments);
		</cfscript>
	</cffunction>

	<cffunction name="defaultScope" access="public" mixin="model">
		<cfscript>
			var key = "";
			// create/clear the settings struct
			variables.wheels.class.defaultScope = {};
			//loop over the incoming arguments and set them into the struct
			for(key in arguments) {
				if ($IsValidFindAllArgument(key))
					variables.wheels.class.defaultScope[key] = arguments[key];
			}
		</cfscript>
	</cffunction>

	<cffunction name="$IsValidFindAllArgument">
		<cfargument name="scopeName" type="string" required="true">
		<cfscript>
			return ( ListFindNoCase("where,order,select,distinct,include,maxRows,page,perPage,count,handle,cache,reload,parameterize,returnAs,returnIncluded",arguments.scopeName) gt 0);
		</cfscript>
	</cffunction>

</cfcomponent>

<h1>DefaultScope Plugin</h1>

<cfset info = createObject("component","DefaultScope").init() />

<cfoutput>
  CFWheels Required Version: #info.version#<br/>
  Argument List: #arrayToList(info.VALID_ARGUMENTS)#<br/>
</cfoutput>
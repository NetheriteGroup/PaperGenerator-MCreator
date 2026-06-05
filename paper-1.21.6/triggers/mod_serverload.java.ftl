<#include "procedures.java.ftl">
public class ${name}Procedure implements Listener {
	@EventHandler public void onWorldLoaded(WorldLoadEvent event) {
		<#assign dependenciesCode><#compress>
			<@procedureDependenciesCode dependencies, {
			"event": "event"
			}/>
		</#compress></#assign>
		execute(${dependenciesCode});
	}
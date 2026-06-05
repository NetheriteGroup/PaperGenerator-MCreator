<#include "procedures.java.ftl">
public class ${name}Procedure implements Listener {
	@EventHandler public void onSaplingGrow(StructureGrowEvent event) {
		<#assign dependenciesCode><#compress>
			<@procedureDependenciesCode dependencies, {
			"x": "event.getLocation().getX()",
			"y": "event.getLocation().getY()",
			"z": "event.getLocation().getZ()",
			"world": "event.getWorld()",
			"blockstate": "event.getWorld().getBlockState(event.getLocation())",
			"event": "event"
			}/>
		</#compress></#assign>
		execute(${dependenciesCode});
	}
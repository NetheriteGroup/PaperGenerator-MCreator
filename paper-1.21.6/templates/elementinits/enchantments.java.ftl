<#--
 # This file is part of Paper-Generator-MCreator.
 # Copyright (C) 2020-2025, Goldorion, opensource contributors
 #
 # Paper-Generator-MCreator is free software: you can redistribute it and/or modify
 # it under the terms of the GNU Lesser General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.
 # Paper-Generator-MCreator is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 # GNU Lesser General Public License for more details.
 #
 # You should have received a copy of the GNU Lesser General Public License
 # along with Paper-Generator-MCreator.  If not, see <https://www.gnu.org/licenses/>.
-->
<#include "../mcitems.ftl">
<#-- @formatter:off -->
package ${package}.init;

import io.papermc.paper.plugin.bootstrap.BootstrapContext;
import io.papermc.paper.plugin.bootstrap.PluginBootstrap;
import io.papermc.paper.plugin.lifecycle.event.LifecycleEventManager;

@SuppressWarnings("UnstableApiUsage")
public class ${JavaModName}Enchantments {

	public static void register(LifecycleEventManager<BootstrapContext> lifecycle) {
		lifecycle.registerEventHandler(RegistryEvents.ENCHANTMENT.compose().newHandler(event -> {
			<#list enchantments as enchantment>
			    <#assign supportedItems = enchantment.supportedItems>
				event.registry().register(EnchantmentKeys.create(Key.key("${modid}:${enchantment.getModElement().getRegistryName()}")),
						b -> b.description(Component.text("${enchantment.name}"))
								.supportedItems(
								    <#if supportedItems?size == 1 && supportedItems?first.getMappedValue().contains("TAG:")>
								        event.getOrCreateTag(ItemTypeTagKeys.create(Key.key("${supportedItems?first.getMappedValue()?replace("TAG:", "")}")))
								    <#else>
								        RegistrySet.keySet(RegistryKey.ITEM,<#list supportedItems as item>typedItem(${mappedMCItemToItemType(item)})<#sep>,</#list>)
								    </#if>
								)
								.anvilCost(${enchantment.anvilCost})
								.maxLevel(${enchantment.maxLevel})
								.weight(${enchantment.weight})
								.minimumCost(EnchantmentRegistryEntry.EnchantmentCost.of(1, 10))
								.maximumCost(EnchantmentRegistryEntry.EnchantmentCost.of(6, 10))
								.activeSlots(${generator.map(enchantment.supportedSlots, "equipmentslots")})
				);
			</#list>
		}));
	}

    private static TypedKey<ItemType> typedItem(ItemType item) {
        return TypedKey.create(RegistryKey.ITEM, item.key());
    }

	@NotNull
	public static Enchantment getEnchantment(@NotNull String key) {
		return RegistryAccess.registryAccess().getRegistry(RegistryKey.ENCHANTMENT).getOrThrow(new NamespacedKey("${modid}", key));
	}
}
<#-- @formatter:on -->

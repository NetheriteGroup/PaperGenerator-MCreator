<#include "mcitems.ftl">
(${mappedMCItemToItemStackCode(input$item, 1)}.containsEnchantment(${generator.map(field$enhancement, "enchantments")}))
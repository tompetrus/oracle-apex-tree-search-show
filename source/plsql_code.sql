FUNCTION tss_render
( p_dynamic_action in apex_plugin.t_dynamic_action
, p_plugin         in apex_plugin.t_plugin 
)
RETURN apex_plugin.t_dynamic_action_render_result
IS
  l_result apex_plugin.t_dynamic_action_render_result;
  l_search_item     VARCHAR2(100)  := p_dynamic_action.attribute_01;
  l_search_default  VARCHAR2(1)    := COALESCE(p_dynamic_action.attribute_02, 'Y');
  l_search_func     VARCHAR2(4000) := p_dynamic_action.attribute_03;
  l_match_class     VARCHAR2(100)  := COALESCE(p_dynamic_action.attribute_04, 'tss-search-match');
  l_color_text      VARCHAR2(100)  := p_dynamic_action.attribute_05;
  l_color_back      VARCHAR2(100)  := p_dynamic_action.attribute_06;
  
  l_region_id       NUMBER;
  l_static_id       VARCHAR2(400);
  l_onload_code     VARCHAR2(4000);  
  l_code            VARCHAR2(4000);
  l_crlf            CHAR(2) := CHR(13)||CHR(10);
BEGIN
  IF apex_application.g_debug
  THEN
    apex_plugin_util.debug_dynamic_action(
       p_plugin         => p_plugin,
       p_dynamic_action => p_dynamic_action 
    );
  END IF;
  
  SELECT affected_region_id
    INTO l_region_id
    FROM apex_application_page_da_acts
   WHERE action_id = p_dynamic_action.id;

  SELECT nvl(static_id, 'R'||region_id)
    INTO l_static_id
    FROM apex_application_page_regions
   WHERE region_id = l_region_id;
  
  l_onload_code := 'apex.jQuery("#'||l_static_id||' div[role=tree]").treeView("option", {'
    || apex_javascript.add_attribute('matchFunction', l_search_func)
    || apex_javascript.add_attribute('matchClass', l_match_class, false, false)
    ||'})';

  apex_javascript.add_onload_code (l_onload_code);
   
  IF l_color_text IS NOT NULL OR l_color_back IS NOT NULL THEN
    apex_css.add('#'||l_static_id||' .a-TreeView-node .'||l_match_class||' {color: '||COALESCE(l_color_text,'inherit')||';  background-color: '||COALESCE(l_color_back,'inherit')||';}');
  END IF;
   
  l_code := 
    'function(){ apex.jQuery("div[role=tree]", this.affectedElements).treeView("findAndShow", apex.item("'||l_search_item||'").getValue()); }';
   
  l_result.javascript_function := l_code;
  
  RETURN l_result;
END;
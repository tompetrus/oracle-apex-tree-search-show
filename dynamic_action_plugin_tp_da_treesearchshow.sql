set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050000 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2013.01.01'
,p_release=>'5.0.3.00.03'
,p_default_workspace_id=>27000294100083787867
,p_default_application_id=>90922
,p_default_owner=>'TPE'
);
end;
/
prompt --application/ui_types
begin
null;
end;
/
prompt --application/shared_components/plugins/dynamic_action/tp_da_treesearchshow
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(35004704688147578001)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'TP.DA.TREESEARCHSHOW'
,p_display_name=>'Tree Search and Show'
,p_category=>'EXECUTE'
,p_supported_ui_types=>'DESKTOP'
,p_javascript_file_urls=>'#PLUGIN_FILES#apex.widget.treeView.searchShow#MIN#.js'
,p_plsql_code=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'FUNCTION tss_render',
'( p_dynamic_action in apex_plugin.t_dynamic_action',
', p_plugin         in apex_plugin.t_plugin ',
')',
'RETURN apex_plugin.t_dynamic_action_render_result',
'IS',
'  l_result apex_plugin.t_dynamic_action_render_result;',
'  l_search_item     VARCHAR2(100)  := p_dynamic_action.attribute_01;',
'  l_search_default  VARCHAR2(1)    := COALESCE(p_dynamic_action.attribute_02, ''Y'');',
'  l_search_func     VARCHAR2(4000) := p_dynamic_action.attribute_03;',
'  l_match_class     VARCHAR2(100)  := COALESCE(p_dynamic_action.attribute_04, ''tss-search-match'');',
'  l_color_text      VARCHAR2(100)  := p_dynamic_action.attribute_05;',
'  l_color_back      VARCHAR2(100)  := p_dynamic_action.attribute_06;',
'  ',
'  l_region_id       NUMBER;',
'  l_static_id       VARCHAR2(400);',
'  l_onload_code     VARCHAR2(4000);  ',
'  l_code            VARCHAR2(4000);',
'  l_crlf            CHAR(2) := CHR(13)||CHR(10);',
'BEGIN',
'  IF apex_application.g_debug',
'  THEN',
'    apex_plugin_util.debug_dynamic_action(',
'       p_plugin         => p_plugin,',
'       p_dynamic_action => p_dynamic_action ',
'    );',
'  END IF;',
'  ',
'  SELECT affected_region_id',
'    INTO l_region_id',
'    FROM apex_application_page_da_acts',
'   WHERE action_id = p_dynamic_action.id;',
'',
'  SELECT nvl(static_id, ''R''||region_id)',
'    INTO l_static_id',
'    FROM apex_application_page_regions',
'   WHERE region_id = l_region_id;',
'  ',
'  l_onload_code := ''apex.jQuery("#''||l_static_id||'' div[role=tree]").treeView("option", {''',
'    || apex_javascript.add_attribute(''matchFunction'', l_search_func)',
'    || apex_javascript.add_attribute(''matchClass'', l_match_class, false, false)',
'    ||''})'';',
'',
'  apex_javascript.add_onload_code (l_onload_code);',
'   ',
'  IF l_color_text IS NOT NULL OR l_color_back IS NOT NULL THEN',
'    apex_css.add(''#''||l_static_id||'' .a-TreeView-node .''||l_match_class||'' {color: ''||COALESCE(l_color_text,''inherit'')||'';  background-color: ''||COALESCE(l_color_back,''inherit'')||'';}'');',
'  END IF;',
'   ',
'  l_code := ',
'    ''function(){ apex.jQuery("div[role=tree]", this.affectedElements).treeView("findAndShow", apex.item("''||l_search_item||''").getValue()); }'';',
'   ',
'  l_result.javascript_function := l_code;',
'  ',
'  RETURN l_result;',
'END;'))
,p_render_function=>'tss_render'
,p_standard_attributes=>'REGION'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>'Readme, Questions, Issues : go to the github link!'
,p_version_identifier=>'1.0'
,p_about_url=>'https://github.com/tompetrus/oracle-apex-tree-search-show'
,p_plugin_comment=>'The prefix for files and classes, etc is "tss", which is short for "tree search show". Only the javascript is not put in a plugin namespace nor prefixed with tss because it''s purpose is broader than this plugin.'
,p_files_version=>11
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(35006734991512610874)
,p_plugin_id=>wwv_flow_api.id(35004704688147578001)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Search Text'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>true
,p_supported_ui_types=>'DESKTOP'
,p_is_translatable=>false
,p_help_text=>'Item which contains the text to search the tree with'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(35006847348644641449)
,p_plugin_id=>wwv_flow_api.id(35004704688147578001)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Default Search (contains, case insensitive)'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>true
,p_default_value=>'Y'
,p_supported_ui_types=>'DESKTOP'
,p_is_translatable=>false
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'Use the default search pattern or not. The default search is a case-insensitive contains operation. If you want to search the nodes in another way you will need to define your own javascript function. Upon unchecking another item will show where you '
||'can provide this.',
'<br><br>',
'This is the default search function:',
'<pre>function(n,term){ return n.label.toLowerCase().indexOf(term.toLowerCase())!==-1;}</pre>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(35033774620172808233)
,p_plugin_id=>wwv_flow_api.id(35004704688147578001)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Search function (JS)'
,p_attribute_type=>'TEXTAREA'
,p_is_required=>true
,p_supported_ui_types=>'DESKTOP'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(35006847348644641449)
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'N'
,p_examples=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'Case insensitive, contains:',
'<pre>function(n,term){ return n.label.toLowerCase().indexOf(term.toLowerCase())!==-1;}</pre>',
'',
'Case sensitive, contains:',
'<pre>function(n,term){ return n.label.indexOf(term)!==-1;}</pre>'))
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'Provide a javascript function which is used to check each node. <br>',
'This is the default search function:',
'<pre>function(n,term){ return n.label.toLowerCase().indexOf(term.toLowerCase())!==-1;}</pre>',
'',
'The function takes 2 arguments. ',
'<ul>',
'<li>The NODE: the DATA node. Has properties "id" and "label" which you could use.</li>',
'<li>The TERM: the text to search for.</li>',
'</ul>',
'The function has to return true or false, which indicates if the node should be taken into the search results or not.'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(35006919809600039116)
,p_plugin_id=>wwv_flow_api.id(35004704688147578001)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Class for Matches'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'tss-search-match'
,p_supported_ui_types=>'DESKTOP'
,p_is_translatable=>false
,p_help_text=>'The CSS class to assign to matching results. You can use this class to style the nodes or easily retrieve them with jQuery.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(35033518001286737725)
,p_plugin_id=>wwv_flow_api.id(35004704688147578001)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Text Color'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_supported_ui_types=>'DESKTOP'
,p_is_translatable=>false
,p_help_text=>'A color to give to the text of matching result nodes. The color is only used on the associated tree.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(35033496500649364328)
,p_plugin_id=>wwv_flow_api.id(35004704688147578001)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_prompt=>'Background Color'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_supported_ui_types=>'DESKTOP'
,p_is_translatable=>false
,p_help_text=>'A color to give to the background of matching result nodes. The color is only used on the associated tree.'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2A2A0D0A202A2040617574686F7220546F6D205065747275730D0A202A204066696C656F7665727669657720457874656E6473207468652061706578207472656556696577207769646765742E2041206E65772066756E6374696F6E202266696E6441';
wwv_flow_api.g_varchar2_table(2) := '6E6453686F77222077696C6C20626520616464656420666F7220617661696C6162696C697479206F6E20746865207374616E64617264207769646765742E204974206973207573656420746F2073656172636820666F72206E6F64657320696E20612028';
wwv_flow_api.g_varchar2_table(3) := '7374617469632920747265652C20736574206120636C617373206F6E2074686520444F4D206E6F6465732C20616E64206F70656E20757020616C6C206272616E63686573206C656164696E6720757020746F2074686520666F756E64206E6F646573202D';
wwv_flow_api.g_varchar2_table(4) := '20696E6372656173696E67207669736962696C69747920746F2074686520656E6420757365722E200D0A202A20426520617761726520746861742074686520657874656E642068617320746F206F63637572206265666F72652061207472656520696E73';
wwv_flow_api.g_varchar2_table(5) := '74616E636520697320696E697469616C697A65642C206F74686572776973652074686174207472656520696E7374616E63652077696C6C206E6F742068617665207468697320657874726120617661696C61626C652E0D0A202A2F0D0A282066756E6374';
wwv_flow_api.g_varchar2_table(6) := '696F6E202820242C20756E646566696E65642029207B0D0A2020242E7769646765742822617065782E7472656556696577222C20242E617065782E74726565566965772C207B0D0A202020202F2A2A0D0A20202020202A206E6577206F7074696F6E7320';
wwv_flow_api.g_varchar2_table(7) := '6F6E20746865207769646765743A0D0A20202020202A2040706172616D206F7074696F6E732E6D61746368436C617373207B537472696E677D2054686520636C61737320746F2061737369676E20746F20656C656D656E7473206D61746368696E672074';
wwv_flow_api.g_varchar2_table(8) := '686520736561726368207061747465726E2E20446F6E277420666F72676574207468617420796F75206E65656420746F2061637475616C6C7920646566696E652061204353532072756C6520696620796F752077616E7420746F2073656520616E797468';
wwv_flow_api.g_varchar2_table(9) := '696E67206265696E6720636F6C6F726564210D0A20202020202A2040706172616D206F7074696F6E732E6D6174636846756E6374696F6E207B46756E6374696F6E7D205468652066756E6374696F6E20746F207573656420666F7220736561726368696E';
wwv_flow_api.g_varchar2_table(10) := '672074686520747265652E2052656369657665732074776F20696E70757420706172616D65746572733A2074686520747265652044415441206E6F646520616E642074686520736561726368207465726D2E204120626F6F6C65616E2076616C75652069';
wwv_flow_api.g_varchar2_table(11) := '732065787065637465642061732072657475726E2E205468652044454641554C542066756E6374696F6E616C69747920697320746F2073656172636820746865206E6F6465206C6162656C20666F7220746865206F63637572656E6365206F6620746865';
wwv_flow_api.g_varchar2_table(12) := '20736561726368207465726D2C20626F746820696E206C6F776572636173650D0A20202020202A2F0D0A202020206F7074696F6E733A207B0D0A2020202020206D6174636846756E6374696F6E3A2066756E6374696F6E286E2C7465726D297B20726574';
wwv_flow_api.g_varchar2_table(13) := '75726E206E2E6C6162656C2E746F4C6F7765724361736528292E696E6465784F66287465726D2E746F4C6F77657243617365282929213D3D2D313B7D0D0A202020202C206D61746368436C617373203A20227473732D7365617263682D6D61746368220D';
wwv_flow_api.g_varchar2_table(14) := '0A202020207D0D0A202020202C200D0A202020202F2A2A0D0A20202020202A20546869732066756E6374696F6E2077696C6C20706572666F726D206120736561726368206F6E20746865206E6577206170657820352074726565207769646765742C2061';
wwv_flow_api.g_varchar2_table(15) := '737369676E206120636C61737320746F2074686520656C656D656E742873292C20616E642077696C6C206F70656E20757020746865697220706172656E74206272616E6368657320736F2074686520726573756C74732061726520616C6C207669736962';
wwv_flow_api.g_varchar2_table(16) := '6C6520746F2074686520757365722E0D0A20202020202A205468652074726565207769646765742773207374616E64617264202266696E64222066756E6374696F6E616C6974792077696C6C206C6F6F6B207468726F7567682074686520646174616E6F';
wwv_flow_api.g_varchar2_table(17) := '64657320616E64207468656E2072657475726E20746865206D61746368696E6720736574206F6620646F6D20656C656D656E74732C20736F2069742074616B657320657874726120776F726B206F6E2074686520646576656C6F70657227732070617274';
wwv_flow_api.g_varchar2_table(18) := '20746F2061637475616C6C792070726573656E74207468697320666F756E64207365742C207768696368207468697320736E697070657420747269657320746F20616C6C6576696174652E0D0A20202020202A2040706172616D20705465726D207B5374';
wwv_flow_api.g_varchar2_table(19) := '72696E677D20546865207465726D20746F207365617263682074686520747265652773206E6F64657320776974680D0A20202020202A20406578616D706C65200D0A20202020202A2057697468204353533A0D0A20202020202A202E6D61746368436C61';
wwv_flow_api.g_varchar2_table(20) := '7373207B0D0A20202020202A202020636F6C6F723A207265642021696D706F7274616E743B0D0A20202020202A2020206261636B67726F756E642D636F6C6F723A20707572706C653B0D0A20202020202A207D0D0A20202020202A0D0A20202020202A20';
wwv_flow_api.g_varchar2_table(21) := '21212077697468207468652053544154494320524547494F4E2049442073657420746F206D79547265652021210D0A20202020202A0D0A20202020202A204A5320636F64653A0D0A20202020202A20617065782E6A51756572792822236D795472656520';
wwv_flow_api.g_varchar2_table(22) := '6469765B726F6C653D747265655D22292E747265655669657728226F7074696F6E222C207B6D61746368436C6173733A226D61746368436C617373227D293B0D0A20202020202A20617065782E6A51756572792822236D7954726565206469765B726F6C';
wwv_flow_api.g_varchar2_table(23) := '653D747265655D22292E7472656556696577282266696E64416E6453686F77222C22616222290D0A20202020202A0D0A20202020202A20546869732077696C6C2073656172636820666F7220616C6C206E6F646573207768657265206162206170706561';
wwv_flow_api.g_varchar2_table(24) := '727320616E6420636F6C6F72207468656D20696E2072656420616E6420707572706C652C20616E64206F70656E7320757020746865697220706172656E74206E6F6465730D0A20202020202A2F0D0A2020202066696E64416E6453686F773A2066756E63';
wwv_flow_api.g_varchar2_table(25) := '74696F6E202820705465726D2029207B0D0A2020202020207661722073656C66203D20746869733B0D0A2020202020200D0A2020202020202F2F706572666F726D2074686520736561726368206F7065726174696F6E206F6E2074686520747265650D0A';
wwv_flow_api.g_varchar2_table(26) := '2020202020207661722073656C203D2073656C662E66696E64287B64657074683A202D312C206D617463683A2066756E6374696F6E286E297B2072657475726E2073656C662E6F7074696F6E732E6D6174636846756E6374696F6E286E2C20705465726D';
wwv_flow_api.g_varchar2_table(27) := '293B207D2C2066696E64416C6C3A20747275657D293B0D0A2020202020200D0A2020202020202F2F69662061206D61746368436C61737320686173206265656E207370656369666965642C2072656D6F76652070726576696F75736C7920666F756E6420';
wwv_flow_api.g_varchar2_table(28) := '6E6F64657320616E6420746167206E657720726573756C74730D0A202020202020696620282073656C662E6F7074696F6E732E6D61746368436C6173732029207B0D0A20202020202020202428222E222B73656C662E6F7074696F6E732E6D6174636843';
wwv_flow_api.g_varchar2_table(29) := '6C6173732C2073656C662E656C656D656E74292E72656D6F7665436C6173732873656C662E6F7074696F6E732E6D61746368436C617373293B0D0A202020202020202073656C2E66696E6428227370616E2E612D54726565566965772D6C6162656C2229';
wwv_flow_api.g_varchar2_table(30) := '2E616464436C6173732873656C662E6F7074696F6E732E6D61746368436C617373293B0D0A2020202020207D3B0D0A2020202020200D0A2020202020202F2F6765742074686520646174616E6F64657320666F72206561636820666F756E642074726565';
wwv_flow_api.g_varchar2_table(31) := '6E6F64650D0A2020202020207661722073656C4E6F646573203D2073656C662E6765744E6F6465732873656C293B0D0A2020202020200D0A20202020202066756E6374696F6E20676574506172656E744172726179286E297B0D0A202020202020202076';
wwv_flow_api.g_varchar2_table(32) := '617220617272203D205B5D2C206C6E203D206E3B0D0A20202020202020207768696C6520286C6E2E5F706172656E7420213D3D206E756C6C290D0A202020202020202020206172722E70757368286C6E203D206C6E2E5F706172656E74293B0D0A202020';
wwv_flow_api.g_varchar2_table(33) := '202020202072657475726E206172722E7265766572736528293B202F2F20696E20636F7272656374206F726465720D0A2020202020207D3B0D0A0D0A2020202020202F2F6C6F6F70206F766572207468652064617461206E6F6465730D0A202020202020';
wwv_flow_api.g_varchar2_table(34) := '73656C4E6F6465732E666F72456163682866756E6374696F6E286E297B0D0A20202020202020202F2F726574726965766520746865206E6F646520706174680D0A20202020202020202F2F636F6E736F6C652E6C6F6728676574506172656E7441727261';
wwv_flow_api.g_varchar2_table(35) := '79286E29293B0D0A2020202020202020676574506172656E744172726179286E292E666F72456163682866756E6374696F6E2870297B0D0A202020202020202020202F2F6765742074686520444F4D20656C656D656E7420666F72207468652064617461';
wwv_flow_api.g_varchar2_table(36) := '6E6F64650D0A20202020202020202020766172206578203D2073656C662E676574547265654E6F64652870293B0D0A202020202020202020202F2F657870616E642065616368206E6F646520616C6F6E672074686520706174680D0A2020202020202020';
wwv_flow_api.g_varchar2_table(37) := '202073656C662E657870616E64286578293B0D0A20202020202020207D293B0D0A2020202020207D290D0A202020207D0D0A20207D290D0A7D2029202820617065782E6A51756572792029';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(35170230142261550479)
,p_plugin_id=>wwv_flow_api.id(35004704688147578001)
,p_file_name=>'apex.widget.treeView.searchShow.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2166756E6374696F6E28652C74297B652E7769646765742822617065782E7472656556696577222C652E617065782E74726565566965772C7B6F7074696F6E733A7B6D6174636846756E6374696F6E3A66756E6374696F6E28652C74297B72657475726E';
wwv_flow_api.g_varchar2_table(2) := '2D31213D3D652E6C6162656C2E746F4C6F7765724361736528292E696E6465784F6628742E746F4C6F776572436173652829297D2C6D61746368436C6173733A227473732D7365617263682D6D61746368227D2C66696E64416E6453686F773A66756E63';
wwv_flow_api.g_varchar2_table(3) := '74696F6E2874297B66756E6374696F6E206E2865297B666F722876617220743D5B5D2C6E3D653B6E756C6C213D3D6E2E5F706172656E743B29742E70757368286E3D6E2E5F706172656E74293B72657475726E20742E7265766572736528297D76617220';
wwv_flow_api.g_varchar2_table(4) := '613D746869732C6F3D612E66696E64287B64657074683A2D312C6D617463683A66756E6374696F6E2865297B72657475726E20612E6F7074696F6E732E6D6174636846756E6374696F6E28652C74297D2C66696E64416C6C3A21307D293B612E6F707469';
wwv_flow_api.g_varchar2_table(5) := '6F6E732E6D61746368436C6173732626286528222E222B612E6F7074696F6E732E6D61746368436C6173732C612E656C656D656E74292E72656D6F7665436C61737328612E6F7074696F6E732E6D61746368436C617373292C6F2E66696E642822737061';
wwv_flow_api.g_varchar2_table(6) := '6E2E612D54726565566965772D6C6162656C22292E616464436C61737328612E6F7074696F6E732E6D61746368436C61737329293B76617220733D612E6765744E6F646573286F293B732E666F72456163682866756E6374696F6E2865297B6E2865292E';
wwv_flow_api.g_varchar2_table(7) := '666F72456163682866756E6374696F6E2865297B76617220743D612E676574547265654E6F64652865293B612E657870616E642874297D297D297D7D297D28617065782E6A5175657279293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(35170293070231565194)
,p_plugin_id=>wwv_flow_api.id(35004704688147578001)
,p_file_name=>'apex.widget.treeView.searchShow.min.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done

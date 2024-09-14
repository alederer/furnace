#include "gui.h"
#include "guiConst.h"
#include <imgui.h>
#include "IconsFontAwesome4.h"
#include <unordered_set>

void FurnaceGUI::drawEffectList() {
  if (nextWindow==GUI_WINDOW_EFFECT_LIST) {
    effectListOpen=true;
    ImGui::SetNextWindowFocus();
    nextWindow=GUI_WINDOW_NOTHING;
  }
  if (!effectListOpen) return;
  ImGui::SetNextWindowSizeConstraints(ImVec2(60.0f*dpiScale,20.0f*dpiScale),ImVec2(canvasW,canvasH));
  if (ImGui::Begin("Effect List",&effectListOpen,globalWinFlags,_("Effect List"))) {
    float availB=ImGui::GetContentRegionAvail().x-ImGui::GetFrameHeightWithSpacing();
    if (availB>0) {
      ImGui::PushTextWrapPos(availB);
      ImGui::TextWrapped(_("Chip at cursor: %s"),e->getSystemName(e->sysOfChan[cursor.xCoarse]));
      ImGui::PopTextWrapPos();
    }
    effectSearch.Draw(_("Search"));
    ImGui::SameLine();
    ImGui::Button(ICON_FA_BARS "##SortEffects");
    if (ImGui::BeginPopupContextItem("effectSort",ImGuiPopupFlags_MouseButtonLeft)) {
      ImGui::Text(_("Effect types to show:"));
      for (int i=1; i<10; i++) {
        ImGui::PushStyleColor(ImGuiCol_Text,uiColors[i+GUI_COLOR_PATTERN_EFFECT_INVALID]);
        ImGui::Checkbox(_(fxColorsNames[i]),&effectsShow[i]);
        ImGui::PopStyleColor();
      }

      if (ImGui::Button(_("All"))) memset(effectsShow,1,sizeof(bool)*10);
      ImGui::SameLine();
      if (ImGui::Button(_("None"))) memset(effectsShow,0,sizeof(bool)*10);

      ImGui::EndPopup();
    }
    
    enum {
      EFFECT_CATEGORY_COUNT=GUI_COLOR_PATTERN_EFFECT_MISC-GUI_COLOR_PATTERN_EFFECT_INVALID,
      EFFECT_CATEGORY_PINNED=0
    };
    struct Effect { int value=-1; const char* name=NULL; };
    struct Category { int categoryId=-1; const char* name=NULL; std::vector<Effect> effects; };
    Category globalCategory;
    std::vector<Category> categories(EFFECT_CATEGORY_COUNT+1);
    bool categorize=settings.effectListViewType==1;

    // setup categories
    if (categorize) {
      categories[EFFECT_CATEGORY_PINNED]={GUI_COLOR_PATTERN_EFFECT_INVALID,_("Pinned"),{}};
      categories[GUI_COLOR_PATTERN_EFFECT_PITCH-GUI_COLOR_PATTERN_EFFECT_INVALID]={GUI_COLOR_PATTERN_EFFECT_PITCH,_("Pitch"),{}};
      categories[GUI_COLOR_PATTERN_EFFECT_VOLUME-GUI_COLOR_PATTERN_EFFECT_INVALID]={GUI_COLOR_PATTERN_EFFECT_VOLUME,_("Volume"),{}};
      categories[GUI_COLOR_PATTERN_EFFECT_PANNING-GUI_COLOR_PATTERN_EFFECT_INVALID]={GUI_COLOR_PATTERN_EFFECT_PANNING,_("Panning"),{}};
      categories[GUI_COLOR_PATTERN_EFFECT_SONG-GUI_COLOR_PATTERN_EFFECT_INVALID]={GUI_COLOR_PATTERN_EFFECT_SONG,_("Song"),{}};
      categories[GUI_COLOR_PATTERN_EFFECT_TIME-GUI_COLOR_PATTERN_EFFECT_INVALID]={GUI_COLOR_PATTERN_EFFECT_TIME,_("Time"),{}};
      categories[GUI_COLOR_PATTERN_EFFECT_SPEED-GUI_COLOR_PATTERN_EFFECT_INVALID]={GUI_COLOR_PATTERN_EFFECT_SPEED,_("Speed"),{}};
      categories[GUI_COLOR_PATTERN_EFFECT_SYS_PRIMARY-GUI_COLOR_PATTERN_EFFECT_INVALID]={GUI_COLOR_PATTERN_EFFECT_SYS_PRIMARY,_("System (primary)"),{}};
      categories[GUI_COLOR_PATTERN_EFFECT_SYS_SECONDARY-GUI_COLOR_PATTERN_EFFECT_INVALID]={GUI_COLOR_PATTERN_EFFECT_SYS_SECONDARY,_("System (secondary)"),{}};
      categories[GUI_COLOR_PATTERN_EFFECT_MISC-GUI_COLOR_PATTERN_EFFECT_INVALID]={GUI_COLOR_PATTERN_EFFECT_MISC,_("Misc"),{}};
    }

    // gather/categorize effects
    const char* prevName=NULL;
    for (int i=0; i<256; i++) {
      const char* name=e->getEffectDesc(i,cursor.xCoarse);
      if (name==prevName) continue;
      prevName=name;

      int fxColor=fxColors[i];
      if (name==NULL) continue;
      if (!effectsShow[fxColor-GUI_COLOR_PATTERN_EFFECT_INVALID]) continue;

      // check there are enough output channels for panning effects to be relevant
      if (fxColor==GUI_COLOR_PATTERN_EFFECT_PANNING) {
        DivDispatch* dispatch=e->getDispatch(e->dispatchOfChan[cursor.xCoarse]);
        int outputs=dispatch ? dispatch->getOutputCount() : 255;
        if (outputs<2) continue;
        if (outputs<3 && i>=0x88 && i<=0x8f) continue;
      }

      if (!effectSearch.PassFilter(name)) continue;

      // add to category(s)
      if (categorize) {
        categories[fxColor-GUI_COLOR_PATTERN_EFFECT_INVALID].effects.push_back({i, name});
        if (settings.effectListPinnedEffects.find(i)!=settings.effectListPinnedEffects.end()) {
          categories[0].effects.push_back({i, name});
        }
      } else {
        globalCategory.effects.push_back({i, name});
      }
    }

    // draw!
    if (categorize) {

      // use wider space more effectively with multiple columns
      float idealWidth=220.0f*dpiScale;
      int columnCount=MAX(1,(int)(ImGui::GetContentRegionAvail().x/idealWidth));

      for (Category& category : categories) {
        if (category.effects.empty()) continue;

        int hoverEffValue=-1;
        ImVec2 hoverEffItemRectMax{0.0f,0.0f};
        if (ImGui::TreeNodeEx(category.name, ImGuiTreeNodeFlags_DefaultOpen|ImGuiTreeNodeFlags_SpanAvailWidth)) {

          int rowCountMin=(int)(category.effects.size()/(float)columnCount);
          int remainder=category.effects.size()%columnCount;
          int effectIdx=0;
          if (ImGui::BeginTable("##table",columnCount,ImGuiTableFlags_SizingStretchSame)) {

            // singe row of N columns -- each column is its own table of [XXxx|description],
            // since word wrap shouldn't impact other columns
            ImGui::TableNextRow();
            for (int col=0; col<columnCount; col++) {
              ImGui::TableNextColumn();

              // ensure each subtable is distinct, to avoid layout issues in cases where
              // a subtable can be empty
              ImGui::PushID(col);
              if (ImGui::BeginTable("##subtable",2)) {
                ImGui::TableSetupColumn("c0",ImGuiTableColumnFlags_WidthFixed);
                ImGui::TableSetupColumn("c1",ImGuiTableColumnFlags_WidthStretch);

                int rowCount=rowCountMin;

                // the first `remainder` columns will have an extra row
                if (col<remainder) rowCount++;

                for (int row=0; row<rowCount && effectIdx<(int)category.effects.size(); row++, effectIdx++) {
                  const Effect& eff=category.effects[effectIdx];
                  ImGui::TableNextRow();
                  ImGui::TableNextColumn();
                  ImGui::PushFont(patFont);
                  ImGui::PushStyleColor(ImGuiCol_Text,uiColors[fxColors[eff.value]]);
                  ImGui::Text("%.4s", eff.name);
                  ImGui::PopStyleColor();
                  ImGui::PopFont();
                  ImGui::TableNextColumn();
                  if (strlen(eff.name)>6) {
                    ImGui::TextWrapped("%s",&eff.name[6]);
                  } else {
                    ImGui::Text(_("ERROR"));
                  }

                  ImGui::SameLine();
                  if (ImGui::IsItemHovered(ImGuiHoveredFlags_AllowWhenOverlapped|ImGuiHoveredFlags_RectOnly)) {
                    hoverEffValue=eff.value;
                    hoverEffItemRectMax=ImGui::GetCursorPos();
                  }
                }
                ImGui::EndTable();
              }
              ImGui::PopID(); // col
            }
            ImGui::EndTable();
          }
          ImGui::TreePop();
        }

        if (hoverEffValue!=-1) {
          // draw pin/unpin
          // @TODO: better hover detection and pin placement
          bool isPinned=settings.effectListPinnedEffects.find(hoverEffValue)!=settings.effectListPinnedEffects.end();
          ImVec2 pinSize=ImGui::CalcTextSize(isPinned ? ICON_FA_TRASH : ICON_FA_THUMB_TACK);
          const ImVec2 cursorPos=ImGui::GetCursorPos();
          ImVec2 pinPos=hoverEffItemRectMax;
          pinPos.x-=pinSize.x*2.0f;
          ImGui::SetCursorPos(pinPos);
          ImGui::SetNextItemAllowOverlap();
          if (isPinned && ImGui::Button(ICON_FA_TRASH "##Unpin")) {
            settings.effectListPinnedEffects.erase(hoverEffValue);
            writeConfig(e->getConfObject(),GUI_SETTINGS_PINNED_EFFECTS);
          } else if (!isPinned && ImGui::Button(ICON_FA_THUMB_TACK "##Pin")) {
            settings.effectListPinnedEffects.insert(hoverEffValue);
            writeConfig(e->getConfObject(),GUI_SETTINGS_PINNED_EFFECTS);
          }
          ImGui::SetCursorPos(cursorPos);
        }
      }
    } else {
      if (ImGui::BeginTable("effectList",2)) {
        ImGui::TableSetupColumn("c0",ImGuiTableColumnFlags_WidthFixed);
        ImGui::TableSetupColumn("c1",ImGuiTableColumnFlags_WidthStretch);

        ImGui::TableNextRow(ImGuiTableRowFlags_Headers);
        ImGui::TableNextColumn();
        ImGui::Text(_("Name"));
        ImGui::TableNextColumn();
        ImGui::Text(_("Description"));

        for (Effect& eff : globalCategory.effects) {
          ImGui::TableNextRow();
          ImGui::TableNextColumn();
          ImGui::PushFont(patFont);
          ImGui::PushStyleColor(ImGuiCol_Text,uiColors[fxColors[eff.value]]);
          ImGui::Text("%.4s",eff.name);
          ImGui::PopStyleColor();
          ImGui::PopFont();

          ImGui::TableNextColumn();
          if (strlen(eff.name)>6) {
            ImGui::TextWrapped("%s",&eff.name[6]);
          } else {
            ImGui::Text(_("ERROR"));
          }
        }

        ImGui::EndTable();
      }
    }
  }
  if (ImGui::IsWindowFocused(ImGuiFocusedFlags_ChildWindows)) curWindow=GUI_WINDOW_EFFECT_LIST;
  ImGui::End();
}

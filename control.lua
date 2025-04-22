-- control.lua
script.on_event("quick-bar-swap-ltr", function(event)
  local player = game.players[event.player_index]
  if not player then
    return
  end -- 플레이어가 없으면 함수 종료

  local current_page = player.get_active_quick_bar_page(1)

  -- 청사진 관련 아이템 체크
  local blueprint_items = {"blueprint", "blueprint-book", "upgrade-planner", "deconstruction-planner"}

  for i = 1, 10 do
    local slot_index = (current_page - 1) * 10 + i
    local item = player.get_quick_bar_slot(slot_index)
    if item and item.name then
      for _, blueprint_item in ipairs(blueprint_items) do
        if item.name == blueprint_item then
          player.print({"warning.blueprint-found"})
          return
        end
      end
    end
  end

  -- 임시 저장용 테이블
  local temp_slots = {}

  -- 1-5번 슬롯의 아이템을 임시 저장
  for i = 1, 5 do
    local slot_index = (current_page - 1) * 10 + i
    local item = player.get_quick_bar_slot(slot_index)
    temp_slots[i] = item
  end

  -- 6-10번 슬롯의 아이템을 1-5번으로 이동
  for i = 6, 10 do
    local from_index = (current_page - 1) * 10 + i
    local to_index = (current_page - 1) * 10 + (i - 5)
    local item = player.get_quick_bar_slot(from_index)
    player.set_quick_bar_slot(to_index, item)
  end

  -- 임시 저장한 1-5번 슬롯의 아이템을 6-10번으로 이동
  for i = 1, 5 do
    local from_index = (current_page - 1) * 10 + i
    local to_index = (current_page - 1) * 10 + (i + 5)
    player.set_quick_bar_slot(to_index, temp_slots[i])
  end
end)

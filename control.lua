-- control.lua
script.on_init(function()
  script.on_event("quick-bar-swap-ltr", function(event)
    local player = game.players[event.player_index]
    local current_page = player.get_active_quick_bar_page(1)

    -- 임시 저장용 테이블
    local temp_slots = {}

    -- 1-5번 슬롯의 아이템을 임시 저장
    for i = 1, 5 do
      local slot_index = (current_page - 1) * 10 + i
      temp_slots[i] = player.get_quick_bar_slot(slot_index)
    end

    -- 6-10번 슬롯의 아이템을 1-5번으로 이동
    for i = 6, 10 do
      local from_index = (current_page - 1) * 10 + i
      local to_index = (current_page - 1) * 10 + (i - 5)
      player.set_quick_bar_slot(to_index, player.get_quick_bar_slot(from_index))
    end

    -- 임시 저장한 1-5번 슬롯의 아이템을 6-10번으로 이동
    for i = 1, 5 do
      local from_index = (current_page - 1) * 10 + i
      local to_index = (current_page - 1) * 10 + (i + 5)
      player.set_quick_bar_slot(to_index, temp_slots[i])
    end
  end)
end)

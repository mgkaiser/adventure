.if !.xmatch(current_file, "actor.s")
    ; variables
    .import player: near
    .import dragon_1: near
    .import dragon_2: near
    .import dragon_3: near
    .import bat: near 
    .import magnet: near
    .import bridge: near 
    .import sword: near
    .import number: near
    .import chalice: near
    .import key: near    

    ; sprite data
    .import dragon_open : near
    .import dragon_closed : near
    .import number_one : near
    .import number_two : near
    .import number_three : near

    ; functions
    .import actor_init: near
    .import actor_copy: near
    .import actor_update_sprite: near
    .import actor_move: near

.endif

; Actor structure
.struct actor
    sprite_ptr      .byte   ; Pointer to sprite data
    sprite_num      .byte   ; Sprite number (0-7)
    room_num        .byte   ; Current room number
    color           .byte   ; Sprite color
    x_pos           .word   ; X position
    y_pos           .byte   ; Y position
    dx              .word   ; Delta X
    dy              .byte   ; Delta Y
    char_x          .byte   ; Sprite x cooridinate translated to character cell
    char_y          .byte   ; Sprite y cooridinate translated to character cell
.endstruct
    

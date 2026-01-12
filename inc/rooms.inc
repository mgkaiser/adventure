.if !.xmatch(current_file, "rooms.s")
    ; variables
    .import current_room: near
    .import difficulty_level: near

    ; functions
    .import display_room: near    
    .import next_room: near
    
.endif

; Room structure
.struct room
    room_data_ptr   .word   ; Pointer to room data
    color           .byte   ; Color BG in high nybble, Color FG in low nybble
    flags           .byte   ; Room flags (bit 7 = right thin wall, bit 6 = left thin wall)
    north           .byte   ; Room number to the north
    west            .byte   ; Room number to the west
    south           .byte   ; Room number to the south
    east            .byte   ; Room number to the east
.endstruct
    

    
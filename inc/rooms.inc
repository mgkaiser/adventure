.if !.xmatch(current_file, "rooms.s")
    ; variables
    .import current_room: near
    .import difficulty_level: near
    .import roomDataTable: near

    ; functions
    .import display_room: near    
    .import next_room: near
    .import get_next_room: near
    
.endif

; Room structure
.struct room
    room_data_ptr   .word   ; Pointer to room data
    color           .byte   ; Color BG in high nybble, Color FG in low nybble
    flags           .byte   ; Room flags (bit 7 = right thin wall, bit 6 = left thin wall)
    north           .byte   ; Room number to the north
    east            .byte   ; Room number to the east
    south           .byte   ; Room number to the south
    west            .byte   ; Room number to the west    
.endstruct
    

    
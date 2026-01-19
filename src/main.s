.scope
.define current_file "main.s"

.include "mac.inc"
.include "main.inc"
.include "rooms.inc"
.include "actor.inc"
.include "print.inc"
.include "basicstub.inc"    ; ONLY include this in main.s.  MUST be last include

.segment "MAIN"

; Define exports for all public functions in this module

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Variables that do not require initialization
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "BSS"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Variables that DO require initialization
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "DATA"

str_current_room: .byte "CUR: ", $00
str_difficulty:   .byte "DIF: ", $00
str_north:        .byte "N: ", $00
str_south:        .byte "S: ", $00
str_east:         .byte "E: ", $00
str_west:         .byte "W: ", $00

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Main Program Code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                
.segment "STUB"
.proc main: near

    ; Jump to main program
    jsr start

    rts

.endproc

.segment "MAIN"
; Main program entry point
; Usage:
;   Nothing
; Returns:
;   Nothing
; Results:
;   Main program loop executed
; Destroys:
;   All registers
.proc start: near
    
    ; Make the background loght grey and border black
    lda #VIC_COL_BLACK              ; Color value 
    sta VIC_BORDER_COL              ; Border color
    lda #VIC_COL_LIGHT_GRAY         ; Color value
    sta VIC_BG_COL                  ; Background color
    
    ; Clear the screen
    scnclr        

    ; Initialize actors    
    jsr actor_init

    ; Set the current room
    lda #$00
    sta current_room        ; Start in room 0
    sta difficulty_level    ; Start in easy mode    
    jsr display_room

main_loop:    

    ; Display the actors (this moves to interrupt eventually)
    mov_imm_16 R0, number  
    jsr actor_move     
    jsr actor_update_sprite    

    mov_imm_16 R0, player 
    jsr actor_move     
    jsr actor_update_sprite    

    printat #0, #22, str_current_room
    print_hex8 current_room
    printat #0, #23, str_difficulty
    print_hex8 difficulty_level
    printat #10, #22, str_north
    printat #16, #22, str_south
    printat #22, #22, str_east
    printat #28, #22, str_west
    print_next_room #13, #22, room::north
    print_next_room #19, #22, room::south
    print_next_room #25, #22, room::east
    print_next_room #31, #22, room::west    
    
    ; Check keys and act upon them
    getkey        
    gosub_if_char PETSCII_F1, select, main_end
    gosub_if_char PETSCII_F3, reset, main_end    
    gosub_if_char PETSCII_CURSOR_LEFT, process_left, main_end
    gosub_if_char PETSCII_CURSOR_RIGHT, process_right, main_end
    gosub_if_char PETSCII_CURSOR_UP, process_up, main_end
    gosub_if_char PETSCII_CURSOR_DOWN, process_down, main_end
    goto_if_char 'Q', exit_program  

main_end:      

    ; Loop if they didn't quit
    jmp main_loop

exit_program:

    ; Back to original colors
    lda #VIC_COL_LIGHT_BLUE         ; Color value 
    sta VIC_BORDER_COL              ; Border color
    lda #VIC_COL_BLUE               ; Color value
    sta VIC_BG_COL                  ; Background color
    
    ; Clear the screen
    scnclr        
            
    rts

.endproc

.proc process_left : near

    ; Process left movement
    ldy #room::west
    jsr next_room

    ; Redraw the room
    jsr display_room

    rts
.endproc

.proc process_right : near

    ; Process right movement    
    ldy #room::east
    jsr next_room

    ; Redraw the room
    jsr display_room

    rts
.endproc    

.proc process_up : near

    ; Process up movement
    ldy #room::north
    jsr next_room

    ; Redraw the room
    jsr display_room

    rts
.endproc    

.proc process_down : near

    ; Process down movement
    ldy #room::south
    jsr next_room

    ; Redraw the room
    jsr display_room

    rts
.endproc

.proc select : near

    ; Set the current room to the number room and display the room
    lda #$00
    sta current_room        ; Start in room 0    
    jsr display_room

    ; difficulty_level++
    clc
    lda difficulty_level    
    adc #$01
    cmp #3
    bne :+
    lda #0    
:   sta difficulty_level    
    
    ; PTR1 = &number
    mov_imm_16 PTR1, number

    ; if (difficulty_level == 0) number->room::room_num = 1
    ldy #actor::sprite_ptr
    lda difficulty_level
    bne :+
    lda #(number_one / 64)
    sta (PTR1), y
    bra select_end

    ; else if (difficulty_level == 1) number->room::room_num = 2    
:   lda difficulty_level
    cmp #1
    bne :+
    lda #(number_two / 64)
    sta (PTR1), y
    bra select_end

    ; else number->room::room_num = 3
:   lda #(number_three / 64)
    sta (PTR1), y

select_end:    
    rts
.endproc

.proc reset : near

    ; Reset the game state for the level

    ; Set the room to the starting room
    lda #$11
    sta current_room        ; Start in gold castle
    jsr display_room
    
    rts 
.endproc

.endscope
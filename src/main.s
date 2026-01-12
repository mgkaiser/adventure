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
    
    ; Check keys and act upon them
    getkey        
    gosub_if_char PETSCII_F1, select, main_end
    gosub_if_char PETSCII_F3, reset, main_end    
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
    lda #$08
    sta current_room        ; Start in gold castle
    jsr display_room
    
    rts 
.endproc

.endscope
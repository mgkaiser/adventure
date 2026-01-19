.scope
.define current_file "actor.s"

.include "mac.inc"
.include "rooms.inc"
.include "actor.inc"

.segment "MAIN"

; Define exports for all public variables in this module
.export player      ; Sprite 0
.export dragon_1    ; Sprite 1 - Only One dragon on screen at a time
.export dragon_2    ; Sprite 1
.export dragon_3    ; Sprite 1
.export bat         ; Sprite 2
.export bridge      ; Sprite 3 
.export gold_port   ; Sprite 8 - Not really a sprite.  Sprite > 7 means use character graphics
.export black_port  ; Sprite 8 - Not really a sprite.  Sprite > 7 means use character graphics
.export white_port  ; Sprite 8 - Not really a sprite.  Sprite > 7 means use character graphics
.export gold_key    ; Sprite 4  
.export black_key   ; Sprite 4  
.export white_key   ; Sprite 4  
.export magnet      ; Sprite 5
.export sword       ; Sprite 6
.export chalice     ; Sprite 7
.export number      ; Sprite 7 - Number and chalice never on screen at same time
.export sidewall    ; Sprite 9 - Not really a sprite.  Sprite > 7 means use character graphics  

; Define exports for sprite definitions
.export dragon_open
.export dragon_closed
.export number_one
.export number_two
.export number_three

; Define exports for all public functions in this module
.export actor_init
.export actor_copy
.export actor_update_sprite
.export actor_move

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Variables that do not require initialization
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "BSS"

player:     .res .sizeof(actor) ; The player actor structure
dragon_1:   .res .sizeof(actor) ; The first dragon actor structure
dragon_2:   .res .sizeof(actor) ; The second dragon actor structure
dragon_3:   .res .sizeof(actor) ; The third dragon actor structure
bat:        .res .sizeof(actor) ; The bat actor structure
magnet:     .res .sizeof(actor) ; The magnet actor structure
bridge:     .res .sizeof(actor) ; The bridge actor structure
sword:      .res .sizeof(actor) ; The sword actor structure
number:     .res .sizeof(actor) ; The number actor structure
chalice:    .res .sizeof(actor) ; The chalice actor structure
gold_key:   .res .sizeof(actor) ; The key actor structure   
white_key:  .res .sizeof(actor) ; The key actor structure   
black_key:  .res .sizeof(actor) ; The key actor structure   
gold_port:  .res .sizeof(actor) ; The key actor structure   
white_port: .res .sizeof(actor) ; The key actor structure   
black_port: .res .sizeof(actor) ; The key actor structure   
sidewall:   .res .sizeof(actor) ; The sidewall actor structure 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Variables that DO require initialization
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "DATA"
or_table: .byte $01, $02, $04, $08, $10, $20, $40, $80
and_table: .byte $FE, $FD, $FB, $F7, $EF, $DF, $BF, $7F

player_defaults:
    .byte player_sp / 64    ; sprite_ptr    
    .byte 0                 ; sprite_num
    .byte $11               ; room_num
    .byte VIC_COL_BLACK     ; color
    .word 100               ; x_pos
    .byte 150               ; y_pos
    .word 0                 ; dx   
    .byte 0                 ; dy
    .byte 0                 ; char_x
    .byte 0                 ; char_y

number_defaults:
    .byte number_one / 64   ; sprite_ptr    
    .byte 7                 ; sprite_num
    .byte $00               ; room_num
    .byte VIC_COL_GREEN     ; color
    .word 185               ; x_pos
    .byte 134               ; y_pos
    .word 0                 ; dx   
    .byte 0                 ; dy
    .byte 0                 ; char_x
    .byte 0                 ; char_y    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Sprite Data
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
.segment "SPRITE_DATA"

dragon_open:    .byte $80,$00,$00,$40,$00,$00,$26,$00
                .byte $00,$1f,$00,$00,$0b,$00,$00,$0e
                .byte $00,$00,$1e,$00,$00,$24,$00,$00
                .byte $44,$00,$00,$8e,$00,$00,$1e,$00
                .byte $00,$3f,$00,$00,$7f,$00,$00,$7f
                .byte $00,$00,$7f,$00,$00,$7f,$00,$00
                .byte $3e,$00,$00,$1c,$00,$00,$08,$00
                .byte $00,$f8,$00,$00,$e0,$00,$00,$07

dragon_closed:  .byte $06,$00,$00,$0f,$00,$00,$f3,$00
                .byte $00,$fe,$00,$00,$0e,$00,$00,$04
                .byte $00,$00,$04,$00,$00,$1e,$00,$00
                .byte $3f,$00,$00,$7f,$00,$00,$e3,$00
                .byte $00,$c3,$00,$00,$c3,$00,$00,$c7
                .byte $00,$00,$ff,$00,$00,$3c,$00,$00
                .byte $08,$00,$00,$8f,$00,$00,$e1,$00
                .byte $00,$3f,$00,$00,$00,$00,$00,$07   

number_one:     .byte $10,$00,$00,$30,$00,$00,$10,$00
                .byte $00,$10,$00,$00,$10,$00,$00,$10
                .byte $00,$00,$38,$00,$00,$00,$00,$00
                .byte $00,$00,$00,$00,$00,$00,$00,$00
                .byte $00,$00,$00,$00,$00,$00,$00,$00
                .byte $00,$00,$00,$00,$00,$00,$00,$00
                .byte $00,$00,$00,$00,$00,$00,$00,$00
                .byte $00,$00,$00,$00,$00,$00,$00,$01

number_two:     .byte $70,$00,$00,$88,$00,$00,$08,$00
                .byte $00,$10,$00,$00,$20,$00,$00,$40
                .byte $00,$00,$f8,$00,$00,$00,$00,$00
                .byte $00,$00,$00,$00,$00,$00,$00,$00
                .byte $00,$00,$00,$00,$00,$00,$00,$00
                .byte $00,$00,$00,$00,$00,$00,$00,$00
                .byte $00,$00,$00,$00,$00,$00,$00,$00
                .byte $00,$00,$00,$00,$00,$00,$00,$01

number_three:   .byte $70,$00,$00,$88,$00,$00,$08,$00
                .byte $00,$30,$00,$00,$08,$00,$00,$88
                .byte $00,$00,$70,$00,$00,$00,$00,$00
                .byte $00,$00,$00,$00,$00,$00,$00,$00
                .byte $00,$00,$00,$00,$00,$00,$00,$00
                .byte $00,$00,$00,$00,$00,$00,$00,$00
                .byte $00,$00,$00,$00,$00,$00,$00,$00
                .byte $00,$00,$00,$00,$00,$00,$00,$01

player_sp:      .byte $FF,$00,$00,$FF,$00,$00,$FF,$00
                .byte $00,$FF,$00,$00,$FF,$00,$00,$FF
                .byte $00,$00,$FF,$00,$00,$FF,$00,$00
                .byte $00,$00,$00,$00,$00,$00,$00,$00
                .byte $00,$00,$00,$00,$00,$00,$00,$00
                .byte $00,$00,$00,$00,$00,$00,$00,$00
                .byte $00,$00,$00,$00,$00,$00,$00,$00
                .byte $00,$00,$00,$00,$00,$00,$00,$01                

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Main Program Code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
.segment "MAIN"
.proc actor_init: near

    ; Initialize player actor
    mov_imm_16 R0, player
    mov_imm_16 R1, player_defaults        
    jsr actor_copy

    ; Initialize number actor
    mov_imm_16 R0, number
    mov_imm_16 R1, number_defaults
    jsr actor_copy

    rts
.endproc

; Actor copy routine
; Usage:
;   R0: Pointer to destination actor structure
;   R1: Pointer to source actor structure
; Returns:
;   Nothing
; Results:
;   Actor structure copied
; Destroys:
;   All registers
.proc actor_copy : near
    
    ldy #$00
actor_copy_loop:    
    lda (R1), y
    sta (R0), y      
    iny
    cpy #.sizeof(actor)    
    bne actor_copy_loop

    rts

.endproc

; Actor sprite update routine
; Usage:
;   R0: Pointer to actor structure
; Returns:
;   Nothing
; Results:
;   Actor sprite updated
; Destroys:
;   All registers
.proc actor_update_sprite: near

    ; Get sprite number
    ldy #actor::sprite_num
    lda (R0), y
    sta R1L

    ; Is the sprite number 8 or 9?    
    cmp #$08
    bne :+
    jmp actor_as_character_graphics
:   cmp #$09 
    bne :+
    jmp actor_as_character_graphics
:   

    ; Is the actor in the current room?
    ldy #actor::room_num
    lda (R0), y
    cmp current_room
    bne actor_update_sprite_hide

    ; Show the actor
    lda VIC_SPRITE_EN
    ldx R1L    
    ora or_table,X
    sta VIC_SPRITE_EN
        
    ; PTR1 = $D000 + (R1L * 2)    
    lda R1L
    asl a
    clc    
    sta PTR1
    lda #$D0
    sta PTR1+1

    ; PTR1->0 = R0->actor::x_pos
    ldy #actor::x_pos
    lda (R0), y
    ldy #$00    
    sta (PTR1), y
        
    ; Decide if we set or clear the high bit
    ldy #actor::x_pos+1
    lda (R0), y
    and #$01
    beq clear_high_bit

    ; Set the high bit
    ldx R1L
    lda VIC_SPRITEX_MSB
    ora or_table,x
    sta VIC_SPRITEX_MSB

    bra high_bit_endif

clear_high_bit:
    
    ; Clear the high bit   
    ldx R1L
    lda VIC_SPRITEX_MSB
    and and_table,x
    sta VIC_SPRITEX_MSB

high_bit_endif:
    ; PTR1->1 = R0->actor::y_pos
    ldy #actor::y_pos
    lda (R0), y
    ldy #$01
    sta (PTR1), y

    ; Set the sprite color
    ldy #actor::color
    lda (R0), y
    ldx R1L
    sta VIC_SPRITE_COL1,x    

    ; Set the sprite Image
    ldy #actor::sprite_ptr
    lda (R0), y
    ldx R1L
    sta VIC_SPRITEPTR,x

    bra actor_update_sprite_end

actor_update_sprite_hide:

    ; Hide the actor sprite
    lda VIC_SPRITE_EN
    ldx R1L    
    and and_table,X
    sta VIC_SPRITE_EN

actor_update_sprite_end:    

    rts

actor_as_character_graphics:

    ; Is the actor in the current room?
    ldy #actor::room_num
    lda (R0), y
    cmp current_room
    bne actor_as_character_graphics_end    

    ; Display the right characters graphics and color for the actor
    ; If Sprite number is 8, it's a portcullis and sprite_ptr represents how open it is

actor_as_character_graphics_end:    

    rts

.endproc

; Actor movement routine
; Usage:
;   R0: Pointer to actor structure
; Returns:
;   Nothing
; Results:
;   Actor position updated
; Destroys:
;   All registers
.proc actor_move: near

    ; TMP1 = R0->actor::x_pos + R0->actor::dx
    clc
    ldy #actor::x_pos
    lda (R0), y
    ldy #actor::dx
    adc (R0), y
    sta TMP1
    ldy #actor::x_pos+1
    lda (R0), y
    adc (R0), y
    sta TMP1+1

    ; TMP2 = R0->actor::y_pos + R0->actor::dy
    ldy #actor::y_pos
    lda (R0), y
    ldy #actor::dy
    adc (R0), y
    sta TMP2
    
    ; TMP3L = (TMP1 - 24) / 8
    sec             ; TMP3L = (TMP1 - 24)    
    lda TMP1        
    sbc #24    
    sta TMP3L
    lda TMP1+1
    sbc #0
    sta TMP3H    
    .repeat 3       ; TMP3L = TMP3L / 8
    lsr TMP3H
    ror TMP3L
    .endrepeat

    ; TMP3H = (TMP2 - 50) / 8
    sec             ; TMP3H = (TMP2 - 50)
    lda TMP2        
    sbc #50
    sta TMP3H
    .repeat 3       ; TMP3H = TMP3H / 8
    ror TMP3H
    .endrepeat  

    ; Is the character at this cell a space?

    ; PTR1 = $0400 + (TMP2 * 40) + TMP1
    lda TMP2        ; PTR1 = (TMP2 * 40)
    .repeat 5
    asl a
    .endrepeat
    sta PTR1
    lda TMP2
    .repeat 3
    asl a
    .endrepeat
    clc
    adc PTR1
    sta PTR1

    clc             ; PTR1 = PTR1 + TMP1 + $0400
    lda TMP1        
    adc PTR1
    sta PTR1
    lda TMP1+1    
    adc PTR1+1
    sta PTR1+1

    clc             ; PTR1 = PTR1 + $0400
    lda PTR1
    adc #$04
    sta PTR1
    lda PTR1+1
    adc #$00
    sta PTR1+1

    ; Add code here to skip the check if the actor is within the bounding box of the bridge

    ; Is the proposed new location a space?
    ldy #$00
    lda (PTR1), y   ; A = screen memory at PTR1
    cmp #' '        ; Is it a space?
    bne discard_the_result  ; If not, discard the new position  
    
    ; R0=>actor::x_pos = TMP1
    ldy #actor::x_pos
    lda TMP1
    sta (R0), y
    ldy #actor::x_pos+1
    lda TMP1+1
    sta (R0), y

    ; R0=>actor::y_pos = TMP2
    ldy #actor::y_pos
    lda TMP2
    sta (R0), y
    
    ; R0->actor::char_x = TMP3L
    ldy #actor::char_x
    lda TMP3L
    sta (R0), y
    ; R0->actor::char_y = TMP3H
    ldy #actor::char_y
    lda TMP3H
    sta (R0), y

discard_the_result:

    rts 
.endproc

.endscope
.if !.xmatch(current_file, "main.s")
    .import display_template: near    
.endif

.macro print_next_room col_pos, row_pos, ofs

    ; TMP1 = current_room * 8
    lda current_room
    asl a    
    asl a    
    asl a
    sta TMP1
    lda #$00
    sta TMP1+1

    ; PTR1 = &roomDataTable + TMP1
    clc
    lda #<roomDataTable    
    adc TMP1
    sta PTR1
    lda #>roomDataTable
    adc TMP1+1
    sta PTR1+1

    print_hex_at_8 col_pos, row_pos, PTR1, ofs

.endmacro
    
; Matt Lee
; String Find
; x86 Assembly

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
	targetLength DWORD ?      
	sourceLength DWORD ?
	position DWORD ?
	stop DWORD ?
.code

	Str_len PROC USES edi, pString:PTR BYTE   ; pointer to string
			mov edi,pString			
			mov eax,0			; character count
		L1: cmp BYTE PTR[edi],0	; end of string?
			je L2				; yes: quit
			inc edi				;no: point to next
			inc eax				; add 1 to char count	
			jmp L1
		L2: ret
	Str_len ENDP

	Str_find PROC, pSource:PTR BYTE, pTarget:PTR BYTE
		INVOKE Str_len, pTarget  ; get length of target
		mov targetLength, eax
		INVOKE Str_len, pSource  ; get length of source
		mov sourceLength, eax
		mov edi, pTarget   ; target pointer
		mov esi, pSource   ; source pointer


		; To compute the position in target to stop search
		; stops at 1 + the number of characters difference between target and source

		mov eax,edi     ; stop = (offset target)
		add eax,targetLength     ; + targetLength
		sub eax,sourceLength	 ; - sourceLength
		inc eax					 ; +1
		mov stop,eax		     ; save stopping pos

		; Compare source and current target

		cld						; clear direction flag
		mov ecx,sourceLength     ; set counter to source length
		L1:
			pushad				; push all registers to the stack
			repe cmpsb			 ; compare all bytes
			popad				; pop all registers
			je found             ; if found, exit
			inc edi				; mov to next target pos
			cmp edi,stop		; check if edi has reached stop position
			jae notfound         ; exit if it has
			jmp L1				; continue loop if not
		found:
			mov eax,edi			; move successful position into eax
			cmp eax,eax         ; set ZF to 1
			jmp done
		notfound:
			or eax,1			; sets ZF to 0
		done: 
			ret

	Str_find ENDP

	

END 
		

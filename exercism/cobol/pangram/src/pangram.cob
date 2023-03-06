        IDENTIFICATION DIVISION.
        PROGRAM-ID. PANGRAM.
        ENVIRONMENT DIVISION.
        DATA DIVISION.
        WORKING-STORAGE SECTION.
        01 WS-SENTENCE PIC X(60).
        01 WS-RESULT PIC 9.
      / the current letter
        01 WS-CHAR PIC X.
      / counter for the number of letters in the sentence
        01 WS-CTR PIC 9.
      / array of letters we already found
        01 WS-LETTERS PIC X(26) VALUE SPACES.
        PROCEDURE DIVISION.
        PANGRAM.
        perform str-loop until ws-ctr = 26
        if ws-ctr = 26
        move 1 to ws-result
        end-if

        .str-loop
      / get the next character
        move ws-sentence to ws-char
      / if it's a letter
        if ws-char in 'a' to 'z'
      / and we haven't seen it before
        if ws-char not in ws-letters
      / add it to the list of letters we've seen
        move ws-char to ws-letters
      / and increment the counter
        add 1 to ws-ctr
        end-if
        end-if

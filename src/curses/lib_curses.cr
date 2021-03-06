@[Link("ncurses")]
lib LibCurses
  type Window = Void*

  enum Attribute : UInt32
    # generated by: https://gist.github.com/waterlink/8683a1069c5a3a791170
       NORMAL =          0_u32 # - Normal display (no highlight)
     STANDOUT =      65536_u32 # - Best highlighting mode of the terminal.
    UNDERLINE =     131072_u32 # - Underlining
      REVERSE =     262144_u32 # - Reverse video
        BLINK =     524288_u32 # - Blinking
          DIM =    1048576_u32 # - Half bright
         BOLD =    2097152_u32 # - Extra bright or bold
      PROTECT =   16777216_u32 # - Protected mode
        INVIS =    8388608_u32 # - Invisible or blank mode
   ALTCHARSET =    4194304_u32 # - Alternate character set
       ITALIC = 2147483648_u32 # - Italics (non-X/Open extension)
     CHARTEXT =        255_u32 # - Bit-mask to extract a character
  end

  $lines = LINES : Int32
  $cols = COLS : Int32

  fun initscr : Window
  fun printw(...)
  fun refresh
  fun getch : Int32
  fun cbreak : Int32
  fun noecho : Int32
  fun nonl : Int32

  fun start_color : Int32
  fun init_pair(p : Int16, f : Int16, b : Int16) : Int32
  fun color_set(p : Int16, opts : Void*) : Int32
  fun wcolor_set(w : Window, p : Int16, opts : Void*) : Int32

  fun chgat(n : Int32, attr : Attribute, color_pair : Int16, opts : Void*) : Int32
  fun wchgat(w : Window, n : Int32, attr : Attribute, color_pair : Int16, opts : Void*) : Int32
  fun mvchgat(y : Int32, x : Int32, n : Int32, attr : Attribute, color_pair : Int16, opts : Void*) : Int32
  fun mvwchgat(w : Window, y : Int32, x : Int32, n : Int32, attr : Attribute, color_pair : Int16, opts : Void*) : Int32

  fun move(y : Int32, x : Int32) : Int32
  fun wmove(w : Window, y : Int32, x : Int32) : Int32

  fun addstr(s : UInt8*) : Int32
  fun waddstr(w : Window, s : UInt8*) : Int32

  fun newwin(height : Int32, width : Int32, top : Int32, left : Int32) : Window
  fun box(w : Window, v : Int32, h : Int32) : Int32
  fun endwin

  fun delwin(window : Window)
  fun wrefresh(window : Window)
  fun wgetch(window : Window) : Int32
end

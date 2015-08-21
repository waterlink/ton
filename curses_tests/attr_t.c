#include <curses.h>
#include <stdio.h>

#define pp(x, d) printf("% 15s = % 10lu_u32 # - %s\n", #x, x, #d);

int main() {
  pp(A_NORMAL,        Normal display (no highlight))
  pp(A_STANDOUT,      Best highlighting mode of the terminal.)
  pp(A_UNDERLINE,     Underlining)
  pp(A_REVERSE,       Reverse video)
  pp(A_BLINK,         Blinking)
  pp(A_DIM,           Half bright)
  pp(A_BOLD,          Extra bright or bold)
  pp(A_PROTECT,       Protected mode)
  pp(A_INVIS,         Invisible or blank mode)
  pp(A_ALTCHARSET,    Alternate character set)
  pp(A_ITALIC,        Italics (non-X/Open extension))
  pp(A_CHARTEXT,      Bit-mask to extract a character)

  return 0;
}

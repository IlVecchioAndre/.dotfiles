/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "nobody";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "#1c0810",   /* during input */
	[INPUT_ALT] = "black", /* during input, second color */
	[FAILED] = "#900000",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;
/* default message */
static const char * message = "                           !!! \n"
"\x1b[38;2;240;172;104m                /~~~~~~,         ~~~~~~\\ \n"
"                 \\     /vvvvvvvvv\\     /\x1b[38;2;255;255;255m       ------------ \n"
"\x1b[38;2;240;172;104m                  \\   /           \\   / \x1b[38;2;255;255;255m      | \x1b[38;2;255;0;0m PASSWORD! \x1b[38;2;255;255;255m| \n"
"\x1b[38;2;240;172;104m                   \\ /  ,,,   ,,,  \\ /   \x1b[38;2;255;255;255m      ------------ \n"
"\x1b[38;2;240;172;104m                     | \x1b[38;2;255;255;255m ~o~   ~o~ \x1b[38;2;240;172;104m | \x1b[38;2;255;255;255m            / \n"
"\x1b[38;2;240;172;104m                      |     |     |     \x1b[38;2;255;255;255m        / \n"
"\x1b[38;2;240;172;104m                       /    |    \\     \x1b[38;2;255;255;255m        / \n"
"\x1b[38;2;240;172;104m                    /  /    |    \\  \\ \x1b[38;2;255;255;255m        / \n"
"\x1b[38;2;240;172;104m                   /   /    |    \\   \\ \n"
"\x1b[38;2;240;172;104m                  /    /    !    \\    \\ \n"
"\x1b[38;2;240;172;104m                 /      v,,\\_/,,v      \\ \n"
"\x1b[38;2;240;172;104m                /         ~.!.~         \\ \n \x1b[38;2;255;255;255m "
"\x1b[38;2;240;172;104m                      /\x1b[38;2;255;0;0m.d####b.\x1b[38;2;240;172;104m\\ \n"
"                       \x1b[38;2;255;0;0m  '######' \n\x1b[38;2;255;255;255m"
"  sSSs   .S    sSSSSs  \x1b[38;2;255;0;0m   '####'   \x1b[38;2;255;255;255m   .S   .S_SSSs      sSSs   .S    S. \n"
" d%%SP  .SS   d%%%%SP  \x1b[38;2;255;0;0m    d##b    \x1b[38;2;255;255;255m  .SS  .SS~SSSSS    d%%SP  .SS    SS. \n"
"d%S'    S%S  d%S'      \x1b[38;2;255;0;0m    dYYb.   \x1b[38;2;255;255;255m   S%S  S%S   SSSS  d%S'    S%S    S&S \n"
"S%|     S%S  S%S       \x1b[38;2;255;0;0m   '####'   \x1b[38;2;255;255;255m   S%S  S%S    S%S  S%S     S%S    d*S \n"
"S&S     S&S  S&S       \x1b[38;2;255;0;0m   TYYYYT.  \x1b[38;2;255;255;255m   S&S  S%S SSSS%S  S&S     S&S   .S*S \n"
"Y&Ss    S&S  S&S       \x1b[38;2;255;0;0m  ./#####\\ \x1b[38;2;255;255;255m    S&S  S&S  SSS%S  S&S     S&S_sdSSS \n"
"`S&&S   S&S  S&S       \x1b[38;2;255;0;0m  dYYYYYYb  \x1b[38;2;255;255;255m   S&S  S&S    S&S  S&S     S&S~YSSY%b \n"
"  `S*S  S&S  S&S sSSs  \x1b[38;2;255;0;0m  ########  \x1b[38;2;255;255;255m   S&S  S&S    S&S  S&S     S&S    `S% \n"
"   l*S  S*S  S*b `S%%  \x1b[38;2;255;0;0m  \\YYYYYY/ \x1b[38;2;255;255;255m    d*S  S*S    S&S  S*b     S*S     S% \n"
"  .S*P  S*S  S*S   S%  \x1b[38;2;255;0;0m    ####    \x1b[38;2;255;255;255m  .S*S  S*S    S*S  S*S.    S*S     S& \n"
"sSS*S   S*S   SS_sSSS  \x1b[38;2;255;0;0m     \\/    \x1b[38;2;255;255;255m sdSSS   S*S    S*S   SSSbs  S*S     S& \n"
"YSS'    S*S    Y~YSSY  SSS         YSSY    SSS    S*S    YSSP  S*S     SS \n"
"        SP             YSY                        SP           SP \n"
"        Y                                         Y            Y \n";
/* text color */
static const char * text_color = "#ffffff";

/* text size (must be a valid size) */
static const char * font_name = "9x15";

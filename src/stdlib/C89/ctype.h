Page
Discussion
View
Edit
History
ads via Carbon
Get 50% off Slack Pro. Slack helps you stay organized, save time & get more done.
ADS VIA CARBON
Null-terminated byte strings
 C Strings library Null-terminated byte strings 
A null-terminated byte string (NTBS) is a sequence of nonzero bytes followed by a byte with value zero (the terminating null character). Each byte in a byte string encodes one character of some character set. For example, the character array {'\x63','\x61','\x74','\0'} is an NTBS holding the string "cat" in ASCII encoding.

Functions
Character classification
Defined in header <ctype.h>
isalnum
 
checks if a character is alphanumeric
(function)
isalpha
 
checks if a character is alphabetic
(function)
islower
 
checks if a character is lowercase
(function)
isupper
 
checks if a character is an uppercase character
(function)
isdigit
 
checks if a character is a digit
(function)
isxdigit
 
checks if a character is a hexadecimal character
(function)
iscntrl
 
checks if a character is a control character
(function)
isgraph
 
checks if a character is a graphical character
(function)
isspace
 
checks if a character is a space character
(function)
isblank
  
(C99)
 
checks if a character is a blank character
(function)
isprint
 
checks if a character is a printing character
(function)
ispunct
 
checks if a character is a punctuation character
(function)
Character manipulation
tolower
 
converts a character to lowercase
(function)
toupper
 
converts a character to uppercase
(function)
Note: additional functions whose names begin with either to or is, followed by a lowercase letter, may be added to the header ctype.h in future and should not be defined by programs that include that header.


ASCII values	characters	
iscntrl
iswcntrl

isprint
iswprint

isspace
iswspace

isblank
iswblank

isgraph
iswgraph

ispunct
iswpunct

isalnum
iswalnum

isalpha
iswalpha

isupper
iswupper

islower
iswlower

isdigit
iswdigit

isxdigit
iswxdigit

decimal	hexadecimal	octal
0–8	\x0–\x8	\0–\10	control codes (NUL, etc.)	≠0	0	0	0	0	0	0	0	0	0	0	0
9	\x9	\11	tab (\t)	≠0	0	≠0	≠0	0	0	0	0	0	0	0	0
10–13	\xA–\xD	\12–\15	whitespaces (\n, \v, \f, \r)	≠0	0	≠0	0	0	0	0	0	0	0	0	0
14–31	\xE–\x1F	\16–\37	control codes	≠0	0	0	0	0	0	0	0	0	0	0	0
32	\x20	\40	space	0	≠0	≠0	≠0	0	0	0	0	0	0	0	0
33–47	\x21–\x2F	\41–\57	!"#$%&'()*+,-./	0	≠0	0	0	≠0	≠0	0	0	0	0	0	0
48–57	\x30–\x39	\60–\71	0123456789	0	≠0	0	0	≠0	0	≠0	0	0	0	≠0	≠0
58–64	\x3A–\x40	\72–\100	:;<=>?@	0	≠0	0	0	≠0	≠0	0	0	0	0	0	0
65–70	\x41–\x46	\101–\106	ABCDEF	0	≠0	0	0	≠0	0	≠0	≠0	≠0	0	0	≠0
71–90	\x47–\x5A	\107–\132	GHIJKLMNOP
QRSTUVWXYZ	0	≠0	0	0	≠0	0	≠0	≠0	≠0	0	0	0
91–96	\x5B–\x60	\133–\140	[\]^_`	0	≠0	0	0	≠0	≠0	0	0	0	0	0	0
97–102	\x61–\x66	\141–\146	abcdef	0	≠0	0	0	≠0	0	≠0	≠0	0	≠0	0	≠0
103–122	\x67–\x7A	\147–\172	ghijklmnop
qrstuvwxyz	0	≠0	0	0	≠0	0	≠0	≠0	0	≠0	0	0
123–126	\x7B–\x7E	\172–\176	{|}~	0	≠0	0	0	≠0	≠0	0	0	0	0	0	0
127	\x7F	\177	backspace character (DEL)	≠0	0	0	0	0	0	0	0	0	0	0	0
Conversions to and from numeric formats
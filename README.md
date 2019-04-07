# Sequel - PostScript in S-expression

## Installation

Locate this repository in your ASDF search path. Or if you use [Roswell](https://github.com/roswell/roswell), type `ros install t-sin/sequel`.

## Usage

```lisp
CL-USER> (sequel:generate '((:comment "Push current graphics state") gsave
                            (:comment "main proc")
                            100 100 moveto 200 200 lineto stroke showpage
                            (:comment "string output")
                            "string (aaaa" :test 
                            (:comment "Pop graphics state") grestore))
%!

% Push current graphics state
gsave 
% main proc
100 100 moveto 200 200 lineto stroke showpage 
% string output
(string \(aaaa) /test 
% Pop graphics state
grestore
NIL
```

## Author

- TANAKA Shinichi <shinichi.tanaka45@gmail.com>

## License

TBD

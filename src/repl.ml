open AbsResolution
open PrintResolution
open Printf
open BNFC_Util
open Lexing
open Desugar.Desugar
open Sys
open Naive.Naive
open Resolution.Resolution
open Core_kernel.Std
open Core_kernel.Core_list

let foo = [1] >>= (fun x -> [x + 1])

let printf = Core_kernel.Core_printf.printf;;

let (color_reset, color_red, color_green, color_pink, color_bright) =
  ("\x1b[0m",
   "\x1b[1m\x1b[31m",
   "\x1b[1m\x1b[32m",
   "\x1B[35m",
   "\x1b[1m\x1b[37m");;
let red s =  color_red ^ s ^ color_reset;;
let green s =  color_green ^ s ^ color_reset;;
let pink s = color_pink ^ s ^ color_reset;;

let error_msg (x : Lexing.position) (y : Lexing.position) : string =
  (red "Syntax error") ^ " at line " ^ (string_of_int x.pos_lnum) ^ ".\n"


let parse_line s = ParResolution.pFormExp LexResolution.token (from_string s)

let quit_repl () : unit = printf "\nTake care!\n"; exit 0

let print_error_description x =
  (printf "\n%s (in the definition of %s):\n    " (red "Type Error")) x

let repl () =
  printf "%s" "\n           Welcome to Resolution v0.0.0           \n\n";
  while true do
    printf "- ";
    let input = Pervasives.read_line () in
    if String.equal input "quit"
    then quit_repl ()
    else
      let refuted = parse_line input |> desugar |> transform |> resolve in
      if refuted then printf "Refuted!\n" else printf "Could not refute\n"
  done

let main =
  set_signal sigint (Signal_handle (fun _ -> quit_repl ()));
  repl ()
;;

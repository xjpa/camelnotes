open Notemanager
open Storage

let print_note note =
  Printf.printf "ID: %d\nTitle: %s\nContent: %s\n\n" note.id note.title note.content

let () =
  let filename = "camelnotes.db" in
  
  let loaded_notes = Storage.load_notes_from_file filename in
  
  begin match loaded_notes with
  | Some notes_list -> Notemanager.notes := notes_list
  | None -> ()
  end;

  let args = Array.to_list Sys.argv in
  match args with
  | [] -> print_endline "No arguments provided. Available commands: create, find, delete."
  | _ :: "create" :: title :: content :: [] -> 
      let note = Notemanager.create_note ~title ~content in
      print_note note
  | _ :: "find" :: id_str :: [] ->
      let id = int_of_string id_str in
      (match Notemanager.find_note_by_id id with
      | Some note -> print_note note
      | None -> print_endline "Note not found.")
  | _ :: "delete" :: id_str :: [] ->
      let id = int_of_string id_str in
      Notemanager.delete_note_by_id id;
      print_endline "Note deleted."
  | _ :: _ ->
      print_endline "Unknown command. These are the available commands: create, find, delete.";

  Storage.save_notes_to_file filename !Notemanager.notes

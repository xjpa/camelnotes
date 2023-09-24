let read_from_file filename =
  let ic = open_in filename in
  let size = in_channel_length ic in
  let content = really_input_string ic size in
  close_in ic;
  content

let write_to_file filename content =
  let oc = open_out filename in
  output_string oc content;
  close_out oc

let save_notes_to_file filename notes =
  let content = Marshal.to_string notes [] in
  write_to_file filename content

let load_notes_from_file filename =
  try 
    let content = read_from_file filename in
    Some (Marshal.from_string content 0)
  with
  | Sys_error _ -> None
  | _ -> None

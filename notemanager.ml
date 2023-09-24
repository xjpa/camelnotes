type note = {
  id: int;
  title: string;
  content: string;
}

let notes = ref []

let create_note ~title ~content =
  let next_id = (List.length !notes) + 1 in
  let note = { id = next_id; title; content } in
  notes := note :: !notes;
  note

let find_note_by_id id = 
  List.find_opt (fun note -> note.id = id) !notes

let delete_note_by_id id =
  notes := List.filter (fun note -> note.id <> id) !notes

let update_note_by_id id ~title ~content =
  let note = find_note_by_id id in
  match note with
  | Some n -> 
      let updated_note = { n with title; content } in
      notes := updated_note :: (List.filter (fun note -> note.id <> id) !notes);
      Some updated_note
  | None -> None

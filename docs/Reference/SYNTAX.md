# Syntax

### #

```code
(# (< %9 %0 %3) ...) -> (lambda (%0 %3 %9) (< %9 %0 %3) ...)
```

### %

```code
(% num num ...)
```

### *

```code
(* num num ...)
```

### +

```code
(+ num num ...)
```

### -

```code
(- num num ...)
```

### backdrop :draw

```code
(. backdrop :draw) -> backdrop
```

### buffer :backspace

```code
(. buffer :backspace &optional num) -> buffer
```

### buffer :break

```code
(. buffer :break) -> buffer
```

### buffer :clear_undo

```code
(. buffer :clear_undo) -> buffer
```

### buffer :colorise

```code
(. buffer :colorise) -> buffer
```

### buffer :constrain

```code
(. buffer :constrain x y) -> (x y)
```

### buffer :copy

```code
(. buffer :copy anchor_x anchor_y) -> string
```

### buffer :cut

```code
(. buffer :cut anchor_x anchor_y) -> string
```

### buffer :delete

```code
(. buffer :delete &optional num) -> buffer
```

### buffer :down

```code
(. buffer :down) -> buffer
```

### buffer :file_load

```code
(. buffer :file_load filepath) -> buffer
```

### buffer :file_save

```code
(. buffer :file_save filepath) -> buffer
```

### buffer :find

```code
(. buffer :find pattern) -> buffer_index
```

### buffer :get_cursor

```code
(. buffer :get_cursor) -> (x y)
```

### buffer :get_modified

```code
(. buffer :get_modified) -> :t | :nil
```

### buffer :get_size

```code
(. buffer :get_size) -> (width height)
```

### buffer :get_syntax

```code
(. buffer :get_syntax) -> syntax
```

### buffer :get_tab_width

```code
(. buffer :get_tab_width) -> tab_width
```

### buffer :get_text_line

```code
(. buffer :get_text_line y) -> line
```

### buffer :get_text_lines

```code
(. buffer :get_text_lines) -> lines
```

### buffer :get_wrap_width

```code
(. buffer :get_wrap_width) -> wrap_width
```

### buffer :insert

```code
(. buffer :insert string) -> buffer
```

### buffer :left

```code
(. buffer :left) -> buffer
```

### buffer :left_bracket

```code
(. buffer :left_bracket) -> (x y) | (:nil :nil)
```

### buffer :next_mark

```code
(. buffer :next_mark) -> mark
```

### buffer :paste

```code
(. buffer :paste string) -> buffer
```

### buffer :push_undo

```code
(. buffer :push_undo record ...) -> buffer
```

### buffer :redo

```code
(. buffer :redo) -> buffer
```

### buffer :right

```code
(. buffer :right) -> buffer
```

### buffer :right_bracket

```code
(. buffer :right_bracket) -> (x y) | (:nil :nil)
```

### buffer :set_cursor

```code
(. buffer :set_cursor x y) -> buffer
```

### buffer :set_mode

```code
(. buffer :set_mode mode) -> buffer
```

### buffer :undo

```code
(. buffer :undo) -> buffer
```

### buffer :up

```code
(. buffer :up) -> buffer
```

### buffer :vdu_load

```code
(. buffer :vdu_load vdu scroll_x scroll_y) -> buffer
```

### button :draw

```code
(. button :draw) -> button
```

### button :layout

```code
(. button :layout) -> button
```

### button :mouse_down

```code
(. button :mouse_down event) -> button
```

### button :mouse_enter

```code
(. button :mouse_enter event) -> button
```

### button :mouse_exit

```code
(. button :mouse_exit event) -> button
```

### button :mouse_move

```code
(. button :mouse_move event) -> button
```

### button :mouse_up

```code
(. button :mouse_up event) -> button
```

### button :show_tip

```code
(. button :show_tip) -> button
```

### canvas :draw

```code
(. canvas :draw) -> canvas
```

### canvas :fbox

```code
(. canvas :fbox x y width height) -> canvas
```

### canvas :fill

```code
(. canvas :fill argb) -> canvas
```

### canvas :fpoly

```code
(. canvas :fpoly x y winding_mode paths) -> canvas
```

### canvas :ftri

```code
(. canvas :ftri tri) -> canvas
```

### canvas :get_clip

```code
(. canvas :get_clip) -> (cx cy cx1 cy1)
```

### canvas :get_color

```code
(. canvas :get_color) -> argb
```

### canvas :next_frame

```code
(. canvas :next_frame) -> canvas
```

### canvas :plot

```code
(. canvas :plot x y) -> canvas
```

### canvas :pref_size

```code
(. canvas :pref_size) -> (width height)
```

### canvas :resize

```code
(. canvas :resize canvas) -> canvas
```

### canvas :save

```code
(. canvas :save file format) -> :nil | canvas
```

### canvas :set_canvas_flags

```code
(. canvas :set_canvas_flags flags) -> canvas
```

### canvas :set_color

```code
(. canvas :set_color argb) -> canvas
```

### canvas :swap

```code
(. canvas :swap flags) -> canvas
```

### dictionary :find_matches

```code
(. dictionary :find_matches prefix) -> (word ...)
```

### dictionary :find_matches_case

```code
(. dictionary :find_matches_case prefix) -> (word ...)
```

### dictionary :insert_word

```code
(. dictionary :insert_word word) -> dictionary
```

### dictionary :sort

```code
(. dictionary :sort) -> dictionary
```

### edit :backspace

```code
(. edit :backspace) -> edit
```

### edit :break

```code
(. edit :break) -> edit
```

### edit :char_pos

```code
(. edit :char_pos event) -> (list x y)
```

### edit :clear_selection

```code
(. edit :clear_selection) -> edit
```

### edit :comment

```code
(. edit :comment) -> edit
```

### edit :delete

```code
(. edit :delete) -> edit
```

### edit :down

```code
(. edit :down) -> edit
```

### edit :down_select

```code
(. edit :down_select) -> edit
```

### edit :end

```code
(. edit :end) -> edit
```

### edit :end_select

```code
(. edit :end_select) -> edit
```

### edit :get_anchor

```code
(. edit :get_anchor) -> (list x y)
```

### edit :get_buffer

```code
(. edit :get_buffer) -> text_buffer
```

### edit :get_cursor

```code
(. edit :get_cursor) -> (list x y)
```

### edit :get_scroll

```code
(. edit :get_scroll) -> (list x y)
```

### edit :get_vdu_text

```code
(. edit :get_vdu_text) -> vdu_text
```

### edit :get_vdu_underlay

```code
(. edit :get_vdu_underlay) -> vdu_underlay
```

### edit :home

```code
(. edit :home) -> edit
```

### edit :home_select

```code
(. edit :home_select) -> edit
```

### edit :insert

```code
(. edit :insert string) -> edit
```

### edit :layout

```code
(. edit :layout) -> edit
```

### edit :left

```code
(. edit :left) -> edit
```

### edit :left_bracket

```code
(. edit :left_bracket) -> edit
```

### edit :left_select

```code
(. edit :left_select) -> edit
```

### edit :left_tab

```code
(. edit :left_tab) -> edit
```

### edit :max_size

```code
(. edit :max_size) -> (width height)
```

### edit :mouse_down

```code
(. edit :mouse_down event) -> edit
```

### edit :mouse_move

```code
(. edit :mouse_move event) -> edit
```

### edit :mouse_wheel

```code
(. edit :mouse_wheel event) -> edit
```

### edit :ordered

```code
(. edit :ordered) -> edit
```

### edit :ordered_unique

```code
(. edit :ordered_unique) -> edit
```

### edit :pref_size

```code
(. edit :pref_size) -> (width height)
```

### edit :reflow

```code
(. edit :reflow) -> edit
```

### edit :right

```code
(. edit :right) -> edit
```

### edit :right_bracket

```code
(. edit :right_bracket) -> edit
```

### edit :right_select

```code
(. edit :right_select) -> edit
```

### edit :right_tab

```code
(. edit :right_tab) -> edit
```

### edit :select_all

```code
(. edit :select_all) -> edit
```

### edit :select_block

```code
(. edit :select_block) -> edit
```

### edit :select_line

```code
(. edit :select_line) -> edit
```

### edit :select_paragraph

```code
(. edit :select_paragraph) -> edit
```

### edit :select_word

```code
(. edit :select_word) -> edit
```

### edit :set_anchor

```code
(. edit :set_anchor x y) -> this
```

### edit :set_buffer

```code
(. edit :set_buffer text_buffer) -> this
```

### edit :set_cursor

```code
(. edit :set_cursor x y) -> this
```

### edit :set_scroll

```code
(. edit :set_scroll x y) -> this
```

### edit :set_underlay_color

```code
(. edit :set_underlay_color argb) -> edit
```

### edit :tab

```code
(. edit :tab) -> edit
```

### edit :to_lower

```code
(. edit :to_lower) -> edit
```

### edit :to_upper

```code
(. edit :to_upper) -> edit
```

### edit :underlay_brackets

```code
(. edit :underlay_brackets) -> edit
```

### edit :underlay_clear

```code
(. edit :underlay_clear) -> edit
```

### edit :underlay_selection

```code
(. edit :underlay_selection) -> edit
```

### edit :up

```code
(. edit :up) -> edit
```

### edit :up_select

```code
(. edit :up_select) -> edit
```

### emap :copy

```code
(. emap :copy) -> emap
```

### emap :deep_copy

```code
(. emap :deep_copy) -> emap
```

### emap :each

```code
(. emap :each lambda)
```

### emap :empty

```code
(. emap :empty) -> emap
```

### emap :erase

```code
(. emap :erase key) -> emap
```

### emap :find

```code
(. emap :find key) -> :nil | val
```

### emap :insert

```code
(. emap :insert key val) -> emap
```

### emap :move

```code
(. emap :move) -> emap
```

### emap :resize

```code
(. emap :resize num_buckets) -> emap
```

### env sym

```code
(. env sym [...])
```

### farm :close

```code
(. farm :close)
```

### farm :refresh

```code
(. farm :refresh [timeout]) -> :t | :nil
```

### farm :restart

```code
(. farm :restart key val)
```

### flow :layout

```code
(. flow :layout) -> flow
```

### flow :pref_size

```code
(. flow :pref_size) -> (width height)
```

### fmap :copy

```code
(. fmap :copy) -> fmap
```

### fmap :deep_copy

```code
(. fmap :deep_copy) -> fmap
```

### fmap :each

```code
(. fmap :each lambda)
```

### fmap :empty

```code
(. fmap :empty) -> fmap
```

### fmap :empty?

```code
(. fmap :empty?) -> :t | :nil
```

### fmap :erase

```code
(. fmap :erase key) -> fmap
```

### fmap :find

```code
(. fmap :find key) -> :nil | val
```

### fmap :insert

```code
(. fmap :insert key val) -> fmap
```

### fmap :move

```code
(. fmap :move) -> fmap
```

### fmap :resize

```code
(. fmap :resize num_buckets) -> fmap
```

### fset :copy

```code
(. fset :copy) -> fset
```

### fset :deep_copy

```code
(. fset :deep_copy) -> fset
```

### fset :difference

```code
(. fset :difference fset) -> fset
```

### fset :each

```code
(. fset :each lambda)
```

### fset :empty

```code
(. fset :empty) -> fset
```

### fset :empty?

```code
(. fset :empty?) -> :t | :nil
```

### fset :erase

```code
(. fset :erase key) -> fset
```

### fset :find

```code
(. fset :find key) -> :nil | key
```

### fset :insert

```code
(. fset :insert key) -> fset
```

### fset :intersect

```code
(. fset :intersect fset) -> fset
```

### fset :move

```code
(. fset :move) -> fset
```

### fset :not_intersect

```code
(. fset :not_intersect fset) -> fset
```

### fset :resize

```code
(. fset :resize num_buckets) -> fset
```

### fset :union

```code
(. fset :union fset) -> fset
```

### global :close

```code
(. global :close)
```

### global :refresh

```code
(. global :refresh [timeout]) -> :t | :nil
```

### global :size

```code
(. global :size) -> size
```

### grid :layout

```code
(. grid :layout) -> grid
```

### grid :pref_size

```code
(. grid :pref_size) -> (width height)
```

### hchart :add_bar

```code
(. hchart :add_bar) -> progress
```

### hchart :layout_bars

```code
(. hchart :layout_bars) -> hchart
```

### hchart :update_scale

```code
(. hchart :update_scale) -> hchart
```

### iso :get_gridcell

```code
(. iso :get_gridcell x y z) -> gridcell
```

### iso :get_metrics

```code
(. iso :get_metrics) -> (width height depth)
```

### iso :get_scalar

```code
(. iso :get_scalar x y z) -> scalar
```

### iso :get_surface

```code
(. iso :get_surface x y z isolevel) -> triangles
```

### label :add_child

```code
(. label :add_child child) -> label
```

### label :draw

```code
(. label :draw) -> label
```

### label :layout

```code
(. label :layout) -> label
```

### label :pref_size

```code
(. label :pref_size) -> (width height)
```

### lmap :copy

```code
(. lmap :copy) -> lmap
```

### lmap :deep_copy

```code
(. lmap :deep_copy) -> lmap
```

### lmap :each

```code
(. lmap :each lambda)
```

### lmap :empty

```code
(. lmap :empty) -> lmap
```

### lmap :empty?

```code
(. lmap :empty?) -> :t | :nil
```

### lmap :erase

```code
(. lmap :erase key) -> lmap
```

### lmap :find

```code
(. lmap :find key) -> :nil | val
```

### lmap :insert

```code
(. lmap :insert key val) -> lmap
```

### lmap :move

```code
(. lmap :move) -> lmap
```

### lmap :resize

```code
(. lmap :resize num_buckets) -> lmap
```

### local :add_node

```code
(. local :add_node node)
```

### local :close

```code
(. local :close)
```

### local :refresh

```code
(. local :refresh [timeout]) -> :t | :nil
```

### local :restart

```code
(. local :restart key val)
```

### mesh :normals

```code
(. mesh :normals) -> this
```

### mesh :optimise

```code
(. mesh :optimise) -> this
```

### pipe :close

```code
(. pipe :close) -> pipe
```

### pipe :poll

```code
(. pipe :poll) -> :nil | :t
```

### pipe :read

```code
(. pipe :read) -> :nil | :t | data
```

### pipe :write

```code
(. pipe :write string) -> pipe
```

### progress :draw

```code
(. progress :draw) -> progress
```

### progress :pref_size

```code
(. progress :pref_size) -> (width height)
```

### regexp :compile

```code
(. regexp :compile pattern) -> :nil | meta
```

### regexp :match?

```code
(. regexp :match? text pattern &optional meta) -> :t | :nil
```

### regexp :search

```code
(. regexp :search text pattern &optional meta) -> indexes
```

### scene_node :add_node

```code
(. scene_node :add_node child) -> scene_node
```

### scene_node :children

```code
(. scene_node :children) -> children
```

### scene_node :find_nodes

```code
(. scene_node :find_nodes name) -> nodes
```

### scene_node :get_color

```code
(. scene_node :get_color) -> color
```

### scene_node :get_matrix

```code
(. scene_node :get_matrix) -> matrix
```

### scene_node :get_mesh

```code
(. scene_node :get_mesh) -> mesh
```

### scene_node :get_norms

```code
(. scene_node :get_norms) -> norms
```

### scene_node :get_parent

```code
(. scene_node :get_parent) -> scene_node | :nil
```

### scene_node :get_tris

```code
(. scene_node :get_tris) -> tris
```

### scene_node :get_verts

```code
(. scene_node :get_verts) -> verts
```

### scene_node :render

```code
(. scene_node :render canvas size left right top bottom near far) -> scene_node
```

### scene_node :set_mesh

```code
(. scene_node :set_mesh mesh) -> scene_node
```

### scene_node :set_parent

```code
(. scene_node :set_parent parent) -> scene_node
```

### scene_node :set_rotation

```code
(. scene_node :set_rotation x y z) -> scene_node
```

### scene_node :set_scale

```code
(. scene_node :set_scale x y z) -> scene_node
```

### scene_node :set_translation

```code
(. scene_node :set_translation x y z) -> scene_node
```

### scene_node :sub_node

```code
(. scene_node :sub_node) -> scene_node
```

### scene_node :walk_nodes

```code
(. scene_node :walk_nodes fnc_in fnc_out) -> scene_node
```

### scroll :action

```code
(. scroll :action data) -> scroll
```

### scroll :add_child

```code
(. scroll :add_child child) -> scroll
```

### scroll :layout

```code
(. scroll :layout) -> scroll
```

### scroll :mouse_wheel

```code
(. scroll :mouse_wheel event) -> scroll
```

### scroll :pref_size

```code
(. scroll :pref_size) -> (width height)
```

### slider :draw

```code
(. slider :draw) -> slider
```

### slider :mouse_down

```code
(. slider :mouse_down event) -> slider
```

### slider :mouse_move

```code
(. slider :mouse_move event) -> slider
```

### slider :mouse_up

```code
(. slider :mouse_up event) -> slider
```

### slider :pref_size

```code
(. slider :pref_size) -> (width height)
```

### spinner :action

```code
(. spinner :action event) -> spinner
```

### spinner :layout

```code
(. spinner :layout) -> spinner
```

### substr :compile

```code
(. substr :compile pattern) -> :nil | meta
```

### substr :search

```code
(. substr :search text pattern &optional meta) -> indexes
```

### syntax :colorise

```code
(. syntax :colorise str) -> array
```

### syntax :compress_tabs

```code
(. syntax :compress_tabs string tab_width) -> string
```

### syntax :set_colors

```code
(. syntax :set_colors fmap) -> syntax
```

### syntax :text_flow

```code
(. syntax :text_flow words line_width) -> lines
```

### text :draw

```code
(. text :draw) -> text
```

### text :pref_size

```code
(. text :pref_size) -> (width height)
```

### textfield :draw

```code
(. textfield :draw) -> textfield
```

### textfield :key_down

```code
(. textfield :key_down event) -> textfield
```

### textfield :layout

```code
(. textfield :layout) -> textfield
```

### textfield :mouse_down

```code
(. textfield :mouse_down event) -> textfield
```

### textfield :mouse_move

```code
(. textfield :mouse_move event) -> textfield
```

### textfield :mouse_up

```code
(. textfield :mouse_up event) -> textfield
```

### .

```code
(. this :method [arg ...])
```

### title :mouse_down

```code
(. title :mouse_down event) -> title
```

### title :mouse_move

```code
(. title :mouse_move event) -> title
```

### tree :action

```code
(. tree :action event) -> tree
```

### tree :add_route

```code
(. tree :add_route route) -> tree
```

### tree :find_node

```code
(. tree :find_node route) -> node | :nil
```

### tree :get_route

```code
(. tree :get_route node) -> tree
```

### tree :populate

```code
(. tree :populate &optional root exts n) -> tree
```

### tree :select

```code
(. tree :select route) -> tree
```

### vdu :char_size

```code
(. vdu :char_size) -> (width height)
```

### vdu :layout

```code
(. vdu :layout) -> this
```

### vdu :load

```code
(. vdu :load lines offset_x offset_y cursor_x cursor_y) -> vdu
```

### vdu :max_size

```code
(. vdu :max_size) -> (width height)
```

### vdu :pref_size

```code
(. vdu :pref_size) -> (width height)
```

### vdu :vdu_size

```code
(. vdu :vdu_size) -> (width height)
```

### view :add_back

```code
(. view :add_back child) -> view
```

### view :add_child

```code
(. view :add_child child) -> view
```

### view :add_dirty

```code
(. view :add_dirty x y width height) -> view
```

### view :add_front

```code
(. view :add_front child) -> view
```

### view :add_opaque

```code
(. view :add_opaque x y width height) -> view
```

### view :change

```code
(. view :change x y width height [flag]) -> view
```

### view :change_dirty

```code
(. view :change_dirty x y width height) -> view
```

### view :children

```code
(. view :children) -> (child0 child1 ...)
```

### view :clr_opaque

```code
(. view :clr_opaque) -> view
```

### view :connect

```code
(. view :connect id) -> view
```

### view :ctx_blit

```code
(. view :ctx_blit tid col x y width height) -> view
```

### view :ctx_box

```code
(. view :ctx_box x y width height) -> view
```

### view :ctx_filled_box

```code
(. view :ctx_filled_box x y width height) -> view
```

### view :ctx_panel

```code
(. view :ctx_panel col flags depth x y width height) -> view
```

### view :ctx_set_color

```code
(. view :ctx_set_color col) -> view
```

### view :dirty

```code
(. view :dirty) -> view
```

### view :dirty_all

```code
(. view :dirty_all) -> view
```

### view :emit

```code
(. view :emit) -> view
```

### view :find_id

```code
(. view :find_id target_id) -> :nil | target_view
```

### view :find_owner

```code
(. view :find_owner) -> :nil | netid
```

### view :get_bounds

```code
(. view :get_bounds) -> (x y width height)
```

### view :get_flags

```code
(. view :get_flags) -> flags
```

### view :get_id

```code
(. view :get_id) -> id
```

### view :get_pos

```code
(. view :get_pos) -> (x y)
```

### view :get_size

```code
(. view :get_size) -> (width height)
```

### view :hide

```code
(. view :hide) -> view
```

### view :hit_tree

```code
(. view :hit_tree x y) -> (hit_view | :nil rx ry)
```

### view :layout

```code
(. view :layout) -> view
```

### view :lisp_sub

```code
(. view :lisp_sub) -> view
```

### view :pref_size

```code
(. view :pref_size) -> (width height)
```

### view :set_flags

```code
(. view :set_flags value mask) -> view
```

### view :set_size

```code
(. view :set_size width height) -> view
```

### view :set_size

```code
(. view :set_size x y width height) -> view
```

### view :sub_opaque

```code
(. view :sub_opaque x y width height) -> view
```

### view :to_back

```code
(. view :to_back) -> view
```

### view :to_front

```code
(. view :to_front) -> view
```

### view :trans_dirty

```code
(. view :trans_dirty rx ry) -> view
```

### window :add_child

```code
(. window :add_child child) -> window
```

### window :drag_mode

```code
(. window :drag_mode rx ry) -> (drag_mode drag_offx drag_offy)
```

### window :draw

```code
(. window :draw) -> window
```

### window :event

```code
(. window :event event) -> window
```

### window :layout

```code
(. window :layout) -> window
```

### window :mouse_down

```code
(. window :mouse_down event) -> window
```

### window :mouse_move

```code
(. window :mouse_move event) -> window
```

### window :pref_size

```code
(. window :pref_size) -> (width height)
```

### xmap :copy

```code
(. xmap :copy) -> xmap
```

### xmap :deep_copy

```code
(. xmap :deep_copy) -> xmap
```

### xmap :each

```code
(. xmap :each lambda)
```

### xmap :empty

```code
(. xmap :empty) -> xmap
```

### xmap :empty?

```code
(. xmap :empty?) -> :t | :nil
```

### xmap :erase

```code
(. xmap :erase key) -> xmap
```

### xmap :find

```code
(. xmap :find key) -> :nil | val
```

### xmap :insert

```code
(. xmap :insert key val) -> xmap
```

### xmap :move

```code
(. xmap :move) -> xmap
```

### xmap :resize

```code
(. xmap :resize num_buckets) -> xmap
```

### xset :copy

```code
(. xset :copy) -> xset
```

### xset :deep_copy

```code
(. xset :deep_copy) -> xset
```

### xset :difference

```code
(. xset :difference xset) -> xset
```

### xset :each

```code
(. xset :each lambda)
```

### xset :empty

```code
(. xset :empty) -> xset
```

### xset :empty?

```code
(. xset :empty?) -> :t | :nil
```

### xset :erase

```code
(. xset :erase key) -> xset
```

### xset :find

```code
(. xset :find key) -> :nil | key
```

### xset :insert

```code
(. xset :insert key) -> xset
```

### xset :intersect

```code
(. xset :intersect xset) -> xset
```

### xset :move

```code
(. xset :move) -> xset
```

### xset :not_intersect

```code
(. xset :not_intersect xset) -> xset
```

### xset :resize

```code
(. xset :resize num_buckets) -> xset
```

### xset :union

```code
(. xset :union xset) -> xset
```

### .->

```code
(.-> this form ...)
```

### .?

```code
(.? this method) -> :nil | lambda
```

### .super

```code
(.super this :method [arg ...])
```

### /

```code
(/ num num ...)
```

### /=

```code
(/= num num ...)
```

### <

```code
(< num num ...)
```

### <<

```code
(<< num cnt)
```

### <=

```code
(<= num num ...)
```

### =

```code
(= num num ...)
```

### >

```code
(> num num ...)
```

### >=

```code
(>= num num ...)
```

### >>

```code
(>> num cnt)
```

### >>>

```code
(>>> num cnt)
```

### Backdrop

```code
(Backdrop) -> backdrop
```

### Buffer

```code
(Buffer [mode syntax]) -> buffer
```

### Button

```code
(Button) -> button
```

### Canvas

```code
(Canvas width height scale) -> canvas
```

### Canvas-from-file

```code
(Canvas-from-file file flags) -> :nil | canvas
```

### Canvas-from-pixmap

```code
(Canvas-from-pixmap pixmap) -> canvas
```

### Dictionary

```code
(Dictionary [num_buckets]) -> dictionary
```

### Farm

```code
(Farm fnc_create fnc_destroy size) -> farm
```

### Flow

```code
(Flow) -> flow
```

### Global

```code
(Global fnc_create fnc_destroy) -> global
```

### Grid

```code
(Grid) -> grid
```

### Hchart

```code
(Hchart title num_marks) -> hchart
```

### Iso

```code
(Iso) -> iso
```

### Iso-capsule

```code
(Iso-capsule width height depth) -> iso
```

### Iso-cube

```code
(Iso-cube width height depth) -> iso
```

### Iso-sphere

```code
(Iso-sphere width height depth) -> iso
```

### Iso-tetra

```code
(Iso-tetra width height depth) -> iso
```

### Label

```code
(Label) -> label
```

### Local

```code
(Local fnc_create fnc_destroy &optional max_size init_size size) -> local
```

### Mesh

```code
(Mesh) -> mesh
```

### Mesh-data

```code
(Mesh-data num_verts num_norms num_tris data) -> mesh
```

### Mesh-iso

```code
(Mesh-iso iso isolevel) -> mesh
```

### Mesh-sphere

```code
(Mesh-sphere radius eps) -> mesh
```

### Mesh-torus

```code
(Mesh-torus radius_ring radius_body eps) -> mesh
```

### Pipe

```code
(Pipe cmds &optional user_select) -> pipe | :nil
```

### Progress

```code
(Progress) -> progress
```

### Regexp

```code
(Regexp) -> regexp
```

### SVG-Canvas

```code
(SVG-Canvas stream [scale]) -> :nil | canvas
```

### SVG-info

```code
(SVG-info stream) -> (width height type) | (-1 -1 -1)
```

### Scene

```code
(Scene &optional name) -> scene_node
```

### Scene-node

```code
(Scene-node &optional name) -> scene_node
```

### Scene-object

```code
(Scene-object mesh color &optional name) -> scene_node
```

### Scroll

```code
(Scroll flags) -> scroll
```

### Slider

```code
(Slider) -> slider
```

### Spinner

```code
(Spinner) -> spinner
```

### Substr

```code
(Substr) -> substr
```

### Syntax

```code
(Syntax) -> syntax
```

### Text

```code
(Text) -> text
```

### Textfield

```code
(Textfield) -> textfield
```

### Title

```code
(Title) -> title
```

### Tree

```code
(Tree event) -> tree
```

### Vdu

```code
(Vdu) -> vdu
```

### View

```code
(View) -> view
```

### Window

```code
(Window) -> window
```

### XML-parse

```code
(XML-parse stream fnc_in fnc_out fnc_text)
```

### aand

```code
(aand [form] ...)
```

### abi

```code
(abi) -> sym
```

### abs

```code
(abs num)
```

### abs-path

```code
(abs-path path [current]) -> path
```

### acond

```code
(acond (tst body) ...)
```

### aeach

```code
(aeach seq body)
```

### age

```code
(age path) -> 0 | time ns
```

### aif

```code
(aif form form [form])
```

### align

```code
(align num div) -> num
```

### all-dirs

```code
(all-dirs paths) -> paths
```

### all-files

```code
(all-files &optional root exts n) -> paths
```

### alloc-select

```code
(alloc-select size) -> (list (task-netid) [temp_mbox] ...)
```

### and

```code
(and [tst] ...) -> :t | :nil | tst
```

### apply

```code
(apply lambda list)
```

### array

```code
(array [num ...])
```

### array?

```code
(array? form) -> :t | :nil
```

### ascii-char

```code
(ascii-char num) -> char
```

### ascii-code

```code
(ascii-code char) -> num
```

### ascii-lower

```code
(ascii-lower num) -> num
```

### ascii-upper

```code
(ascii-upper num) -> num
```

### asome

```code
(asome seq body)
```

### awhen

```code
(awhen form body)
```

### awhile

```code
(awhile form body)
```

### bind

```code
(bind (param ...) seq)
```

### bits

```code
(bits name base [(bit field ...)] ...)
```

### bounding-box

```code
(bounding-box verts vec3-extract-fnc) -> (min_v3 max_v3)
```

### bounding-sphere

```code
(bounding-sphere verts vec3-extract-fnc) -> (center_v3 radius)
```

### byte-to-hex-str

```code
(byte-to-hex-str num) -> str
```

### canvas-brighter

```code
(canvas-brighter col) -> col
```

### canvas-darker

```code
(canvas-darker col) -> col
```

### canvas-fbox

```code
(canvas-fbox canvas x y w h)
```

### canvas-fill

```code
(canvas-fill canvas argb)
```

### canvas-flush

```code
(canvas-flush)
```

### canvas-fpoly

```code
(canvas-fpoly canvas x y mode list)
```

### canvas-from-argb32

```code
(canvas-from-argb32 pixel type)
```

### canvas-ftri

```code
(canvas-ftri canvas path)
```

### canvas-next-frame

```code
(canvas-next-frame canvas)
```

### canvas-plot

```code
(canvas-plot canvas x y)
```

### canvas-resize

```code
(canvas-resize canvas canvas)
```

### canvas-swap

```code
(canvas-swap canvas flags)
```

### canvas-to-argb32

```code
(canvas-to-argb32 pixel type)
```

### cap

```code
(cap len array ...)
```

### case

```code
(case form [(key|(key ...) body)] ...)
```

### cat

```code
(cat seq ...)
```

### catch

```code
(catch form eform)
```

### char

```code
(char num [width])
```

### char-to-num

```code
(char-to-num char) -> num
```

### clear

```code
(clear array ...)
```

### cmp

```code
(cmp str str)
```

### code

```code
(code str [width index])
```

### compose

```code
(compose lambda lambda) -> lambda
```

### cond

```code
(cond [(tst [body])] ...)
```

### const

```code
(const form)
```

### copy

```code
(copy form)
```

### cos

```code
(cos angle)
```

### cpp_node?

```code
(cpp_node? node) -> :t | :nil
```

### cpu

```code
(cpu) -> sym
```

### create

```code
(create key val nodes)
```

### create-canvas

```code
(create-canvas width height scale)
```

### create-canvas-pixmap

```code
(create-canvas-pixmap pixmap)
```

### create-font

```code
(create-font name pixels)
```

### create-stdio

```code
(create-stdio)
```

### create-vdu

```code
(create-vdu)
```

### create-view

```code
(create-view)
```

### ctx-blit

```code
(ctx-blit view tid col x y w h)
```

### ctx-box

```code
(ctx-box view x y w h)
```

### ctx-filled-box

```code
(ctx-filled-box view x y w h)
```

### ctx-set-color

```code
(ctx-set-color view col)
```

### curry

```code
(curry lambda var ...) -> lambda
```

### debug

```code
(debug name form)
```

### debug-format

```code
(debug-format name env)
```

### debug-fun

```code
(debug-fun name list) -> list
```

### debug-fun?

```code
(debug-fun? form)
```

### debug-send

```code
(debug-send form ...)
```

### dec

```code
(dec num) -> num
```

### def

```code
(def env var val [var val] ...)
```

### def-bit

```code
(def-bit name base [(bit field ...)] ...)
```

### def-enum

```code
(def-enum name base [(enum field ...)] ...)
```

### def-struct

```code
(def-struct name base [(byte field ...)] ...)
```

### def-vars

```code
(def-vars [(byte field ...)] ...)
```

### def?

```code
(def? var [env])
```

### defabstractmethod

```code
(defabstractmethod (this [arg ...]) body)
```

### defclass

```code
(defclass name ([arg ...]) (super ...) body)
```

### deffimethod

```code
(deffimethod name ffi)
```

### defgetmethod

```code
(defgetmethod field)
```

### defmethod

```code
(defmethod name (this [arg ...]) body)
```

### defq

```code
(defq var val [var val] ...)
```

### defsetmethod

```code
(defsetmethod field)
```

### defun

```code
(defun name ([arg ...]) body)
```

### destroy

```code
(destroy key val)
```

### dim

```code
(dim nums array)
```

### dim-get

```code
(dim-get nums dim)
```

### dim-set

```code
(dim-set nums dim form)
```

### each

```code
(each lambda seq ...)
```

### each!

```code
(each! start end lambda (seq ...))
```

### each-found

```code
(each-found lambda text substr)
```

### each-line

```code
(each-line lambda stream)
```

### each-match

```code
(each-match lambda text regexp)
```

### each-mergeable

```code
(each-mergeable lambda seq) -> seq
```

### each-mergeable-rev

```code
(each-mergeable-rev lambda seq) -> seq
```

### each-rev

```code
(each-rev lambda seq ...)
```

### elem-get

```code
(elem-get index seq)
```

### elem-set

```code
(elem-set index array val)
```

### emap

```code
(emap [num_buckets]) -> emap
```

### emap-kv

```code
(emap-kv [key val ...]) -> emap
```

### emit-translate

```code
(emit-translate emit_code) -> func_binary
```

### empty?

```code
(empty? form) -> :t | :nil
```

### ends-with

```code
(ends-with str str) -> :t | :nil
```

### enums

```code
(enums name base [(enum field ...)] ...)
```

### env

```code
(env [num])
```

### env-pop

```code
(env-pop [env])
```

### env-push

```code
(env-push [env])
```

### env-resize

```code
(env-resize num [env])
```

### env?

```code
(env? form) -> :t | :nil
```

### eql

```code
(eql form form)
```

### erase

```code
(erase seq start end) -> seq
```

### eval

```code
(eval form [env])
```

### even?

```code
(even? num) -> :t | :nil
```

### every

```code
(every lambda seq ...) -> :nil | form
```

### exec

```code
(exec form)
```

### expand

```code
(expand str tab_width)
```

### export

```code
(export env sym ...)
```

### export-classes

```code
(export-classes class ...)
```

### export-symbols

```code
(export-symbols sym ...)
```

### ffi

```code
(ffi sym path flags)
```

### file-stream

```code
(file-stream path [mode])
```

### filter

```code
(filter lambda seq) -> list
```

### find

```code
(find elem seq)
```

### find-rev

```code
(find-rev elem seq)
```

### first

```code
(first seq) -> el | :nil
```

### fixeds

```code
(fixeds [num ...])
```

### fixeds-floor

```code
(fixeds-floor fixeds [fixeds])
```

### fixeds-frac

```code
(fixeds-frac fixeds [fixeds])
```

### floor

```code
(floor num)
```

### fmap

```code
(fmap [num_buckets]) -> fmap
```

### fmap-kv

```code
(fmap-kv [key val ...]) -> fmap
```

### font-glyph-bounds

```code
(font-glyph-bounds font str)
```

### font-glyph-paths

```code
(font-glyph-paths font str)
```

### font-glyph-ranges

```code
(font-glyph-ranges font)
```

### font-info

```code
(font-info font)
```

### font-sym-texture

```code
(font-sym-texture font sym)
```

### frac

```code
(frac num)
```

### free-select

```code
(free-select select)
```

### fset

```code
(fset [num_buckets]) -> fset
```

### fset-k

```code
(fset-k [key ...]) -> fset
```

### func-load

```code
(func-load name) -> (list body links refs)
```

### func-refs

```code
(func-refs fobj) -> (list [sym] ...)
```

### func?

```code
(func? form) -> :t | :nil
```

### gather

```code
(gather map key ...) -> (val ...)
```

### gen-norms

```code
(gen-norms verts tris) -> (norms new_tris)
```

### gensym

```code
(gensym)
```

### get

```code
(get var [env])
```

### get-byte

```code
(get-byte str index) -> num
```

### get-cstr

```code
(get-cstr str index) -> str
```

### get-field

```code
(get-field obj field size|0)
```

### get-int

```code
(get-int str index) -> num
```

### get-long

```code
(get-long str index) -> num
```

### get-netid

```code
(get-netid str index) -> netid
```

### get-nodeid

```code
(get-nodeid str index) -> nodeid
```

### get-short

```code
(get-short str index) -> num
```

### get-ubyte

```code
(get-ubyte str index) -> num
```

### get-uint

```code
(get-uint str index) -> num
```

### get-ushort

```code
(get-ushort str index) -> num
```

### getf

```code
(getf obj field [offset]) -> value
```

### gui-deinit

```code
(gui-deinit)
```

### gui-event

```code
(gui-event)
```

### gui-info

```code
(gui-info)
```

### gui-init

```code
(gui-init screen)
```

### gui-update

```code
(gui-update mx my flags)
```

### hash

```code
(hash obj)
```

### identity

```code
(identity any) -> any
```

### if

```code
(if tst form [else_form])
```

### import

```code
(import path [env]) -> env
```

### in-get-state

```code
(in-get-state in) -> num
```

### in-mbox

```code
(in-mbox in) -> mbox
```

### in-next-msg

```code
(in-next-msg in)
```

### in-set-state

```code
(in-set-state in num) -> in
```

### in-stream

```code
(in-stream)
```

### inc

```code
(inc num) -> num
```

### insert

```code
(insert seq pos seq) -> seq
```

### int-to-hex-str

```code
(int-to-hex-str num) -> str
```

### io-stream

```code
(io-stream io)
```

### iso-surface

```code
(iso-surface grid isolevel) -> tris
```

### join

```code
(join list seq) -> seq
```

### kernel-stats

```code
(kernel-stats)
```

### lambda

```code
(lambda ([arg ...]) body)
```

### lambda-func?

```code
(lambda-func? form) -> :t | :nil
```

### lambda?

```code
(lambda? form) -> :t | :nil
```

### last

```code
(last seq) -> el | :nil
```

### length

```code
(length seq)
```

### let

```code
(let ([(var val) ...]) body)
```

### let*

```code
(let* ([(var val) ...]) body)
```

### lisp-nodes

```code
(lisp-nodes) -> nodes
```

### lisp_node?

```code
(lisp_node? node) -> :t | :nil
```

### list

```code
(list [form ...])
```

### list?

```code
(list? form) -> :t | :nil
```

### lists

```code
(lists n) -> (list (list0) - (listn-1))
```

### lists2

```code
(lists2) -> (list (list) (list))
```

### lmap

```code
(lmap) -> lmap
```

### lmap-kv

```code
(lmap-kv [key val ...]) -> lmap
```

### lmatch?

```code
(lmatch? list list)
```

### load

```code
(load path)
```

### load-path

```code
(load-path)
```

### load-stream

```code
(load-stream path) -> :nil | stream
```

### log2

```code
(log2 num) -> num
```

### logand

```code
(logand [num] ...)
```

### logior

```code
(logior [num] ...)
```

### lognot

```code
(lognot num) -> num
```

### logxor

```code
(logxor [num] ...)
```

### long-to-hex-str

```code
(long-to-hex-str num) -> str
```

### lower

```code
(lower field | (field val) ...) -> (set this field var ...)
```

### macro-func?

```code
(macro-func? form) -> :t | :nil
```

### macro?

```code
(macro? form) -> :t | :nil
```

### macroexpand

```code
(macroexpand form)
```

### mail-alloc-mbox

```code
(mail-alloc-mbox)
```

### mail-declare

```code
(mail-declare mbox name info)
```

### mail-enquire

```code
(mail-enquire prefix)
```

### mail-forget

```code
(mail-forget key)
```

### mail-free-mbox

```code
(mail-free-mbox mbox)
```

### mail-nodes

```code
(mail-nodes)
```

### mail-poll

```code
(mail-poll mboxs)
```

### mail-read

```code
(mail-read mbox)
```

### mail-select

```code
(mail-select mboxs)
```

### mail-send

```code
(mail-send mbox obj)
```

### mail-timeout

```code
(mail-timeout mbox ns id)
```

### mail-validate

```code
(mail-validate mbox)
```

### map

```code
(map lambda seq ...) -> list
```

### map-rev

```code
(map-rev lambda seq ...) -> list
```

### map?

```code
(map? object) -> :t | :nil
```

### mat3x2-mul-f

```code
(mat3x2-mul-f mat3x2_a mat3x2_b) -> mat3x2-f
```

### mat3x3-mul

```code
(mat3x3-mul mat3x3_a mat3x3_b) -> mat3x3
```

### mat4x4-invert

```code
(mat4x4-invert mat4x4) -> mat4x4
```

### mat4x4-mul

```code
(mat4x4-mul mat4x4_a mat4x4_b) -> mat4x4
```

### match?

```code
(match? text regexp) -> :t | :nil
```

### matches

```code
(matches text regexp) -> (list [(i0 i1)] ...)
```

### max

```code
(max num num ...)
```

### max-length

```code
(max-length list) -> max
```

### merge-obj

```code
(merge-obj dlist slist) -> dlist
```

### min

```code
(min num num ...)
```

### n2f

```code
(n2f num)
```

### n2i

```code
(n2i num)
```

### n2r

```code
(n2r num)
```

### neg

```code
(neg num)
```

### neg?

```code
(neg? num) -> :t | :nil
```

### nempty?

```code
(nempty? form) -> :t | :nil
```

### nil?

```code
(nil? o) -> :t | :nil
```

### nlo

```code
(nlo num) -> num
```

### nlz

```code
(nlz num) -> num
```

### not

```code
(not form) -> :t | :nil
```

### notany

```code
(notany lambda seq ...) -> :t | :nil
```

### notevery

```code
(notevery lambda seq ...) -> :t | :nil
```

### nto

```code
(nto num) -> num
```

### ntz

```code
(ntz num) -> num
```

### num-intern

```code
(num-intern num)
```

### num-to-char

```code
(num-to-char num) -> char
```

### num-to-utf8

```code
(num-to-utf8 num) -> str
```

### num?

```code
(num? form) -> :t | :nil
```

### nums

```code
(nums [num ...])
```

### nums-abs

```code
(nums-abs nums [nums])
```

### nums-add

```code
(nums-add nums nums [nums])
```

### nums-div

```code
(nums-div nums nums [nums])
```

### nums-dot

```code
(nums-dot nums nums)
```

### nums-max

```code
(nums-max nums nums [nums])
```

### nums-min

```code
(nums-min nums nums [nums])
```

### nums-mod

```code
(nums-mod nums nums [nums])
```

### nums-mul

```code
(nums-mul nums nums [nums])
```

### nums-scale

```code
(nums-scale nums scale [nums])
```

### nums-sub

```code
(nums-sub nums nums [nums])
```

### nums-sum

```code
(nums-sum nums)
```

### obj-ref

```code
(obj-ref num)
```

### odd?

```code
(odd? num) -> :t | :nil
```

### open-child

```code
(open-child task mode) -> str
```

### open-pipe

```code
(open-pipe tasks) -> (str ...)
```

### open-remote

```code
(open-remote task node mode) -> str
```

### open-task

```code
(open-task task node mode key_num reply)
```

### opt

```code
(opt var val [cond])
```

### opt-mesh

```code
(opt-mesh verts norms tris) -> (new_verts new_norms new_tris)
```

### opt-vectors

```code
(opt-vectors vectors) -> (new_vectors new_indexs)
```

### options

```code
(options stdio optlist) -> :nil | args
```

### options-find

```code
(options-find optlist arg) -> :nil | opt_entry
```

### options-print

```code
(options-print &rest _)
```

### or

```code
(or [tst] ...) -> :nil | tst
```

### os

```code
(os) -> sym
```

### out-stream

```code
(out-stream mbox)
```

### pad

```code
(pad form width [str]) -> str
```

### partition

```code
(partition count seq) -> list of lists
```

### path

```code
(path [num ...])
```

### path-filter

```code
(path-filter tol src dst)
```

### path-gen-arc

```code
(path-gen-arc cx cy start end radius tol dst) -> dst
```

### path-gen-cubic

```code
(path-gen-cubic p1x p1y p2x p2y p3x p3y p4x p4y tol dst) -> dst
```

### path-gen-ellipse

```code
(path-gen-ellipse cx cy rx ry tol dst) -> dst
```

### path-gen-paths

```code
(path-gen-paths svg_d tol) -> (list (:nil|:t path) ...)
```

### path-gen-quadratic

```code
(path-gen-quadratic p1x p1y p2x p2y p3x p3y tol dst) -> dst
```

### path-gen-rect

```code
(path-gen-rect x y x1 y1 rx ry tol dst) -> dst
```

### path-simplify

```code
(path-simplify tol src dst)
```

### path-stroke-polygon

```code
(path-stroke-polygon path radius tol join) -> paths
```

### path-stroke-polygons

```code
(path-stroke-polygons dst radius tol join src) -> dst
```

### path-stroke-polyline

```code
(path-stroke-polyline path radius tol join cap1 cap2) -> path
```

### path-stroke-polylines

```code
(path-stroke-polylines dst radius tol join cap1 cap2 src) -> dst
```

### path-svg

```code
(path-svg d) -> commands
```

### path-transform

```code
(path-transform m3x2 src dst)
```

### penv

```code
(penv [env])
```

### pii-dirlist

```code
(pii-dirlist path)
```

### pii-fstat

```code
(pii-fstat path)
```

### pii-read-char

```code
(pii-read-char fd)
```

### pii-remove

```code
(pii-remove path)
```

### pii-time

```code
(pii-time)
```

### pii-write-char

```code
(pii-write-char fd char)
```

### pipe-run

```code
(pipe-run cmdline &optional outfun)
```

### pivot

```code
(pivot lambda list start end)
```

### pixmap-cpm-info

```code
(pixmap-cpm-info stream) -> (width height type) | (-1 -1 -1)
```

### pixmap-info

```code
(pixmap-info file) -> (width height type) | (-1 -1 -1)
```

### pixmap-load

```code
(pixmap-load file) -> :nil | pixmap
```

### pixmap-load-cpm

```code
(pixmap-load-cpm stream)
```

### pixmap-load-tga

```code
(pixmap-load-tga stream)
```

### pixmap-save

```code
(pixmap-save pixmap file type) -> :nil | pixmap
```

### pixmap-save-cpm

```code
(pixmap-save-cpm pixmap stream format)
```

### pixmap-tga-info

```code
(pixmap-tga-info stream) -> (width height type) | (-1 -1 -1)
```

### pop

```code
(pop array)
```

### pos?

```code
(pos? num) -> :t | :nil
```

### pow

```code
(pow base exponent) -> integer
```

### prebind

```code
(prebind form)
```

### prin

```code
(prin [form ...])
```

### print

```code
(print [form ...])
```

### profile-print

```code
(profile-print name [stream]) -> stdout | stream
```

### profile-report

```code
(profile-report name [reset])
```

### progn

```code
(progn [form ...])
```

### push

```code
(push array form ...)
```

### quasi-quote

```code
(quasi-quote form)
```

### quasi-quote?

```code
(quasi-quote? form) -> :t | :nil
```

### quote

```code
(quote form)
```

### quote?

```code
(quote? form) -> :t | :nil
```

### raise

```code
(raise field | (var val) ...) -> (defq var (get field this) ...)
```

### random

```code
(random num)
```

### range

```code
(range start end [step]) -> list
```

### rcurry

```code
(rcurry lambda var ...) -> lambda
```

### read

```code
(read stream last_char)
```

### read-avail

```code
(read-avail stream)
```

### read-char

```code
(read-char stream [width])
```

### read-data

```code
(read-data stream bytes) -> str
```

### read-int

```code
(read-int stream) -> num
```

### read-line

```code
(read-line stream)
```

### read-long

```code
(read-long stream) -> num
```

### read-short

```code
(read-short stream) -> num
```

### reals

```code
(reals [num ...])
```

### recip

```code
(recip fixed)
```

### reduce

```code
(reduce lambda seq [accum]) -> form
```

### reduce-rev

```code
(reduce-rev lambda seq [accum]) -> form
```

### repl

```code
(repl stream path)
```

### rest

```code
(rest seq) -> :nil | seq
```

### reverse

```code
(reverse list) -> list
```

### save

```code
(save str path)
```

### search

```code
(search text creg start) -> -1 | end
```

### second

```code
(second seq) -> el | :nil
```

### seq?

```code
(seq? form) -> :t | :nil
```

### set

```code
(set env var val [var val] ...)
```

### set-field

```code
(set-field obj field size|0 val)
```

### set?

```code
(set? object) -> :t | :nil
```

### setd

```code
(setd var val [var val] ...)
```

### setf

```code
(setf obj field value [offset]) -> obj
```

### setf->

```code
(setf-> msg form ...)
```

### setq

```code
(setq var val [var val] ...)
```

### short-to-hex-str

```code
(short-to-hex-str num) -> str
```

### shuffle

```code
(shuffle list [start end]) -> list
```

### shuffled

```code
(shuffled list [start end]) -> list
```

### sign

```code
(sign num)
```

### sin

```code
(sin angle)
```

### slice

```code
(slice start end seq)
```

### some

```code
(some lambda seq ...) -> :nil | form
```

### some!

```code
(some! start end mode lambda (seq ...))
```

### some-rev

```code
(some-rev lambda seq ...) -> :nil | form
```

### sort

```code
(sort fcmp list [start end]) -> list
```

### sorted

```code
(sorted fcmp list [start end]) -> list
```

### split

```code
(split str chars)
```

### sqrt

```code
(sqrt num)
```

### starts-with

```code
(starts-with str str) -> :t | :nil
```

### static

```code
(static form)
```

### stdio-get-args

```code
(stdio-get-args stdio) -> list
```

### str

```code
(str [form ...])
```

### str-alloc

```code
(str-alloc size)
```

### str-as-num

```code
(str-as-num str) -> num
```

### str-to-num

```code
(str-to-num str)
```

### str?

```code
(str? form) -> :t | :nil
```

### stream-avail

```code
(stream-avail stream)
```

### stream-flush

```code
(stream-flush stream)
```

### stream-seek

```code
(stream-seek stream offset pos)
```

### string-stream

```code
(string-stream str)
```

### structure

```code
(structure name base [(byte field ...)] ...)
```

### substr

```code
(substr text substr) -> (list [(i0 i1)] ...)
```

### swap

```code
(swap list index index)
```

### sym

```code
(sym str)
```

### sym?

```code
(sym? form) -> :t | :nil
```

### task-netid

```code
(task-netid)
```

### task-sleep

```code
(task-sleep usec)
```

### texture-metrics

```code
(texture-metrics texture) -> (handle width height)
```

### third

```code
(third seq) -> el | :nil
```

### throw

```code
(throw str form)
```

### time-in-seconds

```code
(time-in-seconds time) -> str
```

### times

```code
(times num body)
```

### to-lower

```code
(to-lower str) -> str
```

### to-net-id

```code
(to-net-id service_id) -> net_id
```

### to-service-id

```code
(to-service-id net_id) -> service_id
```

### to-upper

```code
(to-upper str) -> str
```

### tolist

```code
(tolist env)
```

### trim

```code
(trim str [str]) -> str
```

### trim-end

```code
(trim-end str [str]) -> str
```

### trim-start

```code
(trim-start str [str]) -> str
```

### type-of

```code
(type-of obj)
```

### type-to-size

```code
(type-to-size sym) -> num
```

### ui-backdrop

```code
(ui-backdrop name [props] [body]) -> backdrop
```

### ui-button

```code
(ui-button name [props] [body]) -> button
```

### ui-buttons

```code
(ui-buttons symbols event [props])
```

### ui-canvas

```code
(ui-canvas name width height scale [props]) -> canvas
```

### ui-element

```code
(ui-element name func [props] [body]) -> view
```

### ui-flow

```code
(ui-flow name [props] [body]) -> flow
```

### ui-grid

```code
(ui-grid name [props] [body]) -> grid
```

### ui-hchart

```code
(ui-hchart name title num_marks [props]) -> hchart
```

### ui-label

```code
(ui-label name [props] [body]) -> label
```

### ui-merge-props

```code
(ui-merge-props props) -> props
```

### ui-progress

```code
(ui-progress name [props]) -> progress
```

### ui-props

```code
(ui-props props [props]) -> props
```

### ui-root

```code
(ui-root name func [props] [body]) -> view
```

### ui-scroll

```code
(ui-scroll name flags [props] [body]) -> scroll
```

### ui-slider

```code
(ui-slider name [props]) -> slider
```

### ui-spinner

```code
(ui-spinner name [props]) -> spinner
```

### ui-textfield

```code
(ui-textfield name [props]) -> textfield
```

### ui-title

```code
(ui-title name [props]) -> title
```

### ui-title-bar

```code
(ui-title-bar name title symbols event [props]) -> flow
```

### ui-tool-bar

```code
(ui-tool-bar name [props] [body]) -> flow
```

### ui-tree

```code
(ui-tree name event [props]) -> tree
```

### ui-vdu

```code
(ui-vdu name [props]) -> vdu
```

### ui-view

```code
(ui-view name [props] [body]) -> view
```

### ui-window

```code
(ui-window name [props] [body]) -> window
```

### undef

```code
(undef env var [var] ...)
```

### unless

```code
(unless tst body)
```

### until

```code
(until tst body)
```

### unzip

```code
(unzip seq buckets) -> buckets
```

### vdu-configure

```code
(vdu-configure vdu)
```

### vdu-load

```code
(vdu-load vdu lines ox oy cx cy)
```

### vertex-interp

```code
(vertex-interp isolevel p1 p2 valp1 valp2) -> p
```

### view-add-back

```code
(view-add-back parent child)
```

### view-add-dirty

```code
(view-add-dirty view x y w h)
```

### view-add-front

```code
(view-add-front parent child)
```

### view-add-opaque

```code
(view-add-opaque view x y w h)
```

### view-children

```code
(view-children view)
```

### view-clr-opaque

```code
(view-clr-opaque view)
```

### view-find-id

```code
(view-find-id view id)
```

### view-fit

```code
(view-fit x y w h) -> (x y w h)
```

### view-hide

```code
(view-hide view)
```

### view-hit-tree

```code
(view-hit-tree view x y)
```

### view-locate

```code
(view-locate w h [flag]) -> (x y w h)
```

### view-set-flags

```code
(view-set-flags view flags mask)
```

### view-sub

```code
(view-sub view)
```

### view-sub-opaque

```code
(view-sub-opaque view x y w h)
```

### view-to-back

```code
(view-to-back view)
```

### view-to-front

```code
(view-to-front view)
```

### view-trans-dirty

```code
(view-trans-dirty view rx ry)
```

### walk-list

```code
(walk-list list fnc_element fnc_in fnc_out)
```

### weak-ref

```code
(weak-ref obj)
```

### when

```code
(when tst body)
```

### while

```code
(while tst body)
```

### within-compile-env

```code
(within-compile-env lambda)
```

### write

```code
(write stream str)
```

### write-char

```code
(write-char stream list|num [width])
```

### write-int

```code
(write-int stream num|list) -> stream
```

### write-line

```code
(write-line stream str) -> stream
```

### write-long

```code
(write-long stream num|list) -> stream
```

### write-short

```code
(write-short stream num|list) -> stream
```

### xmap

```code
(xmap [num_buckets cmp_fnc hash_fnc]) -> xmap
```

### xmap-kv

```code
(xmap-kv [key val ...]) -> xmap
```

### xml-parse

```code
(xml-parse stream)
```

### xset

```code
(xset [num_buckets cmp_fnc hash_fnc]) -> xset
```

### xset-k

```code
(xset-k [key ...]) -> xset
```

### zip

```code
(zip seq ...) -> list
```


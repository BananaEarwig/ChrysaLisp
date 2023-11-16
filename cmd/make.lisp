(import "lib/asm/asm.inc")
(import "lib/task/pipe.inc")
(import "lib/options/options.inc")
(import "lib/text/files.inc")

(defun parent? (info)
	(some! 2 -1 :nil (#
		(if (<= (ascii-code "A") (code (first %0)) (ascii-code "Z")) %0)) (list info)))

(defun information (stream info)
	(when (nempty? info)
		(write-line stream "```code")
		(write-line stream (first info))
		(setq info (rest info))
		(when (nempty? info)
			(write-line stream "")
			(each (# (write-line stream %0)) info))
		(write-line stream (cat "```" (ascii-char 10)))))

(defun sanitise (_)
	(defq out (cap (length _) (list)))
	(. (reduce (# (. %0 :insert %1)) _ (Fset 31)) :each
		(# (unless (some (lambda (_) (starts-with _ %0))
			'("lib/asm/" "lib/trans/" "lib/keys/"))
			(push out %0)))) out)

(defun make-docs ()
	(defq *abi* (abi) *cpu* (cpu))
	(defun chop (_)
		(when (defq e (find-rev (char 0x22) _))
			(setq _ (slice 0 e _))
			(slice (inc (find-rev (char 0x22) _)) -1 _)))
	(print "Scanning source files...")

	;scan VP classes docs
	(defq *imports* (all-vp-files) classes (list) functions (list)
		docs (list) syntax (list) state :x)
	(within-compile-env (lambda ()
		(include "lib/asm/func.inc")
		(each include (all-class-files))
		(each-mergeable (lambda (file)
			(each-line (lambda (line)
				(when (eql state :y)
					(defq s (split line +char_class_space))
					(if (and (> (length s) 0) (starts-with ";" (first s)))
						(push (last docs) (slice (inc (find ";" line)) -1 line))
						(setq state :x)))
				(when (and (eql state :x) (>= (length line) 9))
					(defq s (split line (const (cat (ascii-char 9) " ()'" (ascii-char 34) (ascii-char 13)))) _ (first s))
					(cond
						((eql _ "include")
							(make-merge *imports* (list (abs-path (second s) file))))
						((eql _ "def-class")
							(push classes (list (second s) (third s))))
						((eql _ "dec-method")
							(push (last classes) (list (second s) (sym (third s)))))
						((eql _ "def-method")
							(setq state :y)
							(push docs (list))
							(push functions (f-path (sym (second s)) (sym (third s)))))
						((or (eql _ "def-func") (eql _ "defun"))
							(setq state :y)
							(push docs (list))
							(push functions (sym (second s))))
						((and (or (eql _ "call") (eql _ "jump")) (eql (third s) ":repl_error"))
							(when (and (setq line (chop line)) (not (find line syntax)))
								(push syntax line)
								(push (last docs) "lisp binding" line)))))) (file-stream file))) *imports*)))

	;create VP classes docs
	(sort (# (cmp (first %0) (first %1))) classes)
	(each (lambda ((cls super &rest methds))
		(defq stream (file-stream (cat "docs/Reference/VP_Classes/" cls ".md") +file_open_write))
		(write-line stream (cat "# " cls (ascii-char 10)))
		(unless (eql ":nil" super)
			(write-line stream (cat "## " super (ascii-char 10))))
		(sort (# (cmp (first %0) (first %1))) methds)
		(defq lisp_methds (filter (# (starts-with ":lisp_" (first %0))) methds)
			methds (filter (# (not (starts-with ":lisp_" (first %0)))) methds))
		(when (nempty? lisp_methds)
			(write-line stream (cat "## Lisp Bindings" (ascii-char 10)))
			(each (lambda ((methd function))
				(when (and (defq i (find function functions))
						(/= 0 (length (defq info (elem-get i docs)))))
					(when (defq i (find "lisp binding" info))
						(write-line stream (cat "### " (elem-get (inc i) info) (ascii-char 10)))
						(setq info (slice 0 i info))))) lisp_methds))
		(when (nempty? methds)
			(write-line stream (cat "## VP methods" (ascii-char 10)))
			(each (lambda ((methd function))
				(write-line stream (cat "### " methd " -> " function (ascii-char 10)))
				(when (and (defq i (find function functions))
						(/= 0 (length (defq info (elem-get i docs)))))
					(write-line stream "```code")
					(each (# (write-line stream %0)) info)
					(write-line stream (const (str "```" (ascii-char 10)))))) methds))
		(print (cat "-> docs/Reference/VP_Classes/" cls ".md"))) classes)

	;create lisp functions and classes docs
	(defq classes (list) functions (list) keys (list))
	(each (lambda (file)
		(defq state :nil info :nil methods :nil)
		(each-line (lambda (line)
			(case state
				((:function :class :method)
					(defq s (split line +char_class_space))
					(if (and (nempty? s) (starts-with ";" (first s)))
						(push info (trim (slice (inc (find ";" line)) -1 line)))
						(setq state :nil)))
				(:keys
					(defq s (split line +char_class_space))
					(if (nempty? s)
						(push info (trim-start (trim-end line ")") (ascii-char 9)))
						(setq state :nil)))
				(:t (when (> (length line) 9)
						(defq words (split line (const (cat (ascii-char 9) " ()'" (ascii-char 13))))
							type (first words) name (second words))
						(unless (or (some (# (eql name %0))
										'(":type_of" ",predn" ",n"
										"_structure" "defun" "defmacro"))
									(starts-with "action-" name))
							(case type
								(("*key_map*" "*key_map_shift*" "*key_map_control*")
									(push keys (list file type (setq info (list))))
									(setq state :keys))
								(("defun" "defmacro")
									(push functions (list name (setq info (list))))
									(setq state :function))
								("defclass"
									(push classes (list name (parent? words)
										(setq methods (list)) (setq info (list))))
									(setq state :class))
								(("defmethod" "deffimethod" "defabstractmethod")
									(push methods (list name (setq info (list))))
									(setq state :method))
								("defgetmethod"
									(push methods (list (cat ":get_" name) (setq info (list))))
									(setq state :method))
								("defsetmethod"
									(push methods (list (cat ":set_" name) (setq info (list))))
									(setq state :method))))))))
			(file-stream file)))
		(sanitise (cat
			(all-files "." '("lisp.inc" "actions.inc") 2)
			(all-files "./lib" '(".inc") 2)
			'("class/lisp/root.inc"))))

	;classes
	(sort (# (cmp (first %0) (first %1))) classes)
	(each (lambda ((name pname methods info))
		(defq stream (file-stream (cat "docs/Reference/Classes/" name ".md") +file_open_write))
		(write-line stream (cat "# " name (ascii-char 10)))
		(if pname (write-line stream (cat "## " pname (ascii-char 10))))
		(information stream info)
		(sort (# (cmp (first %0) (first %1))) methods)
		(each (lambda ((name info))
			(write-line stream (cat "### " name (ascii-char 10)))
			(information stream info)) methods)
		(print (cat "-> docs/Reference/Classes/" name ".md"))) classes)

	;key bindings
	(defq stream (file-stream "docs/Reference/KEYS.md" +file_open_write)
		current_file "")
	(sort (# (if (/= 0 (defq _ (cmp (first %0) (first %1))))
		_ (cmp (second %0) (second %1)))) keys)
	(write-line stream (cat "# Key Bindings" (ascii-char 10)))
	(each (lambda ((file name info))
		(unless (eql file current_file)
			(write-line stream (cat "## " file (ascii-char 10)))
			(setq current_file file))
		(when (nempty? info)
			(write-line stream (cat "### " name (ascii-char 10)))
			(write-line stream "```code")
			(each (# (write-line stream %0)) info)
			(write-line stream (cat "```" (ascii-char 10))))) keys)
	(print "-> docs/Reference/KEYS.md")

	;create functions docs
	(defq document "docs/Reference/FUNCTIONS.md"
		stream (file-stream document +file_open_write))
	(write-line stream (cat "# Functions" (ascii-char 10)))
	(each (lambda ((name info))
			(when (nempty? info)
				(write-line stream (cat "### " name (ascii-char 10)))
				(information stream info)))
		(sort (# (cmp (first %0) (first %1))) functions))
	(print "-> " document)

	;create commands docs
	(defq document "docs/Reference/COMMANDS.md"
		stream (file-stream document +file_open_write)
		commands (sort cmp (map (# (slice 0 -6 %0))
			(all-files "cmd" '(".lisp") 4))))
	(each (# (write-line stream (cat "## " %0))
		(write-line stream "```code")
		(pipe-run (cat %0 " -h") (# (write stream %0)))
		(write-line stream "```")) commands)
	(print "-> " document))

(defq usage `(
(("-h" "--help")
"Usage: make [options] [all] [boot] [platforms] [doc] [it] [test]

	options:
		-h --help: this help info.

	all:        include all .vp files.
	boot:       create a boot image.
	platforms:  for all platforms not just the host.
	docs:       scan source files and create documentation.
	it:         all of the above !
	test:       test make timings.")
))

(defun main ()
	;initialize pipe details and command args, abort on error
	(when (and
			(defq stdio (create-stdio))
			(defq args (options stdio usage)))
		(defq all (find-rev "all" args) boot (find-rev "boot" args)
			platforms (find-rev "platforms" args) docs (find-rev "docs" args)
			it (find-rev "it" args) test (find-rev "test" args))
		(cond
			(test (make-test))
			(it (make-docs) (remake-all-platforms))
			((and boot all platforms) (remake-all-platforms))
			((and boot all) (remake-all))
			((and boot platforms) (remake-platforms))
			((and all platforms) (make-all-platforms))
			(all (make-all))
			(platforms (make-platforms))
			(boot (remake))
			(docs (make-docs))
			(:t (make)))))

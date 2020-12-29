(import "sys/lisp.inc")
(import "lib/pipe/pipe.inc")
(print)
(print "ChrysaLisp Installer v0.1")
(print "Building documentation and all platform boot images.")
(print "Please wait...")
(print)
(import "lib/pipe/pipe.inc")
(while (< (length (mail-nodes)) 9) (task-sleep 100000))
(pipe-run "make it" (lambda (_) (prin _) (stream-flush (io-stream "stdout"))))
(print)
(print "Install complete.")
(print "You may now run a TUI with './run_tui.sh' or")
(print "a GUI with './run.sh'")
(print "Please press CNTRL-C to exit!")
(print)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; reader - ChrysaLisp YAML Reader
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(import "lib/xtras/xtras.inc")

(defun-bind Mark (index line column)
  ; (Mark index line column) -> properties
  (properties
    :clz    :clz_reader_mark
    :index  index
    :line   line
    :column column))

(defun-bind Reader (fstr)
  ; (Reader fstr) -> Reader
  ; Returns a new Reader object
  (properties
    :clz    :clz_reader
    :point  0
    :eof    nil
    :buffer (cat fstr (ascii-char 0))
    :len    (inc (length fstr))
    :index  0
    :line   1
    :column 0))

(defq
  comment "#"
  eof     (char 0x0)
  tab     (char 0x09)
  lf      (char 0x0a)
  cr      (char 0x0d)
  blank   (char 0x20)
  fslash  (char 0x2f)
  bslash  (char 0x5c))

(defq
  crlf    (const (cat "" cr lf))
  breakz  (const (cat "" lf eof)))

(defun-bind _add (x y) (+ x y))

(defun-bind rdr-calc-off (rdr idx &optional src)
  ; (calc-off rdr idx) -> offset | exception
  ; Throws exception if offset exceeds bounds
  (setd src "Unknown")
  (defq _offset (_add (gets rdr :point) idx))
  (when (> _offset (gets rdr :len))
    (throw (str src ": Attempt to read past EOF ")
      (properties
        :calc_off _offset
        :buff_len (gets rdr :len))))
  _offset)

(defun-bind rdr-peek (rdr &optional index)
  ; (peek rdr index) -> char | exception
  (setd index 0)
  (elem (rdr-calc-off rdr index "rdr-peek") (gets rdr :buffer)))


(defun-bind rdr-prefix (rdr &optional len)
  ; (prefix rdr len) -> str | exception
  (setd len 1)
  (slice (gets rdr :point) (rdr-calc-off rdr len "rdr-prefix") (gets rdr :buffer)))

(defun-bind rdr-forward (rdr &optional len)
  ; (forward rdr len) -> nil | exception
  (setd len 1)
  (rdr-calc-off rdr len "rdr-forward")
  (while (> len 0)
    (defq ch (elem (gets rdr :index) (gets rdr :buffer)))
    (sets-pairs! rdr
      :point    (inc (gets rdr :point))
      :index  (inc (gets rdr :index))
      :column (inc (gets rdr :column)))
    (when (eql ch lf)
      (sets-pairs! rdr
        :line (inc (gets rdr :line))
        :column 0))
    (setq len (dec len))))

(defun-bind rdr-get-mark (rdr)
  ; (get-mark rdr) -> Mark
  (Mark (gets rdr :index) (gets rdr :line) (gets rdr :column)))

(defun-bind rdr-dump (fname mfunc)
  (defq rdr (Reader (load fname)))
  (print "Dumping " fname)
  (catch (until (eql (defq ch (rdr-peek rdr)) (ascii-char 0))
    (mfunc ch)
    (rdr-forward rdr)
    (setq ch (rdr-peek rdr)))
    (print "Houston.... problem " _))
  (print))

; Reserved for later 'buffering' of file
; (defun update (rdr len))
; (defun update-raw (rdr ))

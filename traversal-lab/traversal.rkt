\documentclass[12pt]{article}
\usepackage[letterpaper,margin=0.5in]{geometry}

\usepackage{titlesec}
\usepackage{xltxtra,fontspec,xunicode}

\usepackage{minted}

\usemintedstyle{bw}

\defaultfontfeatures{Ligatures={TeX}}
\newfontfamily\mytitlefont{Linux Biolinum}
\newfontfamily\mytextfont{Linux Libertine}
%\setmonofont[Scale=0.86]{Inconsolata}

\titleformat{\chapter}{\mytitlefont\huge}{\chaptertitlename\ \thechapter}{20pt}{\Huge}
\titleformat{\section}{\mytitlefont\Large}{\thesection}{1em}{}
\titleformat{\subsection}{\mytitlefont\large\bfseries}{\thesubsection}{1em}{}
\titleformat{\subsubsection}{\mytitlefont\normalsize\bfseries}{\thesubsubsection}{1em}{}
\titleformat{\paragraph}[runin]{\mytextfont\normalsize\bfseries}{\theparagraph}{1em}{}

\newminted{scheme}{linenos,numbersep=4pt}

\begin{document}

\def\title{Traversal Lab}

\hrule

\mytitlefont

\begin{center}
\begin{Large}
CS 331 --- \title
\end{Large}
\end{center}

\mytextfont

\hrule

\vskip 1em

\section{Introduction and Learning Objectives}

\def\objectives{
\begin{enumerate}
   \item Write a depth-first search traversal.
   \item Write a breadth-first search traversal.
   \item Write a preorder traversal.
   \item Write a postorder traversal.
   \item Write an inorder traversal.
   \item Write a frontier traversal.
   \item Make use of streams.
\end{enumerate}
}
\objectives

\section{Getting Started}

Go to your repository and do a \texttt{git pull}.

The directory has three files, one for the data structure, one for the test
cases, and one to run the test cases.  These are named \texttt{traverse.rkt},
\texttt{test-traverse.rkt}, and \texttt{run-tests.rkt}, respectively.


\section{The Module}

At the beginning of the file, you will see these lines.

\begin{schemecode}
(module traversal racket
  (provide make-tree add traverse-dfs traverse-bsf
           traverse-preorder traverse-postorder traverse-inorder
           traverse-frontier traverse-tests)

  (struct tree (data left right) #:transparent)
\end{schemecode}

The \texttt{provide} lists all the functions we expect you to define.
There is a list below with a bit more detail.  You also see the two
data structure definitions, as they were in class.  I have marked them
as ``transparent'' so it will be easier for you to debug it.

\section{Your Work}

You will create two functions to build trees, and six functions to create
traversals.

\begin{description}
\item[make-tree] This just creates an empty tree.
\item[(add t i)] Insert an element into the tree.  There will be only one
  place in the tree where it should be inserted.  This should run in ${\cal O}(\lg n)$
  time.  If the integer already exists in the tree, simply return.
  
\item[(traverse-dfs t)] You did this in class, so I hope you find it easy.
\item[(traverse-bfs t)]  You might want some queue functions for this.
\item[(traverse-preorder t)]  Gives a preorder traversal.
\item[(traverse-inorder t)]  Gives an inorder traversal.
\item[(traverse-postorder t)]  Gives a postorder traversal.
\item[(traverse-frontier t)]  Iterates over the leaves of the tree,
from left to right.
\end{description}

You do not have to implement size, find, or delete.  You may if you want, but
do not write tests that depend on them or else the grading script will break
and blame you for it.

Hint: some of these are much much easier if you maintain a parent pointer.

\section{Streams}

In order to do the traversals efficiently, we are going to use something called a \emph{stream}.
A stream is a lazy list; it only evaluates the elements when they are asked for.
Here is an example:

\begin{verbatim}
-> (define a (stream-cons (begin (displayln "hi") 1)
             (stream-cons (begin (displayln "there") 2)
             (stream-cons (begin (displayln "doods") 3) empty-stream))))
-> (stream-first a)
hi
1
-> (stream-first a)
1
-> (stream-first (stream-rest a))
there
2
-> (stream-first (stream-rest a))
2
\end{verbatim}

The command \texttt{stream-cons} is like regular list \texttt{cons}, but the
elements are lazy.  They don't evaluate until someone actually asks for the
value.  It's kind of like how students do homework.  The \texttt{stream-first}
is the equivalent of \texttt{car}, and \texttt{stream-rest} is the equivalent
of \texttt{cdr}.  We will go over this more thoroughly in lecture.

\end{document}

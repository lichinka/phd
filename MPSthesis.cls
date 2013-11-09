% MPSthesis v2.1
% by Lucas Benedicic
% Version 2.1 released 31/10/2013
%-------------------------- identification ---------------------
% MPSthesis v2.0
% By Vedrana Vidulin <vedrana.vidulin@ijs.si> and Bostjan Kaluza <bostjan.kaluza@ijs.si>
% Version 2.0 released 30/09/2011
%-------------------------- identification ---------------------
% MPSthesis v1.0
% By Petra Kralj Novak <Petra.Kralj.Novak@ijs.si
% Version 1.0 released 15/01/2009
%-------------------------- identification ---------------------
%\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{MPSthesis}[2009/01/15 v1.0 MPS thesis class] % based on 2003/01/11 v1.2 CUEDthesis class
%-------------------------- initial code -----------------------


%use a Book style document 
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\ifx\pdfoutput\undefined
   \LoadClass[dvips, a4paper]{book}
\else
   \LoadClass[pdftex, a4paper]{book}
\fi

% set up list names
\usepackage{tocloft}

\renewcommand{\cftfigfont}{Figure }
\renewcommand{\cfttabfont}{Table }

\usepackage{amssymb} %defnes all the symbols found in the AMS symbol fonts msam and msbm
%\usepackage{graphics}
\usepackage{fancyhdr} %defines custom page layout
%\usepackage{eucal}
%\usepackage[usenames, dvipsnames]{color}
\usepackage[perpage]{footmisc} %defines style of footnotes
%\usepackage[round, sort, numbers, authoryear]{natbib} %defines citation style
\usepackage{natbib} %defines citation style
\usepackage[english]{babel} %defines language
\usepackage{ifthen} %implements an \ifthenelse command

%\usepackage{watermark}
\usepackage{lscape}
%\usepackage{cmbright}
%\usepackage{moreverb}
\usepackage{ifpdf} %checks whether the current document is typset by pdfTEX in PDF mode



%\usepackage{soul}
\usepackage{supertabular}
\usepackage{subfig}


%Defines style and properties of tables
\usepackage{booktabs} %defines style of a table
\usepackage{multirow} % spans the text through multiple rows
\usepackage[table]{xcolor} %defines a color of a cell

%Defines an environment for algorithms
\usepackage[chapter]{algorithm}

% chapter header
\renewcommand\@chapapp{Chhh}

\def\@makechapterhead#1{%
\renewcommand{\headrulewidth}{0pt}
  \vspace*{-3\p@}%
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne 
      \if@mainmatter
        \Large \bfseries \thechapter \space \space \space
      \fi
    \fi
    \Large \bfseries #1\nobreak
    \vskip 90\p@
  }}

% QUASI-CHAPTERS
%
% environment for quasi-chapters like Abstract, Povzetek and Abbreviations (no chapter number)
\newenvironment{preliminary}[1]{
  \cleardoublepage
  \thispagestyle{fancy}
  \addcontentsline{toc}{chapter}{#1} %adds parameter #1 to contents page 
  \fancyhead{}
  \fancyfoot{}
  \fancyhead[RO]{\thepage}
  \fancyhead[LO]{}
  \fancyhead[LE]{\thepage}
  \fancyhead[RE]{\footnotesize #1}
  \vspace*{-3\p@}%
  {\noindent \Large \bfseries #1}
  \vskip 90\p@
} 

% Nomenclature
\usepackage{nomencl}
\makeglossary
\renewcommand\nomgroup[1]{%
  \ifthenelse{\equal{#1}{A}}{%
   \item[\textbf{Roman Symbols}] }{%             A - Roman
    \ifthenelse{\equal{#1}{G}}{%
     \item[\textbf{Greek Symbols}]}{%             G - Greek
      \ifthenelse{\equal{#1}{R}}{%
        \item[\textbf{Superscripts}]}{%              R - Superscripts
          \ifthenelse{\equal{#1}{S}}{%
           \item[\textbf{Subscripts}]}{{%             S - Subscripts
	    \ifthenelse{\equal{#1}{X}}{%
	     \item[\textbf{Other Symbols}]}{{%    X - Other Symbols
	    \ifthenelse{\equal{#1}{Z}}{%
	     \item[\textbf{Acronyms}]}%              Z - Acronyms
              			{{}}}}}}}}}}

\newif \ifpdf
    \ifx \pdfoutput \undefined
        % for running latex
        \pdffalse
    \else
        % for running pdflatex
        \pdfoutput = 1    % positive value for a PDF output
                          % otherwise a DVI
        \pdftrue
\fi

\ifpdf
%-->
%--> Google.com search "hyperref options"
%--> 
%--> http://www.ai.mit.edu/lab/sysadmin/latex/documentation/latex/hyperref/manual.pdf
%--> http://www.chemie.unibas.ch/~vogtp/LaTeX2PDFLaTeX.pdf 
%--> http://www.uni-giessen.de/partosch/eurotex99/ oberdiek/print/sli4a4col.pdf
%--> http://me.in-berlin.de/~miwie/tex-refs/html/latex-packages.html
%-->
%hyperref --> Extends the functionality of all the LATEX cross-referencing commands
%(including the table of contents, bibliographies etc) to produce \special commands which
%a driver can turn into hypertext links.
    \usepackage[ pdftex, plainpages = false, pdfpagelabels, 
                 pdfpagelayout = useoutlines,
                 bookmarks,
                 bookmarksopen = true,
                 bookmarksnumbered = true,
                 breaklinks = true,
                 linktocpage,
                 pagebackref = false,
                 colorlinks = false,
                 linkcolor = black,
                 urlcolor  = black,
                 citecolor = black,
                 anchorcolor = green,
                 hyperindex = true,
                 hyperfigures
                 ]{hyperref} 

    \DeclareGraphicsExtensions{.pdf, .png, .jpg}
    \usepackage[pdftex]{graphicx}
    \pdfcompresslevel=9
    \graphicspath{{Images/}}
\else
    \usepackage[ dvips, 
                 bookmarks,
                 bookmarksopen = true,
                 bookmarksnumbered = true,
                 breaklinks = true,
                 linktocpage,
                 pagebackref = false,
                 colorlinks = false,
                 linkcolor = black,
                 urlcolor  = black,
                 citecolor = black,
                 anchorcolor = green,
                 hyperindex = true,
                 hyperfigures
                 ]{hyperref}

    \DeclareGraphicsExtensions{.eps, .ps}
    \usepackage{epsfig}
    \usepackage{graphicx}
    \graphicspath{{ThesisFigs/EPS/}{ThesisFigs/}}
\fi



%A4 settings
\ifpdf
   \pdfpageheight=297mm
   \pdfpagewidth=210mm
\else
   \setlength{\paperheight}{297mm}
   \setlength{\paperwidth}{210mm}
\fi

%\setlength{\hoffset}{0cm}
\setlength{\voffset}{-1in}

\setlength{\evensidemargin}{-0.7mm}
\setlength{\oddsidemargin}{0.7cm}

\setlength{\topmargin}{1.5cm}%{-2.2cm}
\setlength{\headheight}{0.5cm}%{1.1cm}
\setlength{\headsep}{1cm} %{0.4cm}

\setlength{\textheight}{24cm}%{23cm} %{25.5cm}
\setlength{\textwidth}{15.3cm}%{16cm}
\setlength{\marginparsep}{0cm}
\setlength{\marginparwidth}{2.5cm}%{3cm}
\setlength{\footskip}{2.36cm}

%supress widows and orphans
\widowpenalty=10000
\clubpenalty=10000

%set font
%\usepackage{mathptmx}

\baselineskip=18pt plus2pt
\renewcommand{\baselinestretch}{1}
% increase line spacing: 1.6 - double, 1.3 - one and a half
\linespread{1}
%\linespread{1.8}

%set section size
%\def\section{\@startsection {section}{1}{\z@}{10pt plus 2pt minus 2pt} {3pt plus 2pt minus 2pt}{\Large\bf}}

\pagestyle{fancy}
%\renewcommand{\chaptermark}[1]{\markboth{\MakeUppercase{#1}}{}}
\renewcommand{\chaptermark}[1]{\markboth{{#1}}{}}
\renewcommand{\sectionmark}[1]{\markright{#1}}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\addtolength{\headheight}{0.5pt}
\fancypagestyle{plain}{
  \fancyhead{}
  \renewcommand{\headrulewidth}{0pt}
}

% page style for regular chapters
\newcommand{\mychapterstyle}{
    \fancyhead[RO]{\footnotesize \thepage}
	\fancyhead[LO]{\footnotesize \leftmark}
    \fancyhead[LE]{\footnotesize \thepage}
	\fancyhead[RE]{\footnotesize \leftmark}
}


% These macros define an environment for front matter that is always 
% single column even in a double-column document.

\newenvironment{alwayssingle}{%
       \@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
       \else\newpage\fi}
       {\if@restonecol\twocolumn\else\newpage\fi}


\renewenvironment{thebibliography}[1]
     {\chapter{\bibname}
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy\clubpenalty4000\widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}


\renewcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
                    \cleardoublepage
                    \thispagestyle{fancy}%                  
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapter}

%defines an environment for algorithms
\usepackage{float}
\newcommand\fs@simplerule{\def\@fs@cfont{\bfseries}\let\@fs@capt\floatc@simplerule
	  \def\@fs@pre{\hrule height0pt depth0pt \kern4pt}%
	  \def\@fs@post{\kern4pt\hrule height0.1mm depth0pt \kern4pt \relax}%
	  \def\@fs@mid{\kern8pt}%
	  \let\@fs@iftopcapt\iftrue}
	\floatstyle{simplerule}

\newfloat{myalgorithm}{htb}{lob}[chapter]
\floatname{myalgorithm}{Algorithm}
%\listof{myalgorithm}{Index of algorithms}

\newcommand{\HRule}{\rule{\linewidth}{0.1mm}} % defines line used in the example

\usepackage[figuresright]{rotating} %rotates a figure or a table
\usepackage{pdfpages}
\usepackage{makeidx}




%\setcounter{secnumdepth}{5}
%\setcounter{tocdepth}{3}


% DECLARATIONS
%
% These macros are used to declare arguments needed for the
% construction of the title page and other preamble.

\def\naslov#1{\def\@naslov{#1}}
\def\supervisor#1{\def\@supervisor{#1}}
\def\cosupervisor#1{\def\@cosupervisor{#1}}
\def\month#1{\def\@month{#1}}
\def\year#1{\def\@year{#1}}
\def\version#1{\def\@version{#1}}

\cosupervisor{}   % set to empty by default 
\version{}

\def\supervisorlong#1{\def\@supervisorlong{#1}}
\def\cosupervisorlong#1{\def\@cosupervisorlong{#1}}

\def\evaluationBoardChairman#1{\def\@evaluationBoardChairman{#1}}
\def\evaluationBoardChairmanAffiliation#1{\def\@evaluationBoardChairmanAffiliation{#1}}

\def\evaluationBoardMember#1{\def\@evaluationBoardMember{#1}}
\def\evaluationBoardMemberAffiliation#1{\def\@evaluationBoardMemberAffiliation{#1}}

\def\evaluationBoardMembers#1{\def\@evaluationBoardMembers{#1}}
\def\evaluationBoardMemberAffiliations#1{\def\@evaluationBoardMemberAffiliations{#1}}


% PREAMBLE
%
% define the page layout for the pages that come before the title page
\newcommand{\makepreamble}{%
 {\thispagestyle{empty}
% title only
	\rm \huge \begin{flushright}\@title\end{flushright} 
	\vspace{2.5cm}	
	\rm \LARGE \begin{flushright}\@author\end{flushright} 
% 
\newpage
\thispagestyle{empty}
	\vspace{1.5cm}
	\normalsize

	\begin{tabular}{l}
		\textbf{Doctoral Dissertation}\\
		\textbf{Jo\v{z}ef Stefan International Postgraduate School}\\
		\textbf{Ljubljana, Slovenia, \@month \ \@year}\\
	\end{tabular}

	%\setlength{\tabcolsep}{20pt}

	\vspace{3.0cm}

   \begin{tabular}{l}
        \textbf{Evaluation Board:} \\
        \emph{\@evaluationBoardChairman}, \emph{Chairman}, \emph{\@evaluationBoardChairmanAffiliation} \\
        \emph{\@evaluationBoardMember}, \emph{Member}, \emph{\@evaluationBoardMemberAffiliation} \\
        \emph{\@evaluationBoardMembers}, \emph{Member}, \@evaluationBoardMemberAffiliations \\
   \end{tabular}
}
\cleardoublepage
}

%cover page
\newcommand{\coverpage}{
	\ifpdf
		\includepdf[pages=1]{DissertationCoverPage.pdf}
	\newpage \thispagestyle{empty}
	\cleardoublepage
	\fi
}

% TITLEPAGE
%
%define title page layout
\renewcommand{\maketitle}{%
 \thispagestyle{empty}\vbox to \vsize{%
	\noindent
	\includegraphics[width=\linewidth, bb=0 0 1539 303]{MPSlogo}
	
	{\noindent \rm \LARGE \@author \par
		\vspace{1.5cm}
	{ 
		\noindent \LARGE \rm {\bfseries \@title} \par
			\vspace{0.8cm}
		\noindent \Large  {\bfseries Doctoral Dissertation}\par
			\vspace{1.4cm}
		\noindent \LARGE {\bfseries \@naslov} \par
			\vspace{0.8cm}
		\noindent \Large  {\bfseries Doktorska disertacija} \par
	}
   	\vspace{2.cm}
	\noindent \large {\itshape Supervisor:} \@supervisor \par
		%\vspace{1mm}
%	\ifthenelse{\equal{\@cosupervisor}{}}{}{{\it Co-supervisor:} \@cosupervisor \par }
	\noindent \large {\itshape Co-Supervisor:} \@cosupervisor \par
		%\vfill
		\vspace{6mm}
	%\normalsize \@month\ \@year \@version \par
	\noindent {\large Ljubljana, Slovenia, \@month\ \@year \@version } \par
	%	\vfill
	%\includegraphics[width=16cm]{MPSlogo}
    } }%
	\newpage \thispagestyle{empty}
  \cleardoublepage
}
 

% DEDICATION
%
% The dedication environment makes sure the dedication gets its
% own page and is set out in verse format.
\newenvironment{dedication}
{ 
  \begin{alwayssingle}
  \pagestyle{empty}
  \vspace*{3cm}
  \begin{quote} 
  \begin{center}}
  {\end{center} 
  \end{quote}
  \end{alwayssingle}
}



\makeindex

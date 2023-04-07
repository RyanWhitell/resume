\ProvidesClass{cv}[Resume and CV Class]
\LoadClass[letterpaper]{article}

% Dependences
\RequirePackage[english]{babel}
\RequirePackage{parskip}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage[margin=1.5cm]{geometry}
\RequirePackage{fontawesome}
\RequirePackage{hyperref}
\RequirePackage{titlesec}
\RequirePackage{array}
\RequirePackage{enumitem}
\RequirePackage{longtable}
\RequirePackage{tikz}
\RequirePackage{fancyhdr}

% Define default accent colors
\definecolor{basecolor}{HTML}{000066}
\definecolor{darkGrey}{HTML}{989898}
\colorlet{linkcolor}{basecolor}
\colorlet{accentcolor}{linkcolor!90}
\colorlet{symbolcolor}{linkcolor!85}

% Setup hyperref package, and colours for links
\hypersetup{
  pdfborder = {0 0 0},
  breaklinks
}

\newcommand\link[2]{\color{linkcolor}\href{#1}{#2}\color{Black} }

% Setup fancyhdr package
\fancyhf{}
\fancyhfoffset{0em}
\renewcommand{\headrulewidth}{0pt}
\pagestyle{fancy}

% Setup CV sections
\titleformat{\section}{\Large\raggedright}{}{0em}{}[\titlerule]
\titlespacing{\section}{0pt}{2pt}{2pt}

% Configure list
\setlist[itemize,1]{label=\faAngleRight, nosep, leftmargin=2em} 

% Setup Array : new column type
\newcolumntype{R}[1]{>{\hfill}m{#1}}

% Setup fonts
\defaultfontfeatures{Mapping=tex-text}

% Define font to use
\setmainfont{SourceSansPro-Light}[
  Path = fonts/, 
  BoldFont = SourceSansPro-Regular, 
  ItalicFont = SourceSansPro-LightIt
]

% New length definition
\newlength{\rightcolumnlength}
\setlength{\rightcolumnlength}{14.8cm}

\newlength{\leftcolumn}
\setlength{\leftcolumn}{2.5cm}

% Font Awesome icons aliases
\newcommand{\mailSymbol}{\faAt}
\newcommand{\locationSymbol}{\faMapMarker}
\newcommand{\linkedinSymbol}{\faLinkedin}
\newcommand{\mobileSymbol}{\faMobilePhone}
\newcommand{\githubSymbol}{\faGithub}
\newcommand{\generalLinkSymbol}{\faLink}

% Create a tag
% Usage: \cvtag{<tag label>}
\newcommand{\cvtag}[1]{
  \tikz[baseline]\node[anchor=base,draw=darkGrey!70,rounded corners=0.5ex,inner xsep=1ex,inner ysep =0.55ex,text height=1.3ex,text depth=.25ex]{#1};
}

% Render author's name
% Usage: \user{<firstanme>}{<lastname>}
\newcommand\user[2]{\color{accentcolor}{\LARGE #1 \textsc{\textbf{#2}}}\color{Black}}

% Render a text with its symbol
% Usage; \socialtext{<icon>}{<label>}
\newcommand{\socialtext}[2]{\mbox{\textcolor{symbolcolor}{#1}\hspace{0.5em}#2\hspace{1em}}}

% Render a link with its symbol
% Usage; \sociallink{<icon>}{<label>}
\newcommand{\sociallink}[3]{\mbox{\textcolor{symbolcolor}{#1}\hspace{0.5em}\link{#2}{#3}\hspace{1em}}}

% Define author's name
% Usage: \name{<firstname>}{<lastname>}
\newcommand*{\name}[2]{\def\@firstname{#1}\def\@lastname{#2}}

% Define author's tagline
% Usage: \tagline{<tag line>}
\newcommand*{\tagline}[1]{\def\@tagline{#1}}

% Render author's address
% Usage: \address{<address>}
\newcommand*{\address}[1]{\socialtext{\locationSymbol}{#1}}

% Render author's linked-in
% Usage: \linkedin{<linked-in-nick>}
\newcommand*{\linkedin}[1]{\sociallink{\linkedinSymbol}{http://www.linkedin.com/in/#1}{linkedin.com/in/#1}}

% Render author's personal website
% Usage: \personalLink{<website-without-http://www.>}
\newcommand*{\personalLink}[1]{\sociallink{\linkSymbol}{http://www.#1}{#1}}

% Render author's github
% Usage: \github{<github-nick>}
\newcommand*{\github}[1]{\sociallink{\githubSymbol}{https://www.github.com/#1}{github.com/#1}}           % Github icon + URL

% Render author's email
% Usage: \email{<email adress>}
\newcommand*{\email}[1]{\sociallink{\mailSymbol}{mailto:#1}{#1}}

% Render a website link
% Usage: \email{<email adress>}
\newcommand*{\website}[2]{\sociallink{\faExternalLink}{#1}{#2}}

% Render author's mobile phone
% Usage: \smartphone{<mobile phone number>}
\newcommand*\smartphone[1]{\socialtext{\mobileSymbol}{#1}}    

% Render author's tagline
\newcommand\resumetitle[1]{\color{accentcolor}\textbf{\large{#1}}\color{black}}

% Define social entries to print in header
\newcommand{\socialinfo}[1]{\def\@socialinfo{#1}}

% Render CV header
\newcommand*{\makecvheader}{
  \begin{minipage}{\linewidth}
  \user{\@firstname}{\@lastname}\\
  \resumetitle{\@tagline}
  \smallskip\\
  \small{\@socialinfo}
  \end{minipage}
  {}
  \smallskip
}

% Define a footer for CV
% Usage: \makecvfooter{<left>}{<center>}{<right>}
\newcommand*{\makecvfooter}[3]{%
  \fancyfoot{}
  \fancyfoot[L]{#1}
  \fancyfoot[C]{#2}
  \fancyfoot[R]{#3}
}

% Resume part title definition
\newcommand\sectionTitle[1]{\section{\texorpdfstring{\color{accentcolor}\textsc{#1}}{#1}}}

% Define the 'experiences' environment
\newcolumntype{E}{>{\raggedright\arraybackslash}p{\rightcolumnlength}}

\newenvironment{experiences_env}{%
  \begin{longtable}{R{\leftcolumn}|E}
}{%
  \end{longtable}
}

% Render an experience in the experiences environment
% Usage: 
% \experience
%  {<End date>}      {<Company>}{<Role>}
%  {<Start date}     {
%                      <Experience description (Could be a list)>
%                    }
%                    {<Technology list>}
%                    (Below is optional)
%                    {
%                      <Notable Projects (Could be a list)>
%                    }
\newcommand\experienceWithProjects[7]{
  \textbf{#1}    & \textbf{\textsc{#2, }}\textsc{#3} 	                          \\*
  \textbf{#4}    & \begin{minipage}[t]{\rightcolumnlength}
  					         #5
                   \end{minipage}	\smallskip								                    \\*
                 & \footnotesize{\foreach \n in {#6}{\cvtag{\n}}} \bigskip  	  \\*
                 & \textbf{\textsc{Notable Projects:}}                          \\*
                 & \begin{minipage}[t]{\rightcolumnlength}
                     #7
                   \end{minipage}	          	                                  \\
}
\newcommand\experienceWithoutProjects[6]{
  \textbf{#1}    & \textbf{\textsc{#2, }}\textsc{#3} 	             \\*
  \textbf{#4}    & \begin{minipage}[t]{\rightcolumnlength}
  					         #5
                   \end{minipage}	\smallskip									     \\*
                 & \footnotesize{\foreach \n in {#6}{\cvtag{\n}}}  \\
}

\newcommand\emptySeparator{\multicolumn{2}{c}{}\\}

% Define the 'education' environment
\newenvironment{education_env}{%
  \begin{longtable}{l}
}{%
  \end{longtable}
}

% Define the 'education' entry in the 'education' environment
% Usage:
% \education
%   {<School Name>}{<dates>}
%   {<degree>}{GPA}
%   {<description>}
\newcommand\education[5]{
  \begin{minipage}[t]{\dimexpr(\linewidth) - 1.5em}
    \textbf{\textsc{#1, }}\textsc{#3, #4} \hfill \textsc{#2}\smallskip \\
    #5 \smallskip
  \end{minipage}
  \\*
}

\newcommand*\twocolumnsection[2]{
  \begin{minipage}[t]{\dimexpr(\linewidth/2) - 3em}
    #1
  \end{minipage}
  \hfill
  \begin{minipage}[t]{\dimexpr(\linewidth/2) - 3em}
    #2
  \end{minipage}
}
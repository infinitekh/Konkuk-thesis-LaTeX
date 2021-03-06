%%
%% 서울대 서식에서 시작합니다. 그쪽 것에 라이센스가 안달려있습니다. 
%% 이 문서의 라이센스는  해당파일을 참조해주시길.
%% 아직 미완성입니다. 최소한 제가 졸업하기 전에는 완성할 예정이고
%% 도와주시면 금방 완성되겠지요. 
%% @author	KIM, Hyeok mailto:ekh0324@gmail.com
%%
%% @requirements



\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{konkuk}
    [2007/2/27 v0.1 Standard konkuk Thesis document class]

%% 옵션 설정을 위한 boolean 변수선언
\newif\if@isDoctor
\newif\if@isKorean
\newif\if@isFinal
\newif\if@isScience

%% 새 옵션 모음 - doctor|master, korean|english, final|draft
\DeclareOption{doctor} {\@isDoctortrue}
\DeclareOption{master} {\@isDoctorfalse}
\DeclareOption{korean} {\@isKoreantrue}
\DeclareOption{english}{\@isKoreanfalse}
\DeclareOption{final}  {\@isFinaltrue}
\DeclareOption{draft}  {\@isFinalfalse}


%% leqno,fleqn,openbib 옵션은 그대로 report 클래스에 전달
\DeclareOption{leqno}  {\PassOptionsToClass{leqno}  {memoir}}
\DeclareOption{fleqn}  {\PassOptionsToClass{fleqn}  {memoir}}
\DeclareOption{openbib}{\PassOptionsToClass{openbib}{memoir}}

\ExecuteOptions{doctor,korean,final}         % doctor,korean,final이 기본값
\ProcessOptions

%% 10pt,a4paper,onecolumn,oneside 옵션으로 report 클래스 불러오기
\LoadClass[11pt,onecolumn,oneside]{memoir}

\RequirePackage{ifthen,graphicx,setspace,calc}       % 추가 패키지 설정

\AtBeginDocument{%                           % \begin{document}와 함께 실행
    \checkparameters                        % 문서 변수가 올바른지 점검
    \if@isFinal                             % final 옵션이 지정되어 있으면
        \makefrontcover \maketitle         % 앞표지, 속표지 생성
        \makeapproval                      % 제출승인서, 심사완료검인 생성
    \else \fi }
\AtEndDocument{}                             % \end{document}와 함께 실행

%% 출력용지 여백 설정 - A4출력 기준으로 4 x 6배판 재단 (잘 안 될 경우 PDF에서 종이크기를 4X6으로만 바꾸면 됨)
\setlength{\stockheight}    {257mm} %195로?
\setlength{\stockwidth}     {182mm}
\setlength{\paperheight}    {257mm} %195로?
\setlength{\paperwidth}     {182mm}

\setlength{\trimtop}   {0mm}
\setlength{\uppermargin}     {25mm}
\setlength{\headheight}    {0mm}
\setlength{\headsep}       {0mm}

\setlength{\trimedge}  {0mm}
\setlength{\leftmargin}     {25mm}
\setlength{\rightmargin}     {25mm}
\setlength{\oddsidemargin} {0mm}
\setlength{\textheight}    {207mm} %195로?
\setlength{\textwidth}     {132mm}
\setlength{\footskip}      {0mm}

%% 줄간격 설정 (References, Contents(그림, 표 목차 포함)는 줄간격이 모두 1.3으로 고정되어 있습니다.)
\renewcommand{\baselinestretch}{1.7}

%% 본문이 영어로 되어있는지 한글로 되어있는지 설정
\newcommand{\@korean}{korean}
\newcommand{\@english}{english}
\newcommand{\@textlang}{}                    % 텍스트 기본언어 변수선언
\if@isKorean                                 % korean 옵션이 지정되어 있으면
    \let\@textlang\@korean  
    \RequirePackage{kotex}
    % 텍스트 기본언어는 한글
\else                                        % english 옵션이 지정되어 있으면
    \let\@textlang\@english                 % 텍스트 기본언어는 영문
\fi

%% 건국대학교 공식 영문명칭
\newcommand{\@ku}{Konkuk University}

%%
%% 문서 정보 변수 정의
%%

% @command title 논문 제목
% @options [default: (none)]
% - korean: 한글제목 | english: 영문제목
\renewcommand{\title}[2][korean] {%
    \ifthenelse{\equal{#1}{korean}}%
        {\newcommand{\@titleKor}{#2}}{}%
    \ifthenelse{\equal{#1}{english}}%
        {\newcommand{\@titleEng}{#2}}{}%
    \ifthenelse{\equal{#1}{subtitle}}%
        {\newcommand{\@titleSub}{#2}}{}%
}
\@onlypreamble{\title}

% @command author 저자 이름
% @param family_name, given_name 성, 이름을 구분해서 입력
% 옛날 서식에는 한자가 필요했는데 이제 안 필요한지 
% 공식서식에는 없습니다. 석사과정만 한자가 필요한 것일 수도.
% @options [default: (none)]
% - korean: 한글이름 | chinese: 한문이름 | english: 영문이름
\renewcommand{\author}[4][korean] {%
    \ifthenelse{\equal{#1}{korean}}
        {\newcommand{\@authorKorFN}{#2}
         \newcommand{\@authorKorGN}{#3}       
         \newcommand{\@authorKorGNb}{#4}           
         \newcommand{\@authorKor}{#2\ #3\ #4}}{}%
    \ifthenelse{\equal{#1}{chinese}}
        {\newcommand{\@authorChnFN}{#2}
         \newcommand{\@authorChnGN}{#3}
         \newcommand{\@authorChnGNb}{#4}              
         \newcommand{\@authorChn}{#2\ #3\ #4}}{}%
    \ifthenelse{\equal{#1}{english}}
        {\newcommand{\@authorEngFN}{#2}
         \newcommand{\@authorEngGN}{#3}
         \newcommand{\@authorEngGNb}{#4}         
         \newcommand{\@authorEng}{#2, #3}}{}%
}
\@onlypreamble{\author}

% @command advisor 지도교수 이름 (복수가능)
% @options [default: major]
% - major: 주 지도교수  | coopr: 부 지도교수 (공동지도교수 경우)
\newcommand{\advisor}[5][major]{%
    \ifthenelse{\equal{#1}{major}} {%       % 주 지도교수이면
        \newcommand{\@advisorMajorKor}{#2} % 한글이름 저장
        \newcommand{\@advisorMajorEng}{#3} % 영문이름 저장
        \newcommand{\@advisorMajorChn}{#4} % 한자이름 저장
        % nosign을 명시하지 않으면 주 지도교수가 서명한 것으로 간주
        \ifthenelse{\equal{#5}{nosign}}{}{%
            \newcommand{\@advisorSigned}{\@advisorMajorEng}} }{}%
    \ifthenelse{\equal{#1}{coopr}} {%       % 부 지도교수이면
        \newcommand{\@advisorCooprKor}{#2} % 한글이름 저장
        \newcommand{\@advisorCooprEng}{#3} % 영문이름 저장
        \newcommand{\@advisorCooprChn}{#4} % 한자이름 저장
        % signed를 명시해야 부 지도교수가 서명한 것으로 간주
        \ifthenelse{\equal{#5}{signed}}{%
            \newcommand{\@advisorSigned}{\@advisorCooprEng}}{} }{}%
}
\@onlypreamble{\advisor}

% @command department 학과이름 - 아래 표에 따라 코드를 입력
%
% 컴퓨터공학        EECS
% 물리학   DP (Department of Physics) 한글자는 짧아서리.
% 각 단과대에 따라 추가할 수 있습니다.

\newcommand{\@degreeCode}{}          % 학위 영문코드
\newcommand{\@degreeName}{}          % 학위명
\newcommand{\@affFullNameKor}{}      % 학과/전공 한글이름
\newcommand{\@affFullNameEng}{}      % 학과/전공 영문이름
%\newcommand{\@affFullNameEngCover}{} % 학과/전공 영문이름(표지용)
\newcommand{\@deptNameKor}{}
\newcommand{\@deptNameEng}{}
\newcommand{\@divNameKor}{}
\newcommand{\@divNameEng}{}
\newcommand{\@progNameKor}{}
\newcommand{\@progNameEng}{}
\newcommand{\@degreeField}{}
\newcommand{\@degreePrefix}{\ifthenelse{\boolean{@isDoctor}}{D}{M}}
\newcommand{\department}[1] {%
    \ifthenelse{\equal{#1}{EECS}}
        {\renewcommand{\@degreeCode}{\@degreePrefix#1}%
         \renewcommand{\@deptNameKor}{전기 $\cdot$ 컴퓨터 공학}%電氣컴퓨터 工學
         \@isSciencefalse
         \renewcommand{\@deptNameEng}{Electrical Engineering and
                                Computer Science}%
                                
         %\renewcommand{\@divNameKor}{컴퓨터공학}%
         %\renewcommand{\@divNameEng}{Computer Science and Engineering}
         \renewcommand{\@degreeField}{science}} {}%
% 여기에 EECS처럼 추가하면 됩니다.
      \ifthenelse{\equal{#1}{DP}}
        {\renewcommand{\@degreeCode}{\@degreePrefix#1}%
         \renewcommand{\@deptNameKor}{물리학}%電氣컴퓨터 工學
         \@isSciencetrue     % 이학박사 
         \renewcommand{\@deptNameEng}{Department of Physics}%
         %\renewcommand{\@divNameKor}{컴퓨터공학}%
         %\renewcommand{\@divNameEng}{Computer Science and Engineering}
         \renewcommand{\@degreeField}{science}} {}%
	  
    \renewcommand{\@affFullNameKor}{%               % 학과/전공 한글이름
        \ifthenelse{\equal{\@deptNameKor}{}} {}{\@deptNameKor 부}%部
        \ifthenelse{\equal{\@divNameKor}{}} {}{ \@divNameKor 과}%科
        \ifthenelse{\equal{\@progNameKor}{}} {}{\@progNameKor 전공}%專攻
    }
    \renewcommand{\@affFullNameEng}{%               % 학과/전공 영문이름
        \ifthenelse{\equal{\@deptNameEng}{}}
            {\ifthenelse{\equal{\@divNameEng}{}}
                {}{Division of \@divNameEng}}%   % 전공(division)명
            {School of \@deptNameEng          % 학부명
             \ifthenelse{\equal{\@divNameEng}{}}
                {}{,\ Division of \@divNameEng}} % 학과명 + 전공(division)명
        \ifthenelse{\equal{\@progNameEng}{}}
            {}{\@progNameEng\ Program}%           % 전공(program)명
    }
%    \renewcommand{\@affFullNameEngCover}{%          % 학과/전공 영문이름
%        \ifthenelse{\equal{\@deptNameEng}{}}       % (표지인쇄용)
%            {\ifthenelse{\equal{\@divNameEng}{}}
%                {}{Division of \@divNameEng}}%
%            {Department of \@deptNameEng
%             \ifthenelse{\equal{\@divNameEng}{}}
%                {}{%
%                Division of \@divNameEng} }
%        \ifthenelse{\equal{\@progNameEng}{}}
%            {}{\@progNameEng\ Program}%
%    }
    \renewcommand{\@degreeName}{%                       % 학위 영문이름
        \ifthenelse{\boolean{@isDoctor}}
            {Doctor of Philosophy} {%                 % 박사는 모두 Ph.D.
            \ifthenelse{\equal{\@degreeField}{science}}
                {Master of Science}{}%               % 이학석사는 M.S.
            \ifthenelse{\equal{\@degreeField}{engineering}}
                {Master of Engineering}{}%           % 공학석사는 M.E.
            \ifthenelse{\equal{\@degreeField}{business}}
                {Master of Business Administration}{}% 경영학석사는 M.B.A.
        }
    }
}
\@onlypreamble{\department}

% @command studentid 학번
\newcommand{\studentid}[1]{\newcommand{\@studentID}{#1}}
\@onlypreamble{\studentid}

% @command referee 심사위원 (석사과정 3인, 박사과정 5인)
% ... 직접 이름을 쓰시면 되는데... 이거 귀찮은 작업임.
% 왜 ____이것 때문에.
\newcommand{\referee}[2][1] {%
    \ifthenelse{\equal{#1}{1}}{\newcommand{\@refereeChief} {#2}} {}%
    \ifthenelse{\equal{#1}{2}}{\newcommand{\@refereeSecond}{#2}} {}%
    \ifthenelse{\equal{#1}{3}}{\newcommand{\@refereeThird} {#2}} {}%
    \ifthenelse{\equal{#1}{4}}{\newcommand{\@refereeFourth}{#2}} {}%
    \ifthenelse{\equal{#1}{5}}{\newcommand{\@refereeFifth} {#2}} {}%
}
\@onlypreamble{\referee}

% @command approvaldate 지도교수논문승인일
% @param year,month,day 연,월 순으로 입력
\newcommand{\approvaldate}[2] {%
    \newcommand{\@approvalYear}{#1}
    \newcommand{\@approvalMonth}{#2}
}
\@onlypreamble{\approvaldate}

% @command refereedate 심사위원논문심사일
% @param year,month,day 연,월 순으로 입력
\newcommand{\refereedate}[2] {%
    \newcommand{\@refereeYear}{#1}
    \newcommand{\@refereeMonth}{#2}
}
\@onlypreamble{\refereedate}

% @command gradyear 졸업년도
\newcommand{\gradyear}[2]{
    \newcommand{\@gradYear}{#1}
    \newcommand{\@gradMonth}{#2}
}
\@onlypreamble{\gradyear}

% @command keywords 키워드
\newcommand{\keywords}[1]{
    \newcommand{\@keywords}{#1}
}
\@onlypreamble{\keywords}

%%
%% 필요한 정보 중에 누락된 것이 없는지 점검 --> 제작중. 아직 불완전.
%%
\newcommand{\checkparameters}{%
    \@ifundefined{@titleKor}{%
        \ClassError{konkuk}{The korean title is not found}{}}{}
    \@ifundefined{@titleEng}{%
        \ClassError{ku}{The english title is not found}{}}{}
    \@ifundefined{@authorKor}{%
        \ClassError{ku}{The korean name of the author is not found}{}}{}
    \@ifundefined{@authorChn}{%
        \ClassError{ku}{The chinese name of the author is not found}{}}{}
    \@ifundefined{@authorEng}{%
        \ClassError{ku}{The english name of the author is not found}{}}{}
    \@ifundefined{@advisorMajorKor}{%
        \ClassError{ku}{The korean name of the major advisor is not found}{}}{}
    \@ifundefined{@advisorMajorEng}{%
        \ClassError{ku}{The english name of the major advisor is not found}{}}{}
}

%%
%% 앞표지 생성
%% 학교 규칙과 다른데 실제 선배들 졸업논문이 학교 규칙과 달라 
%% 실제 졸업 논문의 양식을 따랐음. 영문 논문인 경우만 영문 제목이 국문 제목 아래에 추가됨.
%%
% %  \Large\textbf{\texttt{博士學位 請求論文\\
% %  指導敎授 여 교 수 }}


\newcommand{\makefrontcover}{%
% 
\renewcommand{\baselinestretch}{1.3}%
    \thispagestyle{empty} \noindent%
    \begin{minipage}[t][3cm][t]{\textwidth}
        \begin{flushleft}
            \Large \bfseries \ttfamily
              \if@isDoctor
            \if@isScience
		이학박사 청구논문 %工學博士學位論文 %공대 외에서 쓰려면 수정해야함.
            \else
		공학박사 청구논문 %工學博士學位論文 %공대 외에서 쓰려면 수정해야함.
            \fi
            \else
            \if@isScience
		이학석사 청구논문 %工學博士學位論文 %공대 외에서 쓰려면 수정해야함.
            \else
		공학석사 청구논문 %工學博士學位論文 %공대 외에서 쓰려면 수정해야함.
            \fi
            \fi
            \\ 지도교수 \makebox[\widthof{청구논문}]{\@advisorMajorKor}
        \end{flushleft}
    \end{minipage}\\[0mm]
    \begin{minipage}[t][10cm][t]{\textwidth}
        \begin{center}
            \HUGE  \@titleKor 
            \if@isKorean {}
            \else
            { \\[10pt] \Large \@titleEng}            
            \fi
        \end{center}
    \end{minipage}\\[0mm]
    \begin{minipage}[t][4.5cm][t]{\textwidth}
        \begin{center}
            \Large \@gradYear 년 \@gradMonth 월
        \end{center}
    \end{minipage}
    \begin{minipage}[t][2cm][b]{\textwidth}
        \begin{center}
              {\LARGE건국대학교 대학원}\\ 
         
              {\Large\@affFullNameKor} \\
%            \@authorChnFN\ \ \ \@authorChnGN\ \ \ \@authorChnGNb %한자 표기 원하면 이걸로
             {\LARGE \@authorKorFN\ \ \ \@authorKorGN\ \ \ \@authorKorGNb}            
        \end{center}
    \end{minipage}\\[0mm]
    \newpage
}

%%
%% 속표지 생성 
%%
\renewcommand{\maketitle}{%
    \renewcommand{\baselinestretch}{1.3}%
    \thispagestyle{empty} \noindent%
    \begin{minipage}[t][3cm][t]{\textwidth}
        \begin{flushleft}
            \Large  \ttfamily
              \if@isDoctor
            \if@isScience
		이학박사 청구논문 %工學博士學位論文 %공대 외에서 쓰려면 수정해야함.
            \else
		공학박사 청구논문 %工學博士學位論文 %공대 외에서 쓰려면 수정해야함.
            \fi
            \else
            \if@isScience
		이학석사 청구논문 %工學博士學位論文 %공대 외에서 쓰려면 수정해야함.
            \else
		공학석사 청구논문 %工學博士學位論文 %공대 외에서 쓰려면 수정해야함.
            \fi
            \fi
            \\ 지도교수 \makebox[\widthof{청구논문}]{\@advisorMajorKor}
        \end{flushleft}
    \end{minipage}\vfill
    \begin{minipage}[t][6cm][t]{\textwidth}
        \begin{center}
            \HUGE  \@titleKor 
            \if@isKorean {}
            \else
            { \\[10pt] \Large \@titleEng}            
            \fi
        \end{center}
    \end{minipage}\\[0mm]
    \begin{minipage}[t][2.5cm][t]{\textwidth}
        \begin{center}
            \Large \@gradYear 년 \@gradMonth 월
        \end{center}
    \end{minipage}
    \begin{minipage}[t][2cm][b]{\textwidth}
        \begin{center}
              {\LARGE건국대학교 대학원}\\ 
              {\Large\@affFullNameKor} \\
%            \@authorChnFN\ \ \ \@authorChnGN\ \ \ \@authorChnGNb %한자 표기 원하면 이걸로
             {\LARGE \@authorKorFN\ \ \ \@authorKorGN\ \ \ \@authorKorGNb}            
        \end{center}
    \end{minipage}\\[0mm]
    \newpage
}

%%
%% 제출지 인준지
%%
\newcommand{\makeapproval}{%
    \thispagestyle{empty} \noindent
    \begin{minipage}[t][9cm][t]{\textwidth}
    \begin{center}
        \Huge \@titleKor           % 학위논문 한글제목
    \\
        \Large \@titleEng           % 학위논문 한글제목
    \end{center}
    \end{minipage}
    \vspace*{10mm}   
    \begin{minipage}[t][6cm][t]{\textwidth}
      \begin{center}
        \Large 
%        이 論文을 工學\ifthenelse{\boolean{@isDoctor}}{搏士}{碩士}\ 學位論文으로 提出함\\ %공대 외에서 쓰려면 수정해야함.
        이 논문을 \ifthenelse{\boolean{@isScience}}{이학}{공학}\ifthenelse{\boolean{@isDoctor}}{박사}{석사}\  청구논문으로 제출합니다\\ \vfill  %공대 외에서 쓰려면 수정해야함.        
        \@approvalYear 년 \@approvalMonth 월\\
       
      \end{center}
    \end{minipage}
    \vfill
   
      \begin{center}
%        서울大學校 大學院 \\
        {\LARGE건국대학교 대학원} \\        
        {\Large\@affFullNameKor} \\
        %\@authorChnFN\ \ \ \@authorChnGN\ \ \ \@authorChnGNb\\
        {\LARGE\@authorKorFN\ \ \ \@authorKorGN\ \ \ \@authorKorGNb}\\
      \end{center}
   
    \newpage
    \LARGE \@authorKorFN \@authorKorGN \@authorKorGNb의 \ifthenelse{\boolean{@isScience}}{이학}{공학}\ifthenelse{\boolean{@isDoctor}}{박사}{석사}\ 청구논문을 인준함\\ %공대 외에서 쓰려면 수정해야함.
        \\[3cm]
    \begin{minipage}[t][7cm][b]{\textwidth}
    \begin{center}    
            %委 員 長
            {심사위원장\underline{ \makebox[\widthof{안녕하세요 반갑습니다. }][r]{(印)}}} 
            \vfill
            {심사위원\underline{ \makebox[\widthof{장안녕하세요 반갑습니다. }][r]{(印)}}}
            \vfill
            {심사위원\underline{ \makebox[\widthof{장안녕하세요 반갑습니다. }][r]{(印)}}}
            \vfill
            {심사위원\underline{ \makebox[\widthof{장안녕하세요 반갑습니다. }][r]{(印)}}}
            \vfill
            {심사위원\underline{ \makebox[\widthof{장안녕하세요 반갑습니다. }][r]{(印)}}}
            
        \end{center} 
    \end{minipage}
    \vfill
    \begin{minipage}[t][2.0cm][t]{\textwidth}
        \begin{center}
            \Large \@gradYear 년 \@gradMonth 월
        \end{center}
    \end{minipage}
    \begin{minipage}[t][2cm][t]{\textwidth}
        \begin{center}
            \LARGE 건국대학교 대학원\\ %大學校 大學院 
        \end{center}
    \end{minipage}\\[0mm]
    \newpage
}

%%
%% 초록(abstract)페이지 생성
%%
\newcounter{pagemarker}                           % 페이지 번호 임시 저장용
\newcommand{\@lastPage}{\pageref{paperlastpagelabel}} % 총 페이지 수 계산용
\renewenvironment{abstract}{%
    \pagenumbering{roman}                        % 로마자 페이지 시작
    \pagestyle{plain}%
    \newcommand{\@tempbreak}{}                   % \linebreak 명령 보관용
    \let\@tempbreak\linebreak
    \renewcommand{\linebreak}{\ }                % \linebreak -> 공백 대체
    \begin{center}
        \textbf{\LARGE\abstractname}\\ % 초록명 -> Abstract
    \end{center}
    %여기에 초록이 들어옴.
    \addcontentsline{toc}{chapter}{\abstractname}% 초록을 목차(TOC)에 삽입
}{  \setcounter{pagemarker}{\value{page}}        % 마지막 페이지 번호를 저장
    \vspace*{10mm}
    \\ \textbf{Keywords}:\ \@keywords
    \\
    \\ \textbf{Student Number}:\ \@studentID
    \addtocounter{pagemarker}{1}                 % 백색별지분을 고려
    \newpage \pagenumbering{arabic}              % 페이지 아라비아 숫자 포맷
    \let\linebreak\@tempbreak                    % \linebreak 명령 복원
}

%%
%% 목차 일괄 생성
%% 이거 서식작업 학교도서관에서 빠꾸나와서 잘해야함. 
\newcommand{\makecontents}{%            % TOC, LOT, LOF 생성
    \tableofcontents
    \listoftables
    \listoffigures
}

%%
%% 뒷부분의 요약문 생성 
%% - 영어 논문이면 한글 요약이, 한글 논문이면 영어 요약이 오면 된다.
%%
%% 만약 이를 목차에 넣고 싶지 않다면 아래 주석 표시된 것을 사용하면 된다.
%% 물론, 이 때는 \abstracb로 해야 한다. (\begin{abstracb}가 아님!)
%%
\newenvironment{abstractb}{%              % 뒷부분 요약문 생성 환경
    \newcommand{\@tempbreak}{}
    \let\@tempbreak\linebreak
    \renewcommand{\linebreak}{\ }      % \linebreak 명령 바꿔치기
    \if@isKorean
       \chapter*{Abstract}
       \addcontentsline{toc}{chapter}{Abstract} 
    \else
        \chapter*{초\ \ \ \ 록} 
       \addcontentsline{toc}{chapter}{국문 초록} %목차에 추가하는 부분
    \fi
}{  \let\linebreak\@tempbreak          % \linebreak 명령 되돌리기
}
%\newcommand{\abstractb}{%                 % 목차에 추가 안 시키고자 할 때의 뒷부분 요약문 형식
%    \chapter*{Abstract}
%    \pagestyle{empty}
%}

%%
%% 감사의 글 생성
%% 이런것은 그냥 본인이 직접 작성하면 ... 어차피 이부분은 서식위반이라... 
\newcommand{\acknowledgement}{%                 % 감사의 글
    \chapter*{감 사 의\ \ 글}
    \pagestyle{empty}
}

%%
%% 이력서 생성
%%
\newcommand{\curriculumvitae}[1][default]{%     % 이력서
    \newcommand{\@ccvlang}{#1}
    \ifthenelse{\equal{#1}{default}}            % 아무 옵션을 설정하지 않으면
        {\let\@ccvlang\@textlang}{}           % 논문 언어대로 이력서 언어설정
    \ifthenelse{\equal{\@ccvlang}{\@korean}}
        {\chapter*{이 력 서}}                 % korean  옵션일 경우
        {\chapter*{Curriculum Vit\ae}}         % english 옵션일 경우
    \pagestyle{empty}
}

%%
%% 이력서 내부 요소 생성
%%
    \newenvironment{personaldata}{%            % 개인정보
        \begin{list}{}{%
            \setlength{\labelwidth}{70pt}
            \setlength{\leftmargin}{\labelwidth}
            \addtolength{\leftmargin}{\labelsep}
            \setlength{\parsep}{0pt}
            \renewcommand{\makelabel}[1]{\textgt{##1\ \ :\ }}}
        \newcommand{\name}[1]{%               % 이름
            \ifx\@ccvlang\@korean
                \def\@arg{[이\hfill름]}
            \else
                \def\@arg{[Name\hfill]}
            \fi
            \expandafter\item\@arg ##1}
        \newcommand{\dateofbirth}[3]{%        % 생년월일
            \ifx\@ccvlang\@korean
                \def\@arg{[생\hfill년\hfill월\hfill일]}
                \expandafter\item\@arg ##1년 ##2월 ##3일
            \else
                \def\@arg{[Date of Birth\hfill]}
                \expandafter\item\@arg \@dateUSenglish{##1}{##2}{##3}
            \fi}
        \newcommand{\birthplace}[1]{%         % 출생지
            \ifx\@ccvlang\@korean
                \def\@arg{[출\hfill생\hfill지]}
            \else
                \def\@arg{[Birthplace\hfill]}
            \fi
            \expandafter\item\@arg ##1}
        \newcommand{\domicile}[1]{%           % 본적지
            \ifx\@ccvlang\@korean
                \def\@arg{[본\hfill적\hfill지]}
            \else
                \def\@arg{[Domicile\hfill]}
            \fi
            \expandafter\item\@arg ##1}
        \newcommand{\address}[1]{%            % 주소지
            \ifx\@ccvlang\@korean
                \def\@arg{[주\hfill소]}
            \else
                \def\@arg{[Address\hfill]}
            \fi
            \expandafter\item\@arg ##1}
        \newcommand{\email}[1]{%              % E-mail
            \ifx\@ccvlang\@korean
                \def\@arg{[E-mail\hfill주\hfill소]}
            \else
                \def\@arg{[E-mail\hfill]}
            \fi
            \expandafter\item\@arg ##1}
        % 이력서에 집어넣을 추가 필드가 필요하면 위를 참고하여 만들어 쓸 것.
        % \newcommand{(필드명령)}[1]{%
        %   \ifx\@ccvlang\@korean
        %       \def\@arg{[(한글필드명)]}
        %   \else
        %       \def\@arg{[(영문필드명)]}
        %   \fi
        %   \expandafter\item\@arg ##1}
    }{\end{list}}

    \newenvironment{education}{%               % 학력
        \vspace*{5mm} \noindent
        \ifx\@ccvlang\@korean
            \begin{center}
                \makebox[2cm][s]{\textbf{\large 학 력}}
            \end{center}
        \else \textbf{\large Educations} \fi
        \begin{list}{}{%
            \setlength{\labelwidth}{90pt}
            \setlength{\leftmargin}{\labelwidth}
            \addtolength{\leftmargin}{\labelsep}
            \setlength{\parsep}{0pt}
            \renewcommand{\makelabel}[1]{\textgt{##1\hfill\ }}}
    }{\end{list}}

    \newenvironment{career}{%                  % 경력
        \vspace*{5mm} \noindent
        \ifx\@ccvlang\@korean
            \begin{center}
                \makebox[2cm][s]{\textbf{\large 경 력}}
            \end{center}
        \else \textbf{\large Career} \fi
        \begin{list}{}{%
            \setlength{\labelwidth}{90pt}
            \setlength{\leftmargin}{\labelwidth}
            \addtolength{\leftmargin}{\labelsep}
            \setlength{\parsep}{\z@}
            \renewcommand{\makelabel}[1]{\textgt{##1\hfill\ }}}
    }{\end{list}}

    \newcounter{itemnum1}
    \newenvironment{activity}{%                % 학회활동
        \vspace*{5mm} \noindent
        \ifx\@ccvlang\@korean
            \begin{center}
                \makebox[2cm][s]{\textbf{\large 학 회 활 동}}
            \end{center}
        \else \textbf{\large Academic Activities} \fi
        \begin{list}{}{%
            \usecounter{itemnum1}
            \setlength{\labelwidth}{1.5em}
            \setlength{\leftmargin}{\labelwidth}
            \addtolength{\leftmargin}{\labelsep}
            \setlength{\parsep}{\z@}
            \renewcommand{\makelabel}{\textgt{\arabic{itemnum1}.\ }}}
    }{\end{list}}

    \newcounter{itemnum2}
    \newenvironment{publication}{%             % 연구업적
        \vspace*{5mm} \noindent
        \ifx\@ccvlang\@korean
            \begin{center}
                \makebox[2cm][s]{\textbf{\large 연 구 업 적}}
            \end{center}
        \else \textbf{\large Publications} \fi
        \begin{list}{}{%
            \usecounter{itemnum2}
            \setlength{\labelwidth}{1.5em}
            \setlength{\leftmargin}{\labelwidth}
            \addtolength{\leftmargin}{\labelsep}
            \setlength{\parsep}{\z@}
            \renewcommand{\makelabel}{\textgt{\arabic{itemnum2}.\ }}}
    }{\end{list}}

%%
%% 헤딩 재설정
%%
\renewcommand{\contentsname}{%
    \if@isKorean 목 차       \else Contents        \fi}
\renewcommand{\listfigurename}{%
    \if@isKorean 그 림 목 차 \else List of Figures \fi}
\renewcommand{\listtablename}{%
    \if@isKorean 표 목 차    \else List of Tables  \fi}
\renewcommand{\bibname}{%
    \if@isKorean 참 고 문 헌 \else References      \fi}

%%
%% \part 재정의 - 아예 쓰지 못하게 막아버림. 이 명령을 호출하면 에러 발생.
%%
\renewcommand\part{%
    \secdef\@part\@spart}
\def\@part[#1]#2{%
    \ClassError{ku}{The use of \protect\part\space is prohibited.
        \MessageBreak Consider the use of \protect\chapter\space instead}{}
}
\def\@spart#1{%
    \ClassError{ku}{The use of \protect\part\space is prohibited.
        \MessageBreak Consider the use of \protect\chapter\space instead}{}
}

%%
%% \chapter 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\renewcommand\chapter{%
    \if@openright\cleardoublepage\else\clearpage\fi
%   \thispagestyle{plain}%
    \global\@topnum\z@
    \@afterindentfalse
%   \if@isKorean \parindent\z@ \else \fi % <-- 추가할지 여부 고민중
    \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{%
    \ifnum \c@secnumdepth >\m@ne
        \refstepcounter{chapter}%
        \typeout{\@chapapp\space\thechapter.}%
        \addcontentsline{toc}{chapter}{%
            \if@isKorean
                \protect\numberline{제 \thechapter\ 장}#1
            \else
                \protect\numberline{\thechapter}#1
            \fi
        }% <-- 목차에 나타나는 형식 - 변경사항
    \else
        \addcontentsline{toc}{chapter}{#1}%
    \fi
    \chaptermark{#1}%
    \addtocontents{lof}{\protect\addvspace{10\p@}}%
    \addtocontents{lot}{\protect\addvspace{10\p@}}%
    \if@twocolumn
        \@topnewpage[\@makechapterhead{#2}]%
    \else
        \@makechapterhead{#2}%
        \@afterheading%
    \fi
}
\def\@makechapterhead#1{% <-- 전체 변경
    \vspace*{10\p@}
    {\centering \parindent\z@ \LARGE\bfseries
    \ifthenelse{\equal{\@textlang}{korean}}
        {제\hspace{1.4ex}\thechapter\hspace{1.4ex}장\hspace{2ex}}
        {\thechapter.\hspace{1ex}}
    #1\par}
    \vspace*{20\p@}
}
\def\@schapter#1{%
    \if@twocolumn
        \@topnewpage[\@makeschapterhead{#1}]%
    \else
        \@makeschapterhead{#1}%
        \@afterheading
    \fi}
\def\@makeschapterhead#1{% <-- 전체 변경
    \vspace*{10\p@}
    {\centering \parindent\z@ \LARGE\bfseries #1\par}
    \vspace*{20\p@}
}

%%
%% \tableofcontents 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\renewcommand\tableofcontents{%
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\contentsname
        \@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
    \begin{spacing}{1.3} % 목차의 줄간격은 늘 1.3으로 유지
    \pagenumbering{roman}                         % roman 페이지번호로 복원
    \setcounter{page}{\value{pagemarker}}         % pagemarker에 저장된 값으로
    \addcontentsline{toc}{chapter}{\contentsname} % 목차(TOC)에 추가
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    \newpage \setcounter{pagemarker}{\value{page}}% pagemarker에 다시 저장
    \pagenumbering{arabic}                        % arabic 페이지번호로 재시작
    \end{spacing}
}

%%
%% \listoftables 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\renewcommand\listoftables{%
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\listtablename}%
    \@mkboth{\MakeUppercase\listtablename}{\MakeUppercase\listtablename}%
    \begin{spacing}{1.3} % 목차의 줄간격은 늘 1.3으로 유지    
    \pagenumbering{roman}                         % roman 페이지번호로 복원
    \setcounter{page}{\value{pagemarker}}         % pagemarker에 저장된 값으로
    \addcontentsline{toc}{chapter}{\listtablename}% 목차(TOC)에 추가
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    \newpage \setcounter{pagemarker}{\value{page}}% pagemarker에 다시 저장
    \pagenumbering{arabic}                        % arabic 페이지번호로 재시작
    \end{spacing} 
}

%%
%% \listoffigures 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\renewcommand\listoffigures{%
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\listfigurename}%
    \@mkboth{\MakeUppercase\listfigurename}{\MakeUppercase\listfigurename}%
    \begin{spacing}{1.3} % 목차의 줄간격은 늘 1.3으로 유지    
    \pagenumbering{roman}                         % roman 페이지번호로 복원
    \setcounter{page}{\value{pagemarker}}         % pagemarker에 저장된 값으로
    \addcontentsline{toc}{chapter}{\listfigurename}% 목차(TOC)에 추가
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    \newpage \setcounter{pagemarker}{\value{page}}% pagemarker에 다시 저장
    \pagenumbering{arabic}                        % arabic 페이지번호로 재시작
    \end{spacing}
}

%%
%% 목차에 나오는 형식 - report 클래스로부터 복사하여 일부 수정
%%
\renewcommand*\l@chapter[2]{%
    \ifnum \c@tocdepth >\m@ne
        \addpenalty{-\@highpenalty}%
        \vskip 1.0em \@plus\p@
        \if@isKorean                     % <-- 변경 부분
            \setlength\@tempdima{5.0em} % korean  옵션일 때는 5.0em
        \else
            \setlength\@tempdima{1.5em} % english 옵션일 때는 1.5em
        \fi
        \begingroup
            \parindent \z@ \rightskip \@pnumwidth
            \parfillskip -\@pnumwidth
            \leavevmode \large \sffamily \bfseries
            \advance\leftskip\@tempdima
            \hskip -\leftskip
            #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
            \penalty\@highpenalty
        \endgroup
    \fi}

\if@isKorean % 한글이면 각종 치수를 변경
    \renewcommand*\l@section{\@dottedtocline{1}{2.7em}{2.3em}}
    \renewcommand*\l@subsection{\@dottedtocline{2}{5.0em}{3.2em}}
    \renewcommand*\l@subsubsection{\@dottedtocline{3}{8.2em}{4.1em}}
    \renewcommand*\l@paragraph{\@dottedtocline{4}{11.2em}{5em}}
    \renewcommand*\l@subparagraph{\@dottedtocline{5}{13.2em}{6em}}
\else \fi     % 영문이면 가만히 내버려둠

%%
%% thebibliography 환경 재정의 - report 클래스로부터 복사하여 일부 수정
%%

\renewenvironment{thebibliography}[1]{%
    \chapter*{\bibname}%
    \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
    \addcontentsline{toc}{chapter}{\bibname}%
\begin{spacing}{1.3}  %  Referece부분은 줄 간격을 1.3으로 유지합니다.
    \list{
    \@biblabel{\@arabic\c@enumiv}}%
        {\settowidth\labelwidth{\@biblabel{#1}}%
         \leftmargin\labelwidth
         \advance\leftmargin\labelsep
         \@openbib@code
         \usecounter{enumiv}%
         \let\p@enumiv\@empty
         \renewcommand\theenumiv{\@arabic\c@enumiv}}%
    \sloppy
    \clubpenalty4000
    \@clubpenalty \clubpenalty
    \widowpenalty4000%
    \sfcode`\.\@m%
}{  \label{paperlastpagelabel}     % <-- 추가 부분: 마지막 페이지 위치 지정
    \def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
    \endlist
\end{spacing}%

}

%%
%% 한국식 날짜 표기 -> 영문식 날짜 표기
%%
\newcommand{\@dateUSenglish}[3]{%  % 미국식 날짜 표기
    \newcommand{\@year}{#1}%
    \newcommand{\@month}{#2}%
    \newcommand{\@day}{#3}%
    \ifcase\@month \or
        January \or February \or March \or April \or May \or June \or
        July \or August \or September \or October \or November \or December \fi
    \@day, \@year
}
\newcommand{\@dateBRenglish}[3]{%  % 영국식 날짜 표기
    \newcommand{\@year}{#1}%
    \newcommand{\@month}{#2}%
    \newcommand{\@day}{#3}%
    \@day\ifcase\@day \or
        st\or nd\or rd\or th\or th\or th\or th\or th\or th\or th\or
        st\or nd\or rd\or th\or th\or th\or th\or th\or th\or th\or
        st\or nd\or rd\or th\or th\or th\or th\or th\or th\or th\or th\fi
    \space\ifcase\@month \or
        January\or February\or March\or April\or May\or June\or
        July\or August\or September\or October\or November\or December\fi,
    \@year
}

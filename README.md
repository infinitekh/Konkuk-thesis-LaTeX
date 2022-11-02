# Konkuk-thesis-LaTeX
건국대학교의 LaTeX 서식파일을 만들자는 목적으로 시작합니다. 이 양식은 카이스트 자료를 기반으로 만들어 졌으며, 서울대 양식도 참조를 하였습니다. 그러다 보니 수많은 짬뽕이 여기저기에 도사리고 있습니다.  

이 작업을 하면서 가장 문제가 되었던 부분은 class 파일에 대한 [note]부분이 카이스트 기반으로 글자만 고쳤음에도 불구하고, 알 수 없는 에러가 나왔습니다. 참으로 오랜 기간이 지나고, 그 부분을 날리게 되어 참으로 다행입니다. 

건국대학교 졸업논문 양식은 22pt 18pt 16pt 14pt 13pt 11pt의 크기의 글꼴 크기가 필요합니다. 일단은 비슷한 크기로 제가 셋팅을 해놓았지만, 학교에서 반려가 들어온다면, xelatex로 새로 작업을 하기를 권합니다. 

type1폰트 제작경험이  생긴다면, 학교에서 지정한 폰트를 내장하도록 하겠습니다. 학교 양식을 보면, 장평과 자간에 대한 지정도 있습니다. 그런 부분을 고려하면서 만들어야 하는데, type1 폰트 제작방법에 대해서 저는 문외한입니다. 
## konkukthesis.cls (이거만쓰세요)
이 패키지는 oblivoir 기반입니다. cls 파일 내에 잘모르는 부분이 있어 수정을 하신다면, 
- texdoc oblivoir
- texdoc memoir 
두 명령을 참조하시길 바랍니다. 
물리학과 화학과만 표지만드는 부분 작성되어 있습니다. 
자기학과 부분을 기여하고 싶으시면 수정해서, github을 통해서 넣으시던가, 아니면 댓글(?)로 남기시길 바랍니다. 

## tutorial_konkuk.tex
위 파일을 참조하셔서, 작성하시면 되고, 인준지, 속제목표지 등은 제가 2013년도에 미리 만들어둔 부분입니다. 2019년도에는 변화한 부분들이 있을 수 있으므로 수정 사항을 보내주시면 좋겠습니다. 

## Abstract 작성법. 
계열에 따라  영문초록의 위치가 다릅니다. 
따라서 조금 복잡해 졌습니다. 
첫번째 초록은 document 환경 바로 뒤에다가 작성 합니다. 
물리학과의 경우, 
\begin{abstractEng}
영문초록 내용을 작성한다 
\end{abstractEng}

그 다음 부터 내용물을 입력합니다. 여기서 부터 frontmatter와 구분하기 위해 \mainmatter 밑 여러가지 설정이 들어갔으므로 간단하게 \main이라는 것을 만들었습니다. 그냥 c 코딩한다고생각하시면.. 여기부터 메인입니다. 

열심히 작성하시고, 글을 마치시고 
\begin{abstractKor}
국문초록 내용을 입력 
\end{abstractKor}
를 하시면 됩니다. 

  도서관 홈페이지에서나오는 자료상, 국문초록이 앞 영문초록이 뒤입니다.  이거 어쩌라는건지


이 후로 부록 등을 입력할 텐데 이 부분은 완성이 안되었습니다. 원하는 스타일이 있다면 직접 찾아서 사용해야 할 것으로 보입니다. 

<%@page import="service.ProductService"%>
<%@page import="vo.MemberVO"%>
<%@page import="java.util.List"%>
<%@page import="dao.MemberDAO"%>
<link rel = "stylesheet" href = "css/bootstrap.css">
<link rel = "stylesheet" href = "css/custom.css">
<link rel = "stylesheet" href = "css/jck_nav.css">
<link rel="stylesheet" href="css/JWJ_MyPage.css">

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
       String ctx = request.getContextPath();
       String ctxPath = request.getContextPath();
    %>
<!DOCTYPE html>
<html>
<head>
   <%
      String userID = null;
      if(session.getAttribute("userID") != null){
         userID = (String) session.getAttribute("userID");
      }
   %>
   
   <meta name="msapplication-TileColor" content="#da532c">
   <meta name="theme-color" content="#ffffff">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src = "./js/jquery-3.5.1.js" type = "text/javascript"></script>
   <script src = "js/bootstrap.js"></script>
    <title>감자 마켓</title>
   
   
   <script type="text/javascript">
      function getUnread(){
         $.ajax({
            type:"POST",
            url : "./ChatUnreadServlet",
            data : {
               userID : '<%=userID%>'
            },
            success : function(result){
               if(result >= 1){
                  showUnread(result);
               }else{
                  showUnread('');
               }
            }
         });
      }
      
      function getInfiniteUnread(){
         setInterval(function(){
            getUnread();
         }, 10000);
      }
      
      function showUnread(result){
         $('#unread').html(result);
      }
      
      
      $(function() {
         $("#m_like").click(function() {
            $("#likemembercheck").css("display", "block");
         });
         $("#clear").click(function() {
            $("#likemembercheck").css("display", "none");
         });
      });
   </script>
   <style>
   #likemembercheck {
      display: none;
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translateY(-50%);
      transform: translateX(-50%);
      width: 300px;
      height: 100px;
      border: 1px solid black;
      background: white;
      top: 50%;
      padding: 30px 30px 30px 30px;
   }
   </style>
</head>
<body>
    <div class = "jck_everything">
        <div class = "jck_menu_container">
            <div class = "jck_menu_item jck_menu_item1">
                <button class = "jck_menu1_item jck_menu1_item1" id="jck_myBtn"><img src = "./images/menu.png"></button>
                <button class = "jck_menu1_item jck_menu1_item2" id = "jck_mainpage_btn1">
                    <a href="ProductMainPageGetCountCtl.do"><img src = "./images/logo_img.png"></a>
                </button>
            </div>
            <div class = "jck_menu_item jck_menu_item2">
                   <select name ="SearchFilter" id = "SearchFilter" class = "menu jck_display_none jck_menu_input jck_menu2_item1">
                       <option value = "0">필터</option>
                       <option value = "1">상품명</option>
                       <option value = "2">지역명</option>
                   </select>
                   <input id = "SearchStr" name = "SearchStr" value = "${SearchStr}" class = "jck_display_none jck_menu_input jck_menu2_item2" type = "text" placeholder = "검색어를 입력해주세요.">
                   <button id = "SearchButton" type = "Button" class = "jck_menu2_item3"><img src = "./images/search.png"></button>
                <a href = "mapsearch.jsp"><button class = "jck_menu2_item4"><img src = "./images/gps.png"></button></a>
            </div>
            <div class = "jck_menu_item jck_menu_item3">
                <button id = "jck_chatbox" class = "jck_menu3_item1 jck_after_login"><img src = "./images/chat.png"><span id = "unread" class = "label label-info"></span></button>
                <button id = "jck_mypagebefore" class = "jck_menu3_item1 jck_before_login"><img src = "./images/mypagebefore.png"></button>
                <button id = "jck_mypageafter" class = "jck_menu3_item1 jck_after_login"><img src = "./images/mypageafter.png"></button>
                <button id = "jck_loginbefore" class = "jck_menu3_item1 jck_before_login"><img src = "./images/login.png"><div id = "jck_login_text" class="jck_before_login"></div></button>
                <button id = "jck_loginafter" class = "jck_menu3_item1 jck_after_login"><img src = "./images/logout.png"><div id = "jck_logout_text" class="jck_after_login"></div></button>
            </div>
        </div>
        <div class = "jck_content_container">
            <div class = "jck_content_container_div1">
            </div>
            <div class = "jck_content_container_div2">
                <div id="JWJmainsection">
      <div id="JWJpagetitle">
         <h1>프로필 보기</h1>
      </div>
      <%
      session.setAttribute("UserID", "MasterPotato1");
      String userid = (String) session.getAttribute("UserID");
      session.setAttribute("ShowUserID", "MasterPotato1");
      String showuserid = (String) session.getAttribute("ShowUserID");

      MemberDAO dao = new MemberDAO();
      List<MemberVO> mVoList = dao.ShowProfile(userid);
      MemberVO mvo = mVoList.get(0);
      %>
      <div id="JWJprofile">
         <hr id="divline">
         <div id="JWJprofileimg">
            <img src="./images/mypagebefore.png" id="profileimg"
               class="profileimg">
            <h2><%=mvo.getM_nick()%></h2>
            <br> <input type="button" id="m_like" value="추천하기">&nbsp;&nbsp;&nbsp;
            <input type="button" id="report" value="신고하기"
               onclick="location.href='./MemberReport.jsp'">
         </div>
         <div id="JWJprofileinfo">
            <table>
               <tr>
                  <td width="30%">
                     <h4>회원 아이디 :</h4>
                  </td>
                  <td><%=mvo.getM_id()%></td>

               </tr>
               <tr>
                  <td width="30%">
                     <h4>회원 이름 :</h4>
                  </td>
                  <td><%=mvo.getM_name()%></td>

               </tr>
               <tr>
                  <td>
                     <h4>가입일 :</h4>
                  </td>
                  <td><%=mvo.getM_joindate()%></td>
               </tr>
               <tr>
                  <td>
                     <h4>추천수 :</h4>
                  </td>
                  <td><%=mvo.getM_like()%></td>
               </tr>
               <tr>
                  <td>
                     <h4>신고수 :</h4>
                  </td>
                  <td><%=mvo.getM_reportcount()%></td>
               </tr>
               <tr id="location">
                  <td>
                     <h4>주요 거래지역 :</h4>
                  </td>
                  <td><%=mvo.getM_address()%></td>
               </tr>
               <tr>
                  <td>
                     <h4>거래 횟수 :</h4>
                  </td>
                  <td><%=mvo.getM_sellamount()%></td>
               </tr>
               <tr>

                  <td><h4>소개글 :</h4></td>
                  <td><%=mvo.getM_intro()%></td>
               </tr>
            </table>
         </div>
         <hr id="divline">
         <div id="likemembercheck">
            이 회원을 추천하시겠습니까?<br> <br> <input type="button" id="ok"
               onclick="location.href='../MemberLike.do'" value="확인"> <input
               type="button" id="clear" value="취소">
         </div>
      </div>
   </div>
            </div>
            <div class = "jck_content_container_div3 jck_nav_container">
                      <%
                  ProductService pdao = new ProductService();
                      
                      String p_1 = "0";
                      String p_2 = "0";
                      String p_3 = "0";
                      
                      if(session.getAttribute("img1") != null)
  				      	p_1 = String.valueOf(session.getAttribute("img1"));
                        if(session.getAttribute("img2") != null)
                        	p_2 = String.valueOf(session.getAttribute("img2"));
                        if(session.getAttribute("img3") != null)
                        	p_3 = String.valueOf(session.getAttribute("img3"));
                  
                      String p_img1 = "logoimg.png";
                      String p_img2 = "logoimg.png";
                      String p_img3 = "logoimg.png";
                       
                      if(!p_1.equals("0"))
                     p_img1 = pdao.selectHistory(p_1);
                      if(!p_2.equals("0"))
                         p_img2 = pdao.selectHistory(p_2);
                      if(!p_3.equals("0"))
                         p_img3 = pdao.selectHistory(p_3);
                  %>
            <div id="JWJhistorylist">
               <aside>
                  <h3 style="color: white; background: #B97A57; text-align : center;">최근 본 상품</h3>
                  <a href=""><img src="./upload/<%=p_img1 %>"></a> <a href=""><img src="./upload/<%=p_img2 %>"></a>
                  <a href=""><img src="./upload/<%=p_img3 %>"></a>
               </aside>
            </div>
            </div>
        </div>
        <div class = "jck_footer_container" style = "text-align : center;">
            <div style = "color : #CC8431;">상호 : 감자마켓 | 팀원 : 정창균, 정운진, 강대영, 금지운, 윤지혜, 임채린<br>
주소 : 서울특별시 중구 남대문로 120 대일빌딩 2F, 3F<br>
서비스 이용문의 : nothing1360@gmail.com | 서비스제휴문의 : nothing1360@gmail.com<br>
Copyright © Potato-Market. All Rights Reserved.</div>
        </div>
    </div>
    
    <!-- The Modal -->
    <div id="jck_myModal" class="jck_modal">
      <!-- Modal content -->
      <div class="jck_modal-content">
        <div class="jck_modal-header">
          <span class="jck_close">&times;</span>
          <h2>감자 마켓</h2>
        </div>
        <div class="jck_modal-body">
            <ul>
               <%
            		if(session.getAttribute("userID") != null){
            	%>
            	<li>
            		<p><a href = "MyPage.jsp">&lt;마이 페이지&gt;</a></p>
            	</li>
            	<li>
            		<hr>
            	</li>
            	<%
            		}
            	%>
               <li>
                  <p><a href = "ProductgetCountCtl">&lt;상품 검색&gt;</a></p>
                  <ul>
                     <li><a href = "ProductCategoryCtl.do?c_lid=1">의류</a></li>
                     <li><a href = "ProductCategoryCtl.do?c_lid=2">가전제품</a></li>
                     <li><a href = "ProductCategoryCtl.do?c_lid=3">뷰티</a></li>
                     <li><a href = "ProductCategoryCtl.do?c_lid=4">아동용품</a></li>
                     <li><a href = "ProductCategoryCtl.do?c_lid=5">기타</a></li>
                  </ul>
               </li>
               <li>
                  <hr>
               </li>
               <li>
                  <p><a href = "BoardListViewCtl.do?b_type=G">&lt;게시판&gt;</a></p>
                  <ul>
                     <li><a href = "BoardListViewCtl.do?b_type=N">공지사항</a></li>
                     <li><a href = "BoardListViewCtl.do?b_type=P">구매 게시판</a></li>
                     <li><a href = "BoardListViewCtl.do?b_type=G">일반 게시판</a></li>
                     <li><a href = "BoardListViewCtl.do?b_type=Q">QnA</a></li>
                  </ul>
               </li>
               <li>
               <hr>
               </li>
               <li>
                  <p><a href = "avgchart.jsp">&lt;시세 조회&gt;</a></p>
               </li>
            </ul>
        </div>
        <div class="jck_modal-footer">
          <h2>Potato Market</h2>
        </div>
      </div>
    </div>
    
    <script>
        $(window).resize(function(){
            if(window.innerWidth < 600){
                window.resizeTo(600, window.innerHeight);
            }
        });
    </script>
    
    <script>
    // Get the modal
    var modal = document.getElementById("jck_myModal");
    // Get the button that opens the modal
    var btn = document.getElementById("jck_myBtn");

    // Get the <span> element that closes the modal
    var span = document.getElementsByClassName("jck_close")[0];

    // When the user clicks the button, open the modal 
    btn.onclick = function() {
      modal.style.display = "block";
    }
    // When the user clicks on <span> (x), close the modal
    span.onclick = function() {
      modal.style.display = "none";
    }

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
      if (event.target == modal) {
        modal.style.display = "none";
      }
    }
    </script>
    <script>
    var prevScrollpos = window.pageYOffset;
    window.onscroll = function() {
    var currentScrollPos = window.pageYOffset;
      
        if(window.innerWidth >= 900){
            document.getElementById("JWJhistorylist").style.display = "block";
        } else{
           document.getElementById("JWJhistorylist").style.display = "none";
        }
      prevScrollpos = currentScrollPos;
    }
    $(window).resize(function(){
            var currentScrollPos = window.pageYOffset;
      
            if(window.innerWidth >= 900){
                document.getElementById("JWJhistorylist").style.display = "block";
            } else{
               document.getElementById("JWJhistorylist").style.display = "none";
            }
      prevScrollpos = currentScrollPos;
        });
    </script>
    <script>
   $(document).ready(function(){
    <%
       if(session.getAttribute("userID") == null){
    %>
          var before = document.getElementsByClassName("jck_before_login");
          for(var i = 0 ; i<before.length;i++){
             before[i].style.display = "block";
          }
          var after = document.getElementsByClassName("jck_after_login");
          for(var i = 0 ; i<after.length;i++){
             after[i].style.display = "none";
          }
          var Ltext = document.getElementById("jck_login_text");
          Ltext.innerHTML = "로그인";
          Ltext.style.color = "#CC8431";
          Ltext.style.width = "100%";
          Ltext.style.textAlign = "center";
          Ltext.style.fontWeight = "bolder";
       
    <%      
       }else{
    %>
       
          var before = document.getElementsByClassName("jck_before_login");
         for(var i = 0 ; i<before.length;i++){
            before[i].style.display = "none";
         }
         var after = document.getElementsByClassName("jck_after_login");
         for(var i = 0 ; i<after.length;i++){
            after[i].style.display = "block";
         }
         var LOtext = document.getElementById("jck_logout_text");
          LOtext.innerHTML = "로그아웃";
          LOtext.style.color = "#CC8431";
          LOtext.style.width = "100%";
          LOtext.style.textAlign = "center";
          LOtext.style.fontWeight = "bolder";
    <%   
       }
    %>
   })
    </script>
       <script>
       $(document).ready(function(){
          $("#jck_mainpage_btn1").click(function(){
             location.href = "./ProductMainPageGetCountCtl.do";
          });
          $("#jck_mainpage_btn2").click(function(){
             location.href = "./ProductMainPageGetCountCtl.do";
          });
          $("#jck_mypagebefore").click(function(){
             location.href = "./Login.jsp";
          });
          
          $("#jck_mypageafter").click(function(){
  			<%if(userID != null){
  				if(userID.equals("MasterPotato1")){
  			%>
  				location.href = "./AdminListViewCtl.do";
  			<%
  				}else{
  			%>
  				location.href = "./MyPage.jsp";
  			<%
  				}}
  			%>
  		});
          $("#jck_loginbefore").click(function(){
             location.href = "./Login.jsp";
          });
          $("#jck_loginafter").click(function(){
             location.href = "./LogoutCtl.do";
          });
          $("#SearchButton").click(function(){
             location.href = "./ProductgetSearchCountCtl.do?SearchFilter="+$("#SearchFilter").val()+"&SearchStr="+$("#SearchStr").val();
          });
          $("#jck_chatbox").click(function(){
             location.href="./box.jsp";
          });
       });
          
       </script>
       <%
      String messageContent = null;
      if(session.getAttribute("messageContent") != null){
         messageContent = (String) session.getAttribute("messageContext");
      }
      String messageType = null;
      if(session.getAttribute("messageType") != null){
         messageContent = (String) session.getAttribute("messageType");
      }
      if(messageContent != null){
   %>
       <div class = "modal fade" id = "messageModal" tabindex="-1" role = "dialog" aria-hidden = "true">
          <div class = "vertical-alignment-helper">
             <div class = "modal-dialog vertical-align-center">
                <div class = "modal-content <% if(messageType.equals("오류 메시지")) out.println("panel-warning"); else out.println("panel-success"); %>">
                   <div class = "modal-header panel-heading">
                      <button type = "button" class = "close" data-dismiss="modal">
                         <span aria-hidden="true">&times;</span>
                         <span class="sr-only">Close</span>
                      </button>
                      <h4 class = "modal-title">
                         <%=messageType %>
                      </h4>
                   </div>
                   <div class = "modal-body">
                      <%=messageContent %>
                   </div>
                   <div class = "modal-footer">
                      <button type = "button" class = "btn btn-primary" data-dismiss="modal">확인</button>
                   </div>
                </div>
             </div>
          </div>
      </div>
      <script>
         $('#messageModal').modal("show");
      </script>   
      <%   
         session.removeAttribute("messageContent");
         session.removeAttribute("messageType");
         }
      %>
      <%
         if(userID != null){
      %>
         <script type="text/javascript">
            $(document).ready(function(){
               getUnread();
               getInfiniteUnread();
            });
         </script>
      <%
         }
      %>
</body>
</html>
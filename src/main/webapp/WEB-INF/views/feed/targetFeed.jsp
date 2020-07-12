<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<!-- 상대피드 by 귀정 -->
<html>
<head>
<meta charset="UTF-8">
<title>${targetUser.u_name}님의 피드</title>
<c:import url="../common/header.jsp" />

</head>
<body>
	<div id="mask" onclick="closeMaskFun();"></div> 
	<input type="hidden" id="hiddenSessionU_no" name="my_no" value="${loginMember.u_no}">
	<input type="hidden" id="hieddenU_no" name="u_no" value="${u_no}">
	<div id="feedWrap">
		<!-- 피드영역 -->
		<div id="feedArea">
				<div id="feedcontentsArea">
					<!-- 피드영역 -->
					<c:if test="${message != null}">
						<div id="notFeedArea">
							<p id="notFeed">${targetUser.u_name}${message}</p>
						</div>
					</c:if><!-- 피드가없을시 피드없다는 메시지 노출 -->
					<c:forEach var="feed" items="${feed_list}">
					<div id="feedContainer${feed.f_no}" class="feedContainer">
						<!-- 피드 글영역 시작 -->
						<div id="feedContents">
							<div id="feedWriterWrap">
								<!-- 프로필 이미지 부분 시작 -->
								<div id="profileImgArea">
									<c:if test="${feed.u_profile != null}">
	    									<img id="profileImgs" src="resources/images/profile/${feed.u_profile}" />
	    								</c:if>
	    							<c:if test="${feed.u_profile == null}">
	    									<img id="profileImgs" src="resources/images/profile/nullProfile.png" />
	    							</c:if>
								</div>
								<!-- 이름, 이메일부분 시작 -->
								<div id="feedNameArea"> 
	    								${feed.u_name}<br><span>${feed.u_email}</span>
	    						</div>
							</div>
							<div id="feed_date"><fmt:formatDate value="${feed.f_date}" pattern="M월 dd일"/></div>
	    					<div id="textArea">${feed.f_text}</div>
	    					<div id="feedTag">
	    							<c:forTokens items="${feed.f_tag}" delims="," var="tag">
									   <a id="hashTagId" href="#" onclick="goTagSearchFunc('${tag}');">${tag}</a>
									</c:forTokens>
	    					</div>
	    					<div id="likeCnt">
	    						<!-- 글 좋아요 영역 -->
	    							<c:forEach var="like_Check" items="${feed_Like_Chk}">
			                            <c:if test="${like_Check.f_no eq feed.f_no}">
			                               <c:set var="heart" value="${feed.f_no}" />
			                               <input type="hidden" value="${heart}">
										</c:if>
	    							</c:forEach>
	    					 	 <c:choose>
		                               <c:when test="${heart == feed.f_no}">
		                               		<a href="#" onclick="delLikeFunc('${feed.f_no}');">
		                               			<img id="chkHeart${feed.f_no}" src="resources/images/common/heartIcon2.png">
		                               		</a>
		                               </c:when>
		                               <c:otherwise>
		                               		<a href="#" onclick="plusLikeFunc('${feed.f_no}');">
		                                		<img id="unChkHeart${feed.f_no}" src="resources/images/common/heartIcon3.png">
		                                	</a>	
		                               </c:otherwise>
	                           	</c:choose>
	                           	<!-- 좋아요 수 영역 -->
								<c:forEach var="feed_like_count" items="${feed_like_cnt}">
									 <c:if test="${feed_like_count.f_no eq feed.f_no}">
									 		${feed_like_count.count}
									 </c:if>						
								</c:forEach>
		    				</div>
		    				<!-- 댓글 수 영역 -->
		    				<div id="replyCnt">
		    					<img src="resources/images/common/chatIcon.png">
		    					<c:forEach var="feed_reply_count" items="${feed_reply_cnt}">
									 <c:if test="${feed_reply_count.f_no eq feed.f_no}">
									 		${feed_reply_count.count}
									 </c:if>  							
								</c:forEach>
		    				</div>
		    				<div id="lines"></div>
		    				<!-- 댓글영역 시작 -->
		    				<c:forEach var="feed_reply_count" items="${feed_reply_cnt}">
										 <c:if test="${feed_reply_count.f_no eq feed.f_no}">
										 		<c:set var="replyCount" value="${feed_reply_count.count}" />
										 </c:if>  							
							</c:forEach>
							<c:choose>
								<c:when test="${replyCount <=3}">
					    				<div class="replyWrap">
						    				<c:forEach var="feed_reply_list" items="${feed_Reply_List}">
								    				 <c:if test="${feed_reply_list.f_no eq feed.f_no}">
								    				 	<a href="#" onclick="targetFeedFunc('${feed_reply_list.u_no}')">
									    					<div id="replyOne">
									    						<div id="replyProfileImg">
									    							<c:if test="${feed_reply_list.u_profile != null}">
							    										<img id="profileImgs" src="resources/images/profile/${feed_reply_list.u_profile}" />
								    								</c:if>
									    							<c:if test="${feed_reply_list.u_profile == null}">
									    									<img id="profileImgs" src="resources/images/profile/nullProfile.png" />
									    							</c:if>
									    						</div>
									    						<div id="rightArea">
									    							<div id="replyNickName">${feed_reply_list.u_name}</div>
									    							<div id="replyDate">
									    								<c:forEach var="replyTimes" items="${rtList}">
									    									<c:if test="${replyTimes.fr_no eq feed_reply_list.fr_no}">
									    										${replyTimes.fr_date_msg }
									    									</c:if>
								    									</c:forEach>
									    								<c:if test="${loginMember.u_no eq feed_reply_list.u_no}">
										    								<div id="editArea">
										    									<a href="#" onclick="replydelFunc('${feed_reply_list.fr_no}');">삭제</a>
										    									<a href="#" onclick="replyModiFunc('${feed_reply_list.fr_no}');">수정</a>
										    								</div>
										    							</c:if>	 
									    							</div>
									    							<div id="replyText">${feed_reply_list.fr_text}</div>
									    						</div>
									    						<!-- 댓글수정 폼 영역 시작 '수정'을 누르면 노출 -->
									    						<div id="replyModidiv${feed_reply_list.fr_no}" class="modiDiv">
									    							<form id="replyModiForm" method="post">
										    							<input type="text" id="fr_Moditext${feed_reply_list.fr_no}" 
										    								class="fr_Moditext" name="fr_Ntext" value="${feed_reply_list.fr_text}">
																		<button id="replyModiSub" onclick="replyModiSubFunc('${feed_reply_list.fr_no}');">수정</button>
																		<button id="closeReplyModiSub" onclick="closeReplyModiSubFunc('${feed_reply_list.fr_no}');">닫기</button>
																	</form>				    						
									    						</div>
									    					</div>
									    				</a>	
									    			 </c:if>
						    				</c:forEach>
					    				</div>
			    				</c:when>
			    				<c:otherwise>
					    				<div class="replyWrapMore" id="replyWrapId${feed.f_no}">
						    				<c:forEach var="feed_reply_list" items="${feed_Reply_List}">
								    				 <c:if test="${feed_reply_list.f_no eq feed.f_no}">
									    					<a href="#" onclick="targetFeedFunc('${feed_reply_list.u_no}')">
										    					<div id="replyOne">
										    						<div id="replyProfileImg">
										    							<c:if test="${feed_reply_list.u_profile != null}">
								    										<img id="profileImgs" src="resources/images/profile/${feed_reply_list.u_profile}" />
									    								</c:if>
										    							<c:if test="${feed_reply_list.u_profile == null}">
										    									<img id="profileImgs" src="resources/images/profile/nullProfile.png" />
										    							</c:if>
										    						</div>
										    						<div id="rightArea">
										    							<div id="replyNickName">${feed_reply_list.u_name}</div>
										    							<div id="replyDate">
										    								<c:forEach var="replyTimes" items="${rtList}">
										    									<c:if test="${replyTimes.fr_no eq feed_reply_list.fr_no}">
										    										${replyTimes.fr_date_msg }
										    									</c:if>
								    										</c:forEach>
										    								<c:if test="${loginMember.u_no eq feed_reply_list.u_no}">
											    								<div id="editArea">
											    									<a href="#" onclick="replydelFunc('${feed_reply_list.fr_no}');">삭제</a>
											    									<a href="#" onclick="replyModiFunc('${feed_reply_list.fr_no}');">수정</a>
											    								</div>
											    							</c:if>	 
										    							</div>
										    							<div id="replyText">${feed_reply_list.fr_text}</div>
										    						</div>
										    						<!-- 댓글수정 폼 영역 시작 '수정'을 누르면 노출 -->
										    						<div id="replyModidiv${feed_reply_list.fr_no}" class="modiDiv">
										    							<form id="replyModiForm" method="post">
											    							<input type="text" id="fr_Moditext${feed_reply_list.fr_no}" 
											    								class="fr_Moditext" name="fr_Ntext" value="${feed_reply_list.fr_text}">
																			<button id="replyModiSub" onclick="replyModiSubFunc('${feed_reply_list.fr_no}');">수정</button>
																			<button id="closeReplyModiSub" onclick="closeReplyModiSubFunc('${feed_reply_list.fr_no}');">닫기</button>
																		</form>				    						
										    						</div>
										    					</div>
									    					</a>
									    			 </c:if>
						    				</c:forEach>
						    				
					    				</div>
					    				<!-- 댓글 더보기 버튼 -->
					    				<c:set var= "more" value="${replyCount-3}"/>
					    				<input type="button" id="moreReply${feed.f_no}" class="moreReply" onclick="moreReplyFunc('${feed.f_no}','${more}');" 
					    					value="${more}개의 댓글 더보기">		
			    				</c:otherwise>
		    				</c:choose>
		    				<!-- 댓글영역 끝 -->
		    				<!-- 댓글 insert 영역 -->
		    				<div id="insertReply">
		    					<form id="insertForm" method="post" action="insertReplyTarget.do">
		    						<input type="text" name="fr_text" id="inputReplyText" placeholder="게시물에 댓글을 남겨주세요.">
		    						<input type="hidden" name="f_no" id="reply_input_Fno" value="${feed.f_no}">
									<input type="hidden" name="u_no" id="reply_input_Uno" value="${loginMember.u_no}"> 
									<input type="hidden" name="t_no" value="${targetUser.u_no}"> 
									<button id="insertBtn"> </button>
		    					</form>
				    		</div>	
						</div>
							<!-- 피드 이미지 슬라이드 영역  -->
							<div id="slide${feed.f_no}" class="feedSlideDiv">
								<c:if test="${feed.f_img != null}">
									<div class="targetfeedSlideDiv" align="center" style="width: 400px; left: 400px;">
								     <c:forTokens items="${feed.f_img}" delims="," var="f_img">
							        	<div class="swiper-slide"><img src="resources/images/feedImages/${f_img}"></div>
							        </c:forTokens>
									</div>
								</c:if>	
								<c:if test="${feed.f_img == null}">
									<div class="swiper-container">
										<p id="noFeedImage">등록된 피드이미지가 없습니다.</p>
									</div>
								</c:if>
							</div>
						</div>
					</c:forEach>
				</div>	
		</div><!-- 피드영역끝 -->
		
		<!-- 계정영역 -->
		<div id="accountArea">
			<div id="imgArea">
				<c:if test="${targetUser.u_profile == null}">
					<img id="profileImg" src="resources/images/common/nullProfile.png">
				</c:if>
				<c:if test="${targetUser.u_profile != null}">
					<img id="profileImg" src="resources/images/profile/${targetUser.u_profile}">
				</c:if>
			</div>
			<div id="targetAccountPrimaryInfo">
				<div id="accountName">${targetUser.u_name}
				 </div>
				<div id="accountEmail">${targetUser.u_email}</div>
			</div>
			<div id="accountIntro">
				<c:if test="${targetUser.u_intro != null}">
					${targetUser.u_intro}
				</c:if>
				<c:if test="${targetUser.u_intro == null}">
					등록된 인사말이 없습니다.
				</c:if>
			</div>
			<!-- 정보영역 -->
			<div id="divStyle">
				<div id="tarPinfoArea">
					<p id="gender" class="pinfoAreas">
						<c:if test="${targetUser.u_gender eq 'M'}">
							남성
						</c:if>
						<c:if test="${targetUser.u_gender eq 'F'}">
							여성
						</c:if>
					</p>
					<p id="spec" class="pinfoAreas">${targetUser.u_height} / ${targetUser.u_weight}</p>
					<p id="loc" class="pinfoAreas">${targetUser.u_loc} 거주</p><br>
					<p id="edu" class="pinfoAreas">${targetUser.u_shcool}</p>
					<p id="job" class="pinfoAreas">${targetUser.u_job}</p>
				</div>	
				<div id="tarStyleArea">
					<p id="tarTitle">매력포인트</p>
					<c:forTokens items="${targetUser.s_appeal}" delims="," var="appeal">
						<p id="s_appeal" class="pinfoAreas">${appeal}</p>
					</c:forTokens>
				</div>
				<div id="tarInterArea">
					<p id="tarTitle">관심사</p>
					<c:forTokens items="${targetUser.s_inter}" delims="," var="inter">
						<p id="s_appeal" class="pinfoAreas">${inter}</p>
					</c:forTokens>
				</div>
				<div id="tarLifeArea">
					<p id="tarTitle">라이프스타일</p>
					<c:forTokens items="${targetUser.s_ls}" delims="," var="life">
						<p id="s_appeal" class="pinfoAreas">${life}</p>
					</c:forTokens>
				</div>
				<div id="tarLifeArea">
					<p id="tarTitle">데이트스타일</p>
					<c:forTokens items="${targetUser.s_ds}" delims="," var="dateStyle">
						<p id="s_appeal" class="pinfoAreas">${dateStyle}</p>
					</c:forTokens>
				</div>
			</div>
			<!-- 찜하기 영역 -->
			<!-- 찜을 하지 않았을경우 -->
			<c:if test="${userLikeChk.count == 0}">
				<div id="writeArea">
					<button type="button" class="goLikeTargetBtn" id="unlikeBtn" onclick="goLikeTargetFunc();">
						<img id="goLikeTargetImg" src="resources/images/common/heartIcon2.png" width="50">
						${targetUser.u_name}님을 찜하기
					</button>
				</div>
			</c:if>
			<!-- 찜하고 있을경우 -->
			<c:if test="${userLikeChk.count == 1}">
				<div id="writeArea">
					<button type="button" class="goLikeTargetBtn" onclick="ullikeBtnFunc('${targetUser.u_no}','${loginMember.u_no}');">
						<img id="goLikeTargetImg" src="resources/images/common/heartIcon3.png" width="50">
						${targetUser.u_name}님을 찜하는중
					</button>
				</div>
			</c:if>
			<!-- 신고하기 링크 영역 -->
			<div class="reportArea"><a href="#" onclick="goReportFunc();">신고하기</a></div>
			<!-- 신고하기 모달 팝업 -->
			<div id="goReport">
				<button id="findClose" onclick="findCloseFnc();">X</button>
					<p id="goReportTitle">
					신고하기
					</p>
					<div id="golikeimgArea">
						<c:if test="${targetUser.u_profile == null}">
							<img id="profileImg" src="resources/images/common/nullProfile.png">
						</c:if>
						<c:if test="${targetUser.u_profile != null}">
							<img id="profileImg" src="resources/images/profile/${targetUser.u_profile}">
						</c:if>
					</div>
					<p id="reportMessage1"><span>${targetUser.u_name}</span>님을 신고하시겠습니까?</p>
					<p id="reportMessage2">신고사유를 선택해주세요.</p>
					<div id="reportDiv">
						<select id="r_text" name="r_text" class="reportText">
							<option value="사진도용">사진도용</option>
							<option value="폭력적 또는 혐오적인 콘텐츠">폭력적 또는 혐오적인 콘텐츠</option>
							<option value="악의적인 콘텐츠">악의적인 콘텐츠</option>
							<option value="유해한 위험행위">유해한 위험행위</option>
							<option value="욕설 또는 비방">욕설 또는 비방</option>
							<option value="음란물 게재">음란물 개제</option>
							<option value="광고">광고</option>
							<option value="권리침해">권리침해</option>
						</select>
						<button type="button" id="goReportSub" onclick="goReportConFunc();">신고하기</button>
					</div>
					<input type="hidden" id="loginUno" name="r_send_uno" value="${loginMember.u_no}">
					<input type="hidden" id="targetUno" name="r_rec_uno" value="${targetUser.u_no}">
			</div>
			<!-- 찜하기 모달팝업 -->
			<div id="golike">
				<button id="findClose" onclick="findCloseFnc();">X</button>
				<form id="golikeForm" method="post" action="golikeTarget.do">
					<div id="heartIconArea">
						<img id="goLikeTargetImages" src="resources/images/common/heartIcon2.png" width="50">
					</div>
					<p id="golikeTitle">
					찜하기
					</p>
					<div id="golikeimgArea">
						<c:if test="${targetUser.u_profile == null}">
							<img id="profileImg" src="resources/images/common/nullProfile.png">
						</c:if>
						<c:if test="${targetUser.u_profile != null}">
							<img id="profileImg" src="resources/images/profile/${targetUser.u_profile}">
						</c:if>
					</div>
					<p id="likeMessage1"><span>${targetUser.u_name}</span>님을 찜하시겠습니까?</p>
					<p id="likeMessage2"><span>푸딩1개</span>가 소진됩니다.</p>
					<input type="hidden" name="loginUno" value="${loginMember.u_no}">
					<input type="hidden" name="targetUno" value="${targetUser.u_no}">
						<c:choose>
							<c:when test="${loginMember.u_coin > 0}">
								<div id="likeAreaBtns">
									<input type="submit" value="찜하기" class="likesBtns" id="goTargetLikeBtn" />
									<button type="button" class="likesBtns" id="resetLikeBtn" onclick="findCloseFnc();">취소</button>
								</div>
							</c:when>
							<c:otherwise>
								<div id="likeAreaBtns">
									<button type="button" class="likesBtns" id="goTargetLikeBtn" onclick="goPayFunc();">충전페이지로 이동</button>
									<button type="button" class="likesBtns" id="resetLikeBtn" onclick="findCloseFnc();">취소</button>
								</div>	
								<p id="noCoin">잔여푸딩이 부족합니다. 충전 후 이용해주세요.</p>
							</c:otherwise>
						</c:choose>		
				</form>
			</div>
		</div><!-- 계정영역 끝 -->
	</div>
	<c:import url="../common/footer.jsp"/>
</body>
<link rel="stylesheet" type="text/css" href="resources/css/common/common.css">
<link rel="stylesheet" type="text/css" href="resources/css/feed/feed.css">
<link rel="stylesheet" type="text/css" href="resources/css/feed/slick.css">
<link rel="stylesheet" type="text/css" href="resources/css/feed/slick-theme.css">
<script type="text/javascript" src="resources/js/feed/targetFeed.js"></script>
<script type="text/javascript" src="resources/js/feed/slick.js"></script>
</html>
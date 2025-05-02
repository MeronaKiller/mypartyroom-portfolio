<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주 묻는 질문</title>
<style>
    @font-face {
        font-family: 'LINESeedKR-Light';
        src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/LINESeedKR-Rg.woff2') format('woff2');
        font-weight: 300;
        font-style: normal;
    }
    
    @font-face {
        font-family: 'LINESeedKR-Bold';
        src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/LINESeedKR-Bd.woff2') format('woff2');
        font-weight: 700;
        font-style: normal;
    }
    
    @font-face {
        font-family: 'BMJUA';
        src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/BMJUA.woff') format('woff');
        font-weight: normal;
        font-style: normal;
    }
    
    body {
        font-family: 'LINESeedKR-Light', sans-serif;
        margin: 0;
        padding-top: 130px;
    }
    
    section {
        width: 1100px;
        height: auto;
        margin: 0 auto;
        flex-grow: 1;
        text-align: center;
    }
    
    h2 {
        font-family: 'LINESeedKR-Bold', sans-serif;
        color: #3A3A3A;
        margin-bottom: 30px;
        text-align: center;
    }

    .fnaOpen {
        cursor: pointer;
        border: 1px solid #e5e5e5;
        padding: 15px;
        background-color: #f8f8f8;
        color: #3A3A3A;
        font-weight: bold;
        border-radius: 5px;
        margin-bottom: 5px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        transition: all 0.2s ease;
    }

    .fnaOpen:hover {
        background-color: #F6F6F6;
        box-shadow: 0 2px 5px rgba(0,0,0,0.15);
    }

    .fnaContent {
        display: none;
        border: 1px solid #e5e5e5;
        padding: 20px;
        background-color: white;
        margin-bottom: 15px;
        border-radius: 0 0 5px 5px;
        line-height: 1.7;
        text-align: left;
    }

    .fnaContent table {
        width: 100%;
    }

    .fnaContent td:first-child {
        font-family: 'LINESeedKR-Bold', sans-serif;
        font-weight: bold;
        color: #3A3A3A;
        padding-right: 15px;
        vertical-align: top;
        width: 30px;
    }

    .fnaOpen span:first-child {
        background-color: #3A3A3A;
        color: white;
        padding: 5px 10px;
        border-radius: 50%;
        margin-right: 15px;
        font-size: 14px;
        width: 20px;
        height: 20px;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .fnaOpen span:last-child {
        font-size: 18px;
        color: #888;
    }

    ul {
        list-style-type: none;
        padding: 0;
        margin: 0;
        width: 100%;
    }

    li {
        margin-bottom: 10px;
        width: 100%;
    }
</style>
<script>
function fnaOpen(fnaid) {
    var content = document.getElementById("content-" + fnaid);
    var arrow = document.getElementById("arrow-" + fnaid);

    if(content.style.display === "block") {
        content.style.display = "none";
        arrow.innerHTML = "﹀";
    } else {
        content.style.display = "block";
        arrow.innerHTML = "︿";
    }
}
</script>
</head>
<body>
<section>
    <h2>자주 묻는 질문</h2>
    <ul>
        <c:forEach var="fdto" items="${flist}">
            <li>
                <div class="fnaOpen" onclick="fnaOpen(${fdto.fnaid})">
                    <span>Q</span>
                    <span>${fdto.title}</span>
                    <span id="arrow-${fdto.fnaid}">﹀</span>
                </div>
                <div id="content-${fdto.fnaid}" class="fnaContent">
                    <table>
                        <tr>
                            <td>A</td>
                            <td>${fdto.content}</td>
                        </tr>
                    </table>
                </div>
            </li>
        </c:forEach>
    </ul>
</section>
</body>
</html>
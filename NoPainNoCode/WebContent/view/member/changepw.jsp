<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경 페이지</title>
<style>
   
    #wrap{
      width: 400px;
      margin: 0 auto;
    }
 	table {
      width: 400px;
      border-collapse: collapse;
      border: 1px solid lightgrey;
   }
   td{
      padding: 7px;
      text-align: center;
   }
   input[type=text]{
      border: 1px solid lightgrey;
      width: 80%;
      height: 30px;
      text-align: center;
   }
   input[type=submit]{
      width: 75%;
      height: 40px;
      border: 0;
      background-color: limegreen;
      color: white;
   }
   input[type=submit]:HOVER{
      cursor: pointer;
   }
</style>
</head>
<body>
   
   <div id="wrap">
      <form action="member" method="post">
         <table>
            <tr>
               <td><h4>새로운 비밀번호를 입력하세요</h4></td>            
            </tr>
            <tr>
               <td><input type="text" name="pw"></td>
            </tr>
            <tr>
               <td><input type="submit" value="확인" onclick="window.close()"></td>
            </tr>
         </table>
         <input type="hidden" name="id" value=${id}>
         <input type="hidden" name="cmd" value="changepw">         
      </form>
   </div>
</body>
</html>
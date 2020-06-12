<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.devmaster.mvc.entity.User"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Demo so sánh mặt người</title>
  <!-- Jquery UI Css -->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <style>
    body {
      overflow-x: hidden;
    }

    #sidebar-wrapper {
      min-height: 100vh;
      margin-left: -15rem;
      -webkit-transition: margin .25s ease-out;
      -moz-transition: margin .25s ease-out;
      -o-transition: margin .25s ease-out;
      transition: margin .25s ease-out;
    }

    #sidebar-wrapper .sidebar-heading {
      padding: 0.875rem 1.25rem;
      font-size: 1.2rem;
    }

    #sidebar-wrapper .list-group {
      width: 15rem;
    }

    #page-content-wrapper {
      min-width: 100vw;
    }

    #wrapper.toggled #sidebar-wrapper {
      margin-left: 0;
    }

    @media (min-width: 768px) {
      #sidebar-wrapper {
        margin-left: 0;
      }

      #page-content-wrapper {
        min-width: 0;
        width: 100%;
      }

      #wrapper.toggled #sidebar-wrapper {
        margin-left: -15rem;
      }

      /* .faceid{
    background-color: red;
    position: relative;
    padding-top: 33.3333333333%;
  }  */
      /* .row [class*="col-"]{
    margin-bottom: -99999px;
    padding-bottom: 99999px;
  }

  .row{
    overflow: hidden; 
  } */

    }
  </style>
  <!-- Css màn hình loading -->
  <style type="text/css">
    .modal-load {
      display: none;
      position: fixed;
      z-index: 1000;
      top: 0;
      left: 0;
      height: 100%;
      width: 100%;
      background: rgba(255, 255, 255, .8) url('https://i.stack.imgur.com/FhHRx.gif') 50% 50% no-repeat;
      /* background: rgba(255, 255, 255, .8) url('resources/022.gif') 50% 50% no-repeat; */
    }

    /* When the body has the loading class, we turn
   the scrollbar off with overflow:hidden */
    body.loading {
      overflow: hidden;
    }

    /* Anytime the body has the loading class, our
   modal element will be visible */
    body.loading .modal-load {
      display: block;
    }
    #anh1{
    position: relative;
    }
    #anh2{
    position: relative;
    }
    #selection1{
    position: absolute;
    border: 3px solid red;
    display: none;
    }
    #selection2{
    position: absolute;
    border: 3px solid blue;
    display: none;
    }
  </style>
  <!-- Bootstrap core CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
    integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
  <!-- Custom styles for this template -->

</head>

<body>

  <div class="d-flex" id="wrapper">

    <!-- Sidebar -->
    <div class="bg-light border-right" id="sidebar-wrapper">
      <div class="sidebar-heading">Cognitive Services </div>
      <div class="list-group list-group-flush">
        <a href="verify" class="list-group-item list-group-item-action bg-light">Detect + Verify</a>
        <a href="diemdanh" class="list-group-item list-group-item-action bg-light">Detect + Identify (Yêu cầu Đăng Nhập)</a>
      </div>
    </div>
    <!-- /#sidebar-wrapper -->

    <!-- Page Content -->
    <div id="page-content-wrapper">

      <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
        <button class="btn btn-primary" id="menu-toggle">Menu</button>

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav ml-auto mt-2 mt-lg-0">
            <li class="nav-item">
              <a class="nav-link" href="main">Trang chủ <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="login">Đăng Nhập</a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
                aria-haspopup="true" aria-expanded="false">
                Liên Hệ
              </a>
              <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                <a class="dropdown-item" target="_blank" href="https://www.facebook.com/profile.php?id=100009256667717">Facebook</a>
                <a class="dropdown-item" href="#">Gmail</a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#">GitHub dự án</a>
              </div>
            </li>
          </ul>
        </div>
      </nav>

      <div class="container-fluid" id = "content">
        <br>
        <h1 class="mt-4" style="text-align: center;">So Sánh Mặt Người</h1>
        <br>
        <p>Hướng dẫn sử dụng: Nhập url ảnh hoặc upload file ảnh ở biểu mẫu bên dưới. Lưu ý: vui lòng nhập url 
          hoặc file có định dạng là .jpg/.png/.gif/.jpeg và file ảnh upload lên phải có dung lượng từ 1KB tới 6MB, mỗi ảnh chỉ có 1 mặt người.
        </p>
        <form id = "formDataAjax" method="POST" action="verify" enctype="multipart/form-data">
          <div class="row">
            <div class="col-md-4 col-sm-6 faceid">
              <div class="imageFace row" id="face_1">
                <img class="col-md-12" id = "anh1" src="https://www.diginet.com.vn/wp-content/uploads/2019/01/no-image.jpg" alt="">
                <div id = "selection1"></div>
              </div>
              <input type="text" class="form-control" name="input1" id="input1" style="margin-top: 15px;">
              <fieldset style="margin-top: 15px; margin-bottom: 15px;">
                <label for="radio-1">Sử dụng url</label>
                <input type="radio" name="radio-input1" id="radio-1" checked="checked" value="text">
                <label for="radio-2">Upload file</label>
                <input type="radio" name="radio-input1" id="radio-2" value="file">
              </fieldset>
            </div>
            <div class="col-md-4 col-sm-6 faceid">
              <div class="imageFace row" id="face_2">
                <img class="col-md-12" id = "anh2" src="https://www.diginet.com.vn/wp-content/uploads/2019/01/no-image.jpg" alt="">
                <div id = "selection1"></div>
              </div>
              <input type="text" class="form-control" name="input2" id="input2" style="margin-top: 15px;">
              <fieldset style="margin-top: 15px; margin-bottom: 15px;">
                <label for="radio-3">Sử dụng url</label>
                <input type="radio" name="radio-input2" id="radio-3" checked="checked" value="text">
                <label for="radio-4">Upload file</label>
                <input type="radio" name="radio-input2" id="radio-4" value="file">
              </fieldset>
            </div>
            <div class="col-md-4 col-sm-12 ajax-submit">
              <button type="button" id="submitAjax" class="btn btn-primary">So Sánh 2 Ảnh Vừa Nhập</button>
              <br>
              <p id="resultAjax" style="margin-top: 15px;">Kết quả:</p>
            </div>
          </div>
        </form>
      </div>
    </div>
    <!-- /#page-content-wrapper -->

  </div>
  <!-- /#wrapper -->

  <!-- Bootstrap core JavaScript -->
  <script src="https://code.jquery.com/jquery-3.4.1.min.js"
    integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
    integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
    crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
    integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
    crossorigin="anonymous"></script>
  <!-- Jquery UI -->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"
    integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>
  <script>
  		var a,b,c;
  		$("#menu-toggle").click(function (e) {
  	      e.preventDefault();
  	      $("#wrapper").toggleClass("toggled");
  	 	});
  </script>
  <!-- Script bên dưới sẽ load ngay khi có yêu cầu load trang. Tương tự Document-ready trong jquery -->
  <script>
    $(function () {
      $("#radio-1").checkboxradio();
      $("#radio-2").checkboxradio();
      $("#radio-3").checkboxradio();
      $("#radio-4").checkboxradio();
      $('#radio-2').change(function () {
        $('#input1').attr('type', 'file');
        $('#input1').attr('name', 'files');
        $("#face_1").html('<img class="col-md-12" id = "anh1" src="https://www.diginet.com.vn/wp-content/uploads/2019/01/no-image.jpg" alt=""> <div id = "selection1"></div>');
      });
      $('#radio-1').change(function () {
        $('#input1').attr('type', 'text');
        $('#input1').attr('name', 'input1');
        $("#face_1").html('<img class="col-md-12" id = "anh1" src="https://www.diginet.com.vn/wp-content/uploads/2019/01/no-image.jpg" alt=""> <div id = "selection1"></div>');
      });
      $('#radio-4').change(function () {
        $('#input2').attr('type', 'file');
        $('#input2').attr('name', 'files');
        $("#face_2").html('<img class="col-md-12" id = "anh2" src="https://www.diginet.com.vn/wp-content/uploads/2019/01/no-image.jpg" alt=""> <div id = "selection2"></div>');
      });
      $('#radio-3').change(function () {
        $('#input2').attr('type', 'text');
        $('#input2').attr('name', 'input2');
        $("#face_2").html('<img class="col-md-12" id = "anh2" src="https://www.diginet.com.vn/wp-content/uploads/2019/01/no-image.jpg" alt=""> <div id = "selection2"></div>');
      });

      $("#input1").change(function () {
        let input = $("#input1");
        if ($("#input1").attr('type') == 'text') {
          if (isURL(input.val())) {
            $("#face_1").html('<img class="col-md-12" id = "anh1" src="' + input.val() + '"alt=""> <div id = "selection1"></div>');
          } else {
            $("#face_1").html('<img class="col-md-12" id = "anh1" src="https://www.diginet.com.vn/wp-content/uploads/2019/01/no-image.jpg" alt=""> <div id = "selection1"></div>');
          }
        } else {
          if (fileValidation(input.val())) {
            //ta có input = $("#input1"); do input là 1 đối tượng jquery và 1 đối tượng jquery không có thuộc tính files
            //Để lấy phần tử DOM ra khỏi jQuery, hãy viết input[0].files[0] thay vì input.file[0] để tránh lỗi
            if (input[0].files && input[0].files[0]) {
              var reader = new FileReader();
              reader.onload = function (e) {
                $("#face_1").html('<img class="col-md-12" id = "anh1" src="' + e.target.result + '"alt=""> <div id = "selection1"></div>');
              };
              reader.readAsDataURL(input[0].files[0]);

            }

          } else {
            $("#face_1").html('<img class="col-md-12" id = "anh1" src="https://www.diginet.com.vn/wp-content/uploads/2019/01/no-image.jpg" alt=""> <div id = "selection1"></div>');
          }
        }
      });

      $("#input2").change(function () {
        let input = $("#input2");
        if ($("#input2").attr('type') == 'text') {
          if (isURL(input.val())) {
            $("#face_2").html('<img class="col-md-12" id = "anh2" src="' + input.val() + '"alt=""> <div id = "selection2"></div>');
          } else {
            $("#face_2").html('<img class="col-md-12" id = "anh2" src="https://www.diginet.com.vn/wp-content/uploads/2019/01/no-image.jpg" alt=""> <div id = "selection2"></div>');
          }
        } else {
          if (fileValidation(input.val())) {
            //ta có input = $("#input1"); do input là 1 đối tượng jquery và 1 đối tượng jquery không có thuộc tính files
            //Để lấy phần tử DOM ra khỏi jQuery, hãy viết input[0].files[0] thay vì input.file[0] để tránh lỗi
            if (input[0].files && input[0].files[0]) {
              var reader = new FileReader();
              reader.onload = function (e) {
                $("#face_2").html('<img class="col-md-12" id = "anh2" src="' + e.target.result + '"alt=""> <div id = "selection2"></div>');
              };
              reader.readAsDataURL(input[0].files[0]);

            }

          } else {
            $("#face_2").html('<img class="col-md-12" id = "anh2" src="https://www.diginet.com.vn/wp-content/uploads/2019/01/no-image.jpg" alt=""> <div id = "selection2"></div>');
          }
        }
      });
      
      function ratioOfSelection(faceRetangle1, faceRetangle2){
          let image1 = new Image();
          image1.src = document.getElementById('anh1').src;
          //console.log(document.getElementById('anh1').src);
          let image2 = new Image();
          image2.src = document.getElementById('anh2').src;
          let ratioTop1 = faceRetangle1.top/image1.height;
          let ratioTop2 = faceRetangle2.top/image2.height;
          let ratioLeft1 = faceRetangle1.left/image1.width;
          let ratioLeft2 = faceRetangle2.left/image2.width;
          let ratioWidth1 = faceRetangle1.width/image1.width;
          let ratioWidth2 = faceRetangle2.width/image2.width;
          let ratioHeight1 = faceRetangle1.height/image1.height;
          let ratioHeight2 = faceRetangle2.height/image2.height;
          let arr = [ratioTop1,ratioLeft1,ratioWidth1,ratioHeight1,ratioTop2,ratioLeft2,ratioWidth2,ratioHeight2];
          return arr;
      }
      function drawSelection(arr){
          let anh1 = document.getElementById('anh1');
          let anh2 = document.getElementById('anh2');
          //xác định kích thước và vị trí của selection1
          let top1 = arr[0] * anh1.height;
          let left1 = arr[1] * anh1.width + 7.5;
          let width1 = arr[2] * anh1.width;
          let height1 = arr[3] * anh1.height;
          //xác định vị trí và kích thước của selection2
          let top2 = arr[4] * anh2.height;
          let left2 = arr[5] * anh2.width + 7.5;
          let width2 = arr[6] * anh2.width;
          let height2 = arr[7] * anh2.height;
          //set vị trí và kích thước cho 2 selection(2 ô chỉ vị trí khuôn mặt trong ảnh 1 và ảnh 2)
          $('#selection1').css('top',top1);
          $('#selection1').css('left',left1);
          $('#selection1').width(width1);
          $('#selection1').height(height1);
          $('#selection2').css('top',top2);
          $('#selection2').css('left',left2);
          $('#selection2').width(width2);
          $('#selection2').height(height2);
          $('#selection1').show();
          $('#selection2').show();
      }

      // gọi ajax để gửi dữ liệu về Controller
      $("#submitAjax").click(function (e) {
        //e.preventDefault();
        var form = document.forms[0];
        var formData = new FormData(form);
        let input1 = document.getElementById('input1');
        let input2 = document.getElementById('input2');
        if (document.getElementById("input1").type == 'text' && isURL(document.getElementById("input1").value) == false) {
          showMessage('Bạn nhập sai định dạng url tại ảnh 1. Vui lòng nhập url có định dạng là .jpg/.jpeg/.png/.gif');
          $('#input1').val('');
        } else if (document.getElementById("input1").type == 'file' && fileValidation(document.getElementById('input1').value) == false) {
          showMessage('File upload tại ảnh 1 lên phải là ảnh và có định dạng là .png/.ipg/.jpeg/.gif');
          $('#input1').val('');
        } else if (document.getElementById("input1").type == 'file' && checkSize(document.getElementById('input1').files[0].size) == false) {
          showMessage('File upload tại ảnh 1 lên server phải có dung lượng từ 1KB tới 6MB');
          $('#input1').val('');
        } else if (input2.type == 'text' && isURL(input2.value) == false) {
          showMessage('Bạn nhập sai định dạng url tại ảnh 2. Vui lòng nhập url có định dạng là .jpg/.jpeg/.png/.gif');
          input2.value = '';

        } else if (input2.type == 'file' && fileValidation(input2.value) == false) {
          showMessage('File upload tại ảnh 2 lên phải là ảnh và có định dạng là .png/.ipg/.jpeg/.gif');
          $('#input2').val('');
        } else if (input2.type == 'file' && checkSize(input2.files[0].size) == false) {
          showMessage('File upload tại ảnh 2 lên server phải có dung lượng từ 1KB tới 6MB');
          $('#input2').val('');
        } else {
          var ajaxReq = $.ajax({
            url: 'verify',
            type: 'POST',
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            xhr: function () {
              //Get XmlHttpRequest object
              var xhr = $.ajaxSettings.xhr();

              //Set onprogress event handler 
              xhr.upload.onprogress = function (event) {
                var perc = Math.round((event.loaded / event.total) * 100);
                $('#progressBar').text(perc + '%');
                $('#progressBar').css('width', perc + '%');
              };
              return xhr;
            },
            beforeSend: function (xhr) {
              //Reset alert message and progress bar


              $body.addClass("loading");
            },
            error: function (data) {
              
              showMessage(data.responseText);
              blockflag = false;
              $body.removeClass("loading");
              console.log(data.responseText);
              $('#resultAjax').html("Kết quả: "+data.responseText);
            },
            success: function (data) {
              $body.removeClass("loading");
              let faceRectangle1 = data.resClient1.faceRectangle;
              //a = faceRectangle1;
              let faceRectangle2 = data.resClient2.faceRectangle;
              //b = faceRectangle2;
              let arr = ratioOfSelection(faceRectangle1, faceRectangle2);
              //c = arr
              drawSelection(arr);
              $('#resultAjax').html("Kết quả: "+data.result);
              showMessage(data.result);
              $(window).resize(() => {
                  drawSelection(arr);
              });
              
              //document.getElementsByTagName("img").onresize = function(){drawSelection(arr);}
              
            }
          });

        }
      });

    });



  </script>
  <!-- kiểm tra tính hợp lệ của file hoặc url ảnh -->
  <script>
    function trim(value) {
      var reL = /\s*((\S+\s*)*)/;
      var reR = /((\s*\S+)*)\s*/;
      value = value.replace(reL, "$1");
      return value.replace(reR, "$1");
    }
    $body = $("body");
    function isURL(url) {
      if (url == "" || url == null)
        return false;

      url = trim(url);

      if (url.indexOf(" ") != -1)
        return false;

      //var RegExp = /^http(s)?:\/\/[\w|\-]+(\.[^\.]+)+$/i;
      var RegExp = /(http(s?):)([/|.|\w|\s|-])*\.(?:jpg|gif|png|jpeg)/g;
      //var RegExp = /(https?:\/\/.*\.(?:png|jpg))/i
      if (RegExp.test(url)) {
        return true;
      } else {
        return false;
      }
    }
    function fileValidation(filePath) {
      //let filePath = document.getElementById('FILE_input').value;
      var allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i;
      if (!allowedExtensions.exec(filePath)) {
        return false;
      } else {
        return true;
      }
    }
    function checkSize(size) {
      //let size = document.getElementById('FILE_input').files[0].size;
      if (size / 1024 / 1024 > 6 || size < 1024) {
        return false;
      } else {
        return true;
      }
    }      
  </script>
  <!-- các function dialog dựng sẵn bằng Jquery UI -->
  <script>
    function ajaxError() {
      $(function () {
        $("#dialogAjaxError").dialog({
          modal: true,
          buttons: {
            Ok: function () {
              $(this).dialog("close");
            }
          }
        });
      });
    }

    function ajaxSuccess() {
      $(function () {
        $("#dialogAjaxSuccess").dialog({
          modal: true,
          buttons: {
            Ok: function () {
              $(this).dialog("close");
            }
          }
        });
      });
    }

    function showMessage(message) {
      $(function () {
        $("#dialogMessage p").html(message);
        $("#dialogMessage").dialog({
          modal: true,
          height: 230,
          width: 350,
          buttons: {
            OK: function () {
              $(this).dialog("close");
            }
          }
        });
      });
    }
    
  </script>
  <!-- các dialog tiện ích dựng sẵn -->
  <div id="dialogAjaxError" title="Thông báo" style="display: none;">
    <p style="color: red;">Có lỗi xảy ra. Vui lòng kiểm tra kết nối mạng hoặc thử lại sau!</p>
  </div>
  <div id="dialogAjaxSuccess" title="Thông báo" style="display: none;">
    <p>So sánh thành công!</p>
  </div>
  <div id="dialogMessage" title="Thông báo" style="display: none;">
    <p></p>
  </div>
  <div class="modal-load"></div>
</body>

</html>
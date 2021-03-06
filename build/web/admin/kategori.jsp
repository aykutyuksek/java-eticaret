<%@page import="java.util.List"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="admin.data" %>
<%@include file="header.jsp"%>
<%@include file="menu.jsp"%>
<%@include file="footer.jsp"%>
<%
    data ns = new data();
    
    ArrayList<String> ustidler = new ArrayList<String>();
    
    try {
        ResultSet rs3 = ns.baglan().executeQuery("select ust_kat_id from kategoriler");
        while (rs3.next()) {
            ustidler.add(rs3.getString("ust_kat_id"));
           
        }
    } catch (Exception e) {
        System.err.println("MySQL Bağlantı Hatası Sil:" + e);
    }



    // sil işlemi varsa yapılacak işlemler
    boolean silD = (request.getParameter("silID") == null);
    boolean eslemevarmı=false;
    if (!silD) {
        
        String sil = request.getParameter("silID");
        for(int i=0;i<ustidler.size();i++){
            
        if (sil.equals(ustidler.get(i))) {
            out.print("<script type='text/javascript'>\n");
            
            out.print("alert( " + "' Alt Kategorisi olan Üst Kategori Silinemez '" + ");\n");
            
            out.print("</script>");
            
            eslemevarmı=true;
            break;
        }
        
        } 
        //for döngüsü dışına yazılmalı silme işlemi. Çünkü tamamını kontrol ettikten sonra silme işlemi yapılmalı
        //ilk kodumuzda ust id ile eşleşmediği an her halükarda silme işlemi yapıyordu.
        if(!eslemevarmı){
        //eslesme yoksa yani false ise silme işlemi yap
        int sil1 = ns.baglan().executeUpdate("delete from kategoriler where id = '" + sil + "' limit 1 ");
        }
    }
%>



<!DOCTYPE html>
<html lang="en"><head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>
            Kategori Yönetimi
        </title>

        <link href="bower_components/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="bower_components/metisMenu/dist/metisMenu.min.css" rel="stylesheet">
        <link href="dist/css/sb-admin-2.css" rel="stylesheet">
        <link href="bower_components/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">


        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->

    </head>
    <body>

    <content style="padding: 40px 0px">

        <!-- muratın jstree dosyaları -->
        <script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script type="text/javascript" src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <link rel="stylesheet" type="text/css" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css">
        <script type="text/javascript" src="static/js/jquery.tree.js"></script>
        <script type="text/javascript">
            function selectSecim() {
                var deger = $('#urunTopKategori').val();
                window.location.href = "?ustKat=" + deger;
            }


        </script>
        <script type="text/javascript">
            function alertName() {
                alert("Alt Kategorisi olan Üst Kategori Silinemez.");
            }
        </script> 
        <link rel="stylesheet" type="text/css" href="static/css/jquery.tree.css">

        <section>
            <div style="height: 10px;">

            </div>
            <div class="panel panel-primary" style="width: 60%; position: relative;left: 380px;top: 20px; margin-bottom: 50px">
                <div class="panel-heading">
                    <h4 class="panel-title text-center">Ürün Kategori Ekle</h4>
                </div>
                <div class="panel-body">
                    <p class="text-center">Ürün Kategori Bilgilerinizi Giriniz.</p>
                    <hr>
                    <form class="form-horizontal" action="kategoriEkleAction.jsp" method="post" style="width: 90%; margin: 0 auto;">

                        <!-- ÜST KATEGROİ -->
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3">
                                    <label>Üst Kategori Seçiniz</label>
                                </div>

                                <div class="col-md-9">

                                    <select class="form-control" name="topCategory" id="urunTopKategori">
                                        <option value="0">Kategori Seçiniz </option>";


                                        <%
     ArrayList<String> idler = new ArrayList<String>();
    
                                            int k = 0;
                                            ResultSet rs1 = ns.baglan().executeQuery("select *from kategoriler where ust_kat_id=0");
                                            while (rs1.next()) {
                                                idler.add(rs1.getString("id"));
                                        %>
                                        <option value="<% out.print(rs1.getString("id"));%>"><% out.print(rs1.getString("adi")); %></option>
                                        <%k++;
                                            }%>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <!-- Kategori Adı -->
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3">
                                    <label for="kisa_aciklama">Kategori Adını Giriniz</label>
                                </div>
                                <div class="col-md-9">
                                    <input type="text" name="kategori_adi" class="form-control" placeholder="Kategori Adı Giriniz">
                                </div>
                            </div>
                        </div>

                        <input value="11" name="sid" type="hidden">
                        <!-- Buton -->
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3"> </div>
                                <div class="col-md-9 text-right">
                                    <input type="submit" value="Kaydet" name="kaydet" class="btn btn-primary">

                                </div>
                            </div>
                        </div>
                    </form>

                    <!-- İŞLEM MESAJ -->
                    <!-- İŞLEM MESAJ -->
                    <script>
                        function yonlendirBasarili() {
                            var page_url = window.location.href;
                            page_url = page_url.replace("&sonuc=basarili", "");
                            window.location.href = page_url;
                        }
                        ;

                        function yonlendirBasarisiz() {
                            var page_url = window.location.href;
                            page_url = page_url.replace("&sonuc=basarisiz", "");
                            window.location.href = page_url;
                        }
                        ;
                    </script>


                </div>

            </div>
        </section>
    </content>


    <footer class="text-center">
    </footer>
    <!-- #WRAPPER -->


    <!-- ########## SCRIPTLER ########## -->
    <link href="static/assets/css/main.css" rel="stylesheet">
    <link href="static/assets/css/croppic.css" rel="stylesheet">
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->


    <script src="../static/js/jquery.min.js" type="text/javascript"></script>
    <script src="static/assets/js/bootstrap.min.js"></script>
    <script src="static/assets/js/jquery.mousewheel.min.js"></script>
    <script src="static/croppic.min.js"></script>
    <script src="static/assets/js/main.js"></script>
    <script src="../static/js/jquery.min.js" type="text/javascript"></script>
    <script>

                        $(document).ready(function () {
                            // toogle hareketi sağlanıyor - Mesajlar
                            $('li.dropdown.acil').toggle(function () {
                                $('.dropdown-menu.dropdown-messages').slideDown();
                            }, function () {
                                $('.dropdown-menu.dropdown-messages').slideUp();
                            });

                        });

                        var croppicContainerEyecandyOptions = {
                            uploadUrl: 'static/img_save_to_file.php',
                            cropUrl: 'static/img_crop_to_file.php',
                            imgEyecandy: false,
                            loaderHtml: '<div class="loader bubblingG"><span id="bubblingG_1"></span><span id="bubblingG_2"></span><span id="bubblingG_3"></span></div> '
                        };
                        var cropContainerEyecandy = new Croppic('cropContainerEyecandy', croppicContainerEyecandyOptions);
    </script>



    <script src="../static/js/jquery.sieve.min.js" type="text/javascript"></script>
    <script>
                        var searchTemplate = "<li class='sidebar-search'><input type='text' class='form-control' placeholder='Arama'></li>"
                        $(".table-sieve").sieve({searchTemplate: searchTemplate});
                        searchTemplate = "<div class='row form-inline'><label style='float: right;'><input type='text' class='form-control' placeholder='Arama'></label></div>"
                        $(".p-sieve").sieve({searchTemplate: searchTemplate, itemSelector: "p"});
    </script>

    <!-- jQuery -->
    <script src="static/bower_components/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap Core JavaScript -->
    <script src="static/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- Metis Menu Plugin JavaScript -->
    <script src="static/bower_components/metisMenu/dist/metisMenu.min.js"></script>
    <!-- Morris Charts JavaScript -->
    <script src="static/bower_components/raphael/raphael-min.js"></script>
    <!-- Custom Theme JavaScript -->

    <!-- Tablolar için dataTable işlemleri -->
    <script type="text/javascript" src="static/js/tablo/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="static/js/tablo/dataTables.bootstrap.js"></script>
    <script>
                        var jk = jQuery.noConflict();
                        jk(document).ready(function () {
                            if (jk('table.display')) {

                                jk('table.display').dataTable({
                                    "language": {
                                        "lengthMenu": "Sayfa başına _MENU_ kayıt göster.",
                                        "zeroRecords": "Kayıt bulunamadı.",
                                        "info": "_PAGE_ / _PAGES_",
                                        "infoEmpty": "Kayıt bulunamadı.",
                                        "infoFiltered": "(Toplam _MAX_ kayıttan filtre edildi.)",
                                        "search": "Arama yapın.",
                                        "paginate": {
                                            "first": "İlk",
                                            "previous": "<<<",
                                            "next": ">>>",
                                            "last": "Son"
                                        }

                                    },
                                    "lengthMenu": [[5, 10, 25, -1], [5, 10, 25, "Hepsi"]],
                                    "pagingType": "full"
                                });
                            }
                        });

    </script>
    <style type="text/css">
        .tg  {border-collapse:collapse;border-spacing:0;}
        .tg td{font-family:Arial, sans-serif;font-size:14px;padding:5px 20px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
        .tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:5px 20px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
    </style>


    <table style="width: 60%; position: relative;left: 380px ;top: 20px" class="tg">

        <tr>
            <th class="tg-031e">ID</th>
            <th class="tg-031e">Kategori Adı</th>
            <th class="tg-031e">Üst Kategori ID</th>
            <th class="text-center">Düzenle</th>
            <th class="text-center">Sil</th>
        </tr>

        <%      int i = 0;
            ResultSet rs = ns.baglan().executeQuery("select *from kategoriler");
           
            
            while (rs.next()) {
                
        %>
        <tr>
            <td class="tg-031e"><% out.print(rs.getString("id")); %></td>
            <td class="tg-031e"><% out.print(rs.getString("adi")); %></td>
            <td class="tg-031e"><% out.print(rs.getString("ust_kat_id")); %></td>
            <td class="text-center">
                <form  method="POST">
                    <input name="icerikId" type="hidden" value="24">
                    <input name="link" type="hidden" value="icerik">
                    <a href="kategoriDuzenle.jsp?duzenleID=<% out.print(rs.getString("id")); %>" class="btn btn-primary">Düzenle</a>
                </form>
            </td>
            <td class="text-center">
                <form  method="POST">
                    <input name="icerikId" type="hidden" value="24">
                    <input name="link" type="hidden" value="icerik" disabled>
                    <a href="?silID=<% out.print(rs.getString("id")); %>" class="btn btn-danger">Sil</a>
                </form>
            </td>
        </tr>
        <%i++;
            }%>

    </table>
</body>
</html>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title><pagetitle/></title>
    <link rel="stylesheet" type="text/css" href="../../../style.css">
    <script>
      /* to redirect when clicking on an option in a list*/
      function selected(comp) {
        document.location.href = '/' + comp.id + '/View/' + comp.options[comp.selectedIndex].value;
      }
    </script>
  </head> 
  <body>
    <div class="all">
      <form action="/$(view)/Save/$(focus)/">
        <div class="nav">
          <input type="submit" id="action" value="Save" class="saveB">
          <navigation/>
        </div>
        <br>
        <h1><pagetitle/></h1>
        <maincontent/>
      </form>
    </div>
  </body>
</html> 
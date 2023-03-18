<input type="hidden" id="studyUid" value="<?php echo $_REQUEST['studyuid'] ?>">

<script>
  
  if(/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)){
    // true for mobile device
    location.href='http://<?php echo $_SERVER['HTTP_HOST']; ?>/ecos/dicomviewersm/index.php?studyUID=<?php echo $_REQUEST['studyuid'] ?>';
  }else{
    // false for not mobile device
    location.href='http://<?php echo $_SERVER['HTTP_HOST']; ?>/ecos/dicomviewer/index.php?studyUID=<?php echo $_REQUEST['studyuid'] ?>';
  }
  
</script>  


<html>
<head>
  <title>IMS Basic Learning Tools Interoperability</title>
</head>
<body style="font-family:sans-serif">
<img src="http://www.imsglobal.org/images/IMSGLCLogo.jpg"/>
<p><b>IMS BasicLTI PHP Consumer</b></p>
<p>This is a very simple reference implementaton of the LMS side (i.e. consumer) for IMS BasicLTI.</p>
<?php

require_once("misc.php");
require_once("ims-blti/blti_util.php");

    $lmsdata = array(
	    "resource_link_id" => "2",
	    "resource_link_title" => "Tutorial de Aprendizaje Colaborativo",
	    "resource_link_description" => "Tutorial que describe el ciclo basico de desarrollo del aprendizaje colaborativo y explica la funcionalidad de la interoperabilidad que permite a sistemas de gestion del aprendizaje como Moodle interactuar con sistemas externos.",
	    "user_id" => "2",
	    "roles" => "Instructor",  // or Learner
	    "lis_person_name_full" => '=Admin User',
	    "lis_person_contact_email_primary" => "cyntsc@yahoo.com",
    	// DATOS NO LOCALIZADOS "tool_consumer_instance_description" => "University of School (LMSng)",
	    //"lis_person_sourcedid" => "school.edu:user",	    
	    "context_id" => "5",
	    "context_title" => "Informatica Basica e Internet",
	    "context_label" => "CBI",
	    "tool_consumer_instance_guid" => "localhost",	      
      );

        
  foreach ($lmsdata as $k => $val ) {
      if ( $_POST[$k] && strlen($_POST[$k]) > 0 ) {
          $lmsdata[$k] = $_POST[$k];
      }
  }

  $cur_url = curPageURL();
  $key = $_REQUEST["key"];
  if ( ! $key ) $key = "12345";
  $secret = $_REQUEST["secret"];
  if ( ! $secret ) $secret = "secret";
  $endpoint = $_REQUEST["endpoint"];

  if ( ! $endpoint ) $endpoint = str_replace("lms.php","tool.php",$cur_url);
  $urlformat = $_REQUEST["format"];
  $urlformat = ( $urlformat != 'XML' );
  $tool_consumer_instance_guid = $lmsdata['tool_consumer_instance_guid'];
  $tool_consumer_instance_description = $lmsdata['tool_consumer_instance_description'];

  $xmldesc = str_replace("\\\"","\"",$_REQUEST["xmldesc"]);
  if ( ! $xmldesc ) $xmldesc = $default_desc;
?>
<script> 
  //<![CDATA[ 
  // esta funcion permite verificar el estado on/off
function lmsdataToggle() {
    var ele = document.getElementById("lmsDataForm");
    if(ele.style.display == "block") {
        ele.style.display = "none";
    }
    else {
        ele.style.display = "block";
    }
} 
  //]]> 
</script>
<a id="displayText" href="javascript:lmsdataToggle();">Toggle Resource and Launch Data</a>
<?php
  echo("<form method=\"post\" id=\"lmsDataForm\" style=\"display:block\">\n");
  echo("<input type=\"submit\" value=\"Recompute Launch Data\">\n");
  echo("<select name=\"format\" onchange=\"this. form.submit();\">\n");
  echo("<option value=\"URL\">URL plus Secret</option>\n");
  if ( $urlformat ) {
    echo("<option value=\"XML\">XML Descriptor</option>\n");
  } else {
    echo("<option value=\"XML\" selected=\"selected\">XML Descriptor</option>\n");
  }
  echo("</select>");
  echo("(To set a value to 'empty' - set it to a blank)");
  echo("<fieldset><legend>BasicLTI Resource</legend>\n");
  if ( $urlformat ) {
    echo("Launch URL: <input size=\"60\" type=\"text\" name=\"endpoint\" value=\"$endpoint\">\n");
  } else {
    echo("XML BasicLTI Resource Descriptor: <br/> <textarea name=\"xmldesc\" rows=\"10\" cols=\"80\">".htmlspecialchars($xmldesc)."</textarea>\n");
  }
  echo("<br/>Key: <input type\"text\" name=\"key\" value=\"$key\">\n");
  echo("<br/>Secret: <input type\"text\" name=\"secret\" value=\"$secret\">\n");
  echo("</fieldset><p>");
  echo("<fieldset><legend>Launch Data</legend>\n");
  foreach ($lmsdata as $k => $val ) {
      echo($k.": <input type=\"text\" name=\"".$k."\" value=\"");
      echo(htmlspecialchars($val));
      echo("\"><br/>\n");
  }
  echo("</fieldset><p>");
  echo("</form>");
  echo("<hr>");

  if ( ! $lmspw ) unset($tool_consumer_instance_guid);

  if ( $urlformat ) {
    $parms = $lmsdata;
  } else {
    $cx = launchInfo($xmldesc);
    $endpoint = $cx["launch_url"];
    if ( ! $endpoint ) {
      echo("<p>Error, did not find a launch_url or secure_launch_url in the XML descriptor</p>\n");
      exit();
    }
    $custom = $cx["custom"];
    $parms = array_merge($custom, $lmsdata);
  }

  // Cleanup parms before we sign
  // Limpia parametros antes de registrarse
  foreach( $parms as $k => $val ) {
    if (strlen(trim($parms[$k]) ) < 1 ) {
       unset($parms[$k]);
    }
  }

  // Add oauth_callback to be compliant with the 1.0A spec
  // Agrega la devolucion de la llamada con la especificacion 1.0
  $parms["oauth_callback"] = "about:blank";

  $parms = signParameters($parms, $endpoint, "POST", $key, $secret, "Press to Launch", $tool_consumer_instance_guid, $tool_consumer_instance_description);

  $content = postLaunchHTML($parms, $endpoint, true, 
     "width=\"100%\" height=\"900\" scrolling=\"auto\" frameborder=\"1\" transparency");
  print($content);

?>
<hr>
<p>
Note: Unpublished drafts of IMS Specifications are only available to 
IMS members and any software based on an unpublished draft is subject to change.
Sample code is provided to help developers understand the specification more quickly.
Simply interoperating with this sample implementation code does not 
allow one to claim compliance with a specification.
<p>
<a href=http://www.imsglobal.org/toolsinteroperability2.cfm>IMS Learning Tools Interoperability Working Group</a> <br/>
<a href="http://www.imsglobal.org/ProductDirectory/directory.cfm">IMS Compliance Detail</a> <br/>
<a href="http://www.imsglobal.org/community/forum/index.cfm?forumid=11">IMS Developer Community</a> <br/>
<a href="http:///www.imsglobal.org/" class="footerlink">&copy; 2009 IMS Global Learning Consortium, Inc.</a> under the Apache 2 License.</p>

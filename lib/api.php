<?php

# SimpleBackpack: PHP wrapper class for Backpack API
# Version: 0.1.2
# Author: Christoph Wimmer
# Projects page: http://www.engadgeted.net/projects/simplebackpack-php-wrapper-class-for-backpack-api/

class SimpleBackpack {
//	var $username = "mstram";
//	var $token = "2cd7fead9448ecc584981090345a360d160b914f";
//	var $result_type = "raw";

//	function SimpleBackpack($u, $t, $result = "raw") {
//		$this->username = $u;
//		$this->token = $t;
//		$this->result_type = $result;

//        function __construct($u, $t, $result = "raw") {

        function __construct() {
              print "(SimpleBackpack: (constructor)\n";
	      $this->username = "mstram";
	      $this->token = "2cd7fead9448ecc584981090345a360d160b914f";
	      $this->result_type = "raw";
	}


	function create_request($parameters) {
		$request_payload = "";
		if ((!empty($parameters)) && (is_array($parameters))) {
			foreach($parameters as $key => $value) {
				if (!is_array($value)) {
					$request_payload .= ("<".$key.">".$value."</".$key.">\r\n");
				} else {
					$request_payload .= "<".$key.">\r\n";
					$request_payload .= $this->create_request($value);
					$request_payload .= "</".$key.">\r\n";
				}
			}
		}
		return $request_payload;
	}

	function curl_request($url, $request_body) {
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $request_body);
		curl_setopt($ch, CURLOPT_HTTPHEADER, array('X-POST_DATA_FORMAT: xml'));
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		$data = curl_exec($ch);
		curl_close($ch);
		return $data;
	}

	function request($path, $parameters = "") {
		$url = "http://".$this->username.".backpackit.com/ws/".$path;
		$request_body = "<request>\r\n<token>".$this->token."</token>\r\n".$this->create_request($parameters)."</request>";
		$result = $this->curl_request($url, $request_body);
		if ($this->result_type == "simplexml") {
			$result = simplexml_load_string($result);
		}
		return($result);
	}

        //////////////////////////////////////////////////////////////
	# pages

	function list_pages() {
		return($this->request("pages/all"));
	}

	function create_page($title, $body) {
		return($this->request("pages/new", array("page" => array("title" => $title, "description" => $body))));
	}

	function show_page($page_id) {
		return($this->request("page/".$page_id));
	}

	function destroy_page($page_id) {
		return($this->request("page/".$page_id."/destroy"));
	}

	function update_title($title, $page_id) {
		return($this->request("page/".$page_id."/update_title", array("page" => array("title" => $title))));
	}

	function update_body($body, $page_id) {
		return($this->request("page/".$page_id."/update_body", array("page" => array("description" => $body))));
	}

	function duplicate_page($page_id) {
		return($this->request("page/".$page_id."/duplicate"));
	}

	function link_page($linked_page_id, $page_id) {
		return($this->request("page/".$page_id."/link", array("linked_page_id" => $linked_page_id)));
	}

	function unlink_page($linked_page_id, $page_id) {
		return($this->request("page/".$page_id."/unlink", array("linked_page_id" => $linked_page_id)));
	}

	function email_page($page_id) {
		return($this->request("page/".$page_id."/email"));
	}

	# lists

	function list_items($page_id) {
		return($this->request("page/".$page_id."/items/list"));
	}

	function create_item($content, $page_id) {
		return($this->request("page/".$page_id."/items/add", array("item" => array("content" => $content))));
	}

	function update_item($item_id, $content, $page_id) {
		return($this->request("page/".$page_id."/items/update/".$item_id, array("item" => array("content" => $content))));
	}

	function toggle_item($item_id, $page_id) {
		return($this->request("page/".$page_id."/items/toggle/".$item_id));
	}

	function destroy_item($item_id, $page_id) {
		return($this->request("page/".$page_id."/items/destroy/".$item_id));
	}

	function move_item($item_id, $direction, $page_id) {
		return($this->request("page/".$page_id."/items/move/".$item_id, array("direction" => "move_".$direction)));
	}

	# notes

	function list_notes($page_id) {
		return($this->request("page/".$page_id."/notes/list"));
	}

	function create_note($title, $body, $page_id) {
		return($this->request("page/".$page_id."/notes/create", array("note" => array("title" => $title, "body" => $body))));
	}

	function update_note($note_id, $title, $body, $page_id) {
		return($this->request("page/".$page_id."/notes/update/".$note_id, array("note" => array("title" => $title, "body" => $body))));
	}

	function destroy_note($note_id, $page_id) {
		return($this->request("page/".$page_id."/notes/destroy/".$note_id));
	}

	# tags

	function list_pages_with_tag($tag_id) {
		return($this->request("tags/select/".$tag_id));
	}

	function tag_page($tags, $page_id) {
		return($this->request("page/".$page_id."/tags/tag", array("tags" => implode(" ", $tags))));
	}

	# reminders

	function list_reminders() {
		return($this->request("reminders"));
	}

	function create_reminder($content, $remind_at = "") {
		return($this->request("reminders/create", array("reminder" => array("content" => $content, "remind_at" => $remind_at))));
	}

	function update_reminder($reminder_id, $content, $remind_at = "") {
		return($this->request("reminders/update/".$reminder_id, array("reminder" => array("content" => $content, "remind_at" => $remind_at))));
	}

	function destroy_reminder($reminder_id) {
		return($this->request("reminders/destroy/".$reminder_id));
	}

	# emails

	function list_emails($page_id) {
		return($this->request("page/".$page_id."/emails/list"));
	}

	function show_email($email_id, $page_id) {
		return($this->request("page/".$page_id."/emails/show/".$email_id));
	}

	function destroy_email($email_id, $page_id) {
		return($this->request("page/".$page_id."/emails/destroy/".$email_id));
	}

	# account

	function export_backpack() {
		return($this->request("account/export"));
	}

}

?>
while (<>) {
/\<(belonging id="[0-9]*)"\>\<pos/g && print $1;
}

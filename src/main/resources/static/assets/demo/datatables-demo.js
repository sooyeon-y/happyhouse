// Call the dataTables jQuery plugin
$(document).ready(function() {
  $('#dataTable').DataTable({
	  ordering: true // 기껏 정렬기능 구현해놨는데 이 jQuery DataTable에서 정렬을 제공하는 바람에....
  });
});

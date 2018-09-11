set ${DOLLAR}main_host                   http://${main_host};
set ${DOLLAR}readonly_host               http://${readonly_host};
set ${DOLLAR}readonly_header_host        ${readonly_header_host};
set ${DOLLAR}buildkotlinlang_host        http://${buildkotlinlang_host};
set ${DOLLAR}buildkotlinlang_header_host ${buildkotlinlang_host};

set ${DOLLAR}health_check_content "";
set ${DOLLAR}health_check_content "${DOLLAR}{health_check_content}NGINX_VERSION=${NGINX_VERSION}\n";
set ${DOLLAR}health_check_content "${DOLLAR}{health_check_content}CONTAINER_VERSION=${CONTAINER_VERSION}\n";
set ${DOLLAR}health_check_content "${DOLLAR}{health_check_content}main_host=${main_host}\n";
set ${DOLLAR}health_check_content "${DOLLAR}{health_check_content}readonly_host=${readonly_host}\n";
set ${DOLLAR}health_check_content "${DOLLAR}{health_check_content}buildkotlinlang_host=${buildkotlinlang_host}\n";
set ${DOLLAR}health_check_content "${DOLLAR}{health_check_content}readonly_header_host=${readonly_header_host}\n";
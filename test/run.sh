#!/bin/bash
status=0
container_host="${1:-nginx}"

echo "Testing $container_host host"
# Test /health_check
echo -n "Test: /health_check contains correct nginx version: "
if [[ $(curl -s $container_host/health_check) =~ "NGINX_VERSION=1.13.12" ]]; then
  echo "Success!"
else
  echo "Failed!"; ((status++))
fi
echo -n "Test: /health_check contains correct container version: "
if [[ $(curl -s $container_host/health_check) =~ "CONTAINER_VERSION=test" ]]; then
  echo "Success!"
else
  echo "Failed!"; ((status++))
fi
echo -n "Test: /health_check contains correct main_host: "
if [[ $(curl -s $container_host/health_check) =~ "main_host=httpbin" ]]; then
  echo "Success!"
else
  echo "Failed!"; ((status++))
fi
echo -n "Test: /health_check contains correct readonly_host: "
if [[ $(curl -s $container_host/health_check) =~ "readonly_host=readonly" ]]; then
  echo "Success!"
else
  echo "Failed!"; ((status++))
fi
echo -n "Test: /health_check contains correct buildkotlinlang_host: "
if [[ $(curl -s $container_host/health_check) =~ "buildkotlinlang_host=buildkotlinlang" ]]; then
  echo "Success!"
else
  echo "Failed!"; ((status++))
fi

# This test checks return build.kotlinlang.org when 404 from main
echo -n "Test: 404 must return buildkotlinlang: "
if [[ $(curl -s $container_host/status/404) = "buildkotlinlang" ]]; then
  echo "Success!"
else
  echo "Failed!"; ((status++))
fi
echo -n "Test: 404 must return 200: "
if [[ $(curl -s -o /dev/null -w "%{http_code}" $container_host/status/404) = 200 ]]; then
  echo "Success!"
else
  echo "Failed!"; ((status++))
fi

# This test checks return readonly when [502 503 504] from main
for code in 502 503 504; do
    echo -n "Test: $code must return readonly: "
    if [[ $(curl -s $container_host/status/$code) = "readonly" ]]; then
      echo "Success!"
    else
      echo "Failed!"; ((status++))
    fi
    echo -n "Test: $code must return 200: "
    if [[ $(curl -s -o /dev/null -w "%{http_code}" $container_host/status/$code) = 200 ]]; then
      echo "Success!"
    else
      echo "Failed!"; ((status++))
    fi
done

exit $status
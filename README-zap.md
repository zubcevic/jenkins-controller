# ZAP scan using docker images

## Start docker zap daemon on port 8090

In the example a test is started against something running on the host on port 8080

    docker run -u zap -p 8090:8090 --name zaptest -d owasp/zap2docker-stable zap.sh -daemon -port 8090 -host 0.0.0.0 -config api.disablekey=true
    docker exec zaptest zap-cli start
    docker exec zaptest zap-cli open-url https://www.zubcevic.com
    docker exec zaptest zap-cli quick-scan -s xss,sqli --spider -r https://www.zubcevic.com
    docker exec zaptest zap-cli report -o ZAP_Report.html -f html 
    docker exec zaptest cat ZAP_Report.html > zap.html
    docker exec zaptest zap-cli alerts

However this does noy allow for authentication!

## Use ICTU OWASP ZAP docker image

This one can be used on the Jenkins image:

    docker run --rm -v $(pwd):/zap/wrk/:rw -t ictu/zap2docker-weekly zap-baseline.py -I -j \
      -t http://host.docker.internal:8080 \
      -r testreport.html \
       --hook=/zap/auth_hook.py \
      -z "auth.loginurl=http://host.docker.internal:8080 \
          auth.username="admin" \
          auth.password="password" \
          auth.auto=1"

The report is automatically saved locally on testreport.html.
More on [ZAP ICTU](https://github.com/ICTU/zap-baseline)

## Zap on WebGoat

Start WebGoat

    docker run --name webgoat -d -p 80:8888 -p 8080:8080 -p 9090:9090 -e TZ=Europe/Amsterdam -e EXCLUDE_CATEGORIES="CLIENT_SIDE,GENERAL,CHALLENGE" -e EXCLUDE_LESSONS="SqlInjectionAdvanced,SqlInjectionMitigations" webgoat/goatandwolf:latest

Register a user (admin1/password)

Run a zap baseline test:

    docker run --rm -v $(pwd):/zap/wrk/:rw -t ictu/zap2docker-weekly zap-baseline.py -I -j \
      -t http://host.docker.internal:8080/WebGoat \
      -r webgoat.html \
       --hook=/zap/auth_hook.py \
      -z "auth.loginurl=http://host.docker.internal:8080/WebGoat/login \
          auth.username="admin1" \
          auth.password="password" \
          auth.auto=1" \
          auth.exclude=".*logout.*" 

    docker run --rm -v $(pwd):/zap/wrk/:rw -t ictu/zap2docker-weekly zap-baseline.py -I -j \
      -t http://host.docker.internal:9090/WebWolf \
      -r webwolf.html \
       --hook=/zap/auth_hook.py \
      -z "auth.loginurl=http://host.docker.internal:9090/login \
          auth.username="admin1" \
          auth.password="password" \
          auth.auto=1" \
          auth.exclude=".*logout.*" 

Free JuiceShop training on Veracode community security labs [Veracode](https://securitylabs-ce.veracode.com/)
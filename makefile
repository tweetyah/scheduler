build-service:
	docker build --tag tweetyah-scheduler:latest .

publish-service: build-service
	aws lightsail push-container-image --region us-east-1 --service-name tweetyah-scheduler --label tweetyah-scheduler --image tweetyah-scheduler:latest
	export IMAGE=$(shell aws lightsail get-container-images --service-name tweetyah-scheduler --region us-east-1 | jq '.containerImages[0].image'); \
	aws lightsail create-container-service-deployment \
		--region us-east-1 \
		--service-name tweetyah-scheduler \
		--containers "{\"tweetyah-scheduler\":{\"image\":\"$$IMAGE\"}}" \
		--cli-read-timeout 1

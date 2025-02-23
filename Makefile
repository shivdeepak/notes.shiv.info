build:
	docker build -t jekyll:latest .

run:
	docker run -p 4000:4000 -v $PWD:/app --rm jekyll:latest

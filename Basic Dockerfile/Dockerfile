# Use a minimal base image
FROM alpine:latest

# Copy the script into the image
COPY hello.sh .

# Give execution permissions to the script
RUN chmod +x hello.sh

# Specify the command to run the script
CMD ["./hello.sh"]

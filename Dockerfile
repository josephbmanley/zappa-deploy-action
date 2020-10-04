FROM amazon/aws-cli:latest

LABEL "com.github.actions.name"="Zappa Deploy"
LABEL "com.github.actions.description"="Deploys a Zappa application to AWS"
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="blue"

LABEL repository="https://github.com/josephbmanley/zappa-deploy-action"
LABEL maintainer="Joseph Manley <joseph@cloudsumu.com>"

USER root
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
#########################################################################
#  Subscribe to my custom topic
#########################################################################

$sitename="superusers-kursus-demo-event-grid-2019"

$webhook="https://$sitename.azurewebsites.net/api/updates"

$topicname="superusers-kursus"


az eventgrid event-subscription create `
  -g $RG `
  --topic-name $topicname `
  --name demoViewerSub `
  --endpoint $webhook
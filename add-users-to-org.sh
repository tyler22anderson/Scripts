org=''
github_token=''
for i in `cat user_emails.txt`; do
        username=`echo $i | awk -F['@'] '{print $1}'`
        username=`echo $username | sed -r 's/[.]+/-/g'`
        curl -X PUT \
  https://github.eng.tenable.com/api/v3/orgs/$org/memberships/$username \
  -H 'accept: application/vnd.github.v3+json' \
  -H "authorization: token $github_token" \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json';
done

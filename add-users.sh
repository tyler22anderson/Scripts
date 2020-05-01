#!/bin/bash
github_token=''
generate_post_data()
{
        cat <<EOF
{
        "login": "$username",
        "email": "$email"
}

EOF
}
for i in `cat user_emails.txt`; do
        email=$i
        username=`echo $i | awk -F['@'] '{print $1}'`
        #echo "Email : " $email
        #echo -n "Username : " $username
        curl -X POST \
  https://github.eng.tenable.com/api/v3/admin/users \
  -H 'accept: application/vnd.github.v3+json' \
  -H "authorization: token $github_token" \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d "$(generate_post_data)";
done

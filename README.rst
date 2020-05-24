GitHub EC2 Deploy
=================

This repository is still in progress. I've lost a bit of interest after my project needed
to use ECS instead of CodeDeploy. However, I have detailed some notes on how to manually
start trying stuff out, below.

Deploying Cookiecutter Django to EC2 with AWS CodeDeploy and GitHub actions

:License: BSD

In-Progress Notes
-----------------
Instructions for Deployment of Cookiecutter Django project.

1. Create an AWS account.
2. Make a new IAM role with AdministratorAccess. This IAM role is for yourself and testing on local machine using AWS CLI and the projects.
3. Register for a domain on Route 53.
4. Find ACM (certificate manager) and add your domain and its www. format, as well.
5. Create a new target group in EC2 dashboard. Open it on port 80 (this is for fast communication between ALB and EC2 instances. The reverse nginx proxy will convert it back into HTTPS).
6. Create a new AutoScaling group. Select Create a new launch configuration.
    1. Select whichever image you prefer.
    2. Attach the correct IAM role for your EC2 instances.
    3. Security group only needs HTTP, but you can add both since we can just reuse it for the ALB setup.
    4. Make sure you remember which subnet you’re on (this is the availability zones. If the ALB is not in the same zone as your EC2 instances, you’ll be in trouble).
    5. The VPC/network must be the same, i.e. default.
    6. Make sure in advanced details you add the target group. You do not add ALB here.
7. Back in your target group, you should now see the newly created instances. Register them as targets on port 80.
8. Create a new Application Load Balancer (handles balancing and deployment flawlessly*).
    1. Listeners should include HTTPS, too.
    2. The availability zones at the bottom should match that of the AutoScaling group. Select at least 2.
    3. Choose certificate name (it should include your domain name)
    4. Security group can be the same as the AutoScaling group.
    5. Select your previously made target group.
9. Finally, add your ALB to your domain using A records.
    1. You can find your ALB’s public IP address in EC2 network interfaces.
10. Your DevOps setup is good to go! Your target group will do health checks every 300 seconds, so no worries if you haven’t uploaded your site to the EC2 instances yet.

Some other notes:

I first wanted to use RabbitMQ + Celery for Docker Compose, only to stick with AWS ElastiCache Redis
instead for easy scalability; thus, I'm heading to my other repository that's working on a
cookiecutter-django project for ECS. It's more simple, but the Dockerfile is a little differently
configured.

I will come back to this in the future, but, for now, it's not the time. My next startup will
use the progress done here, but if anyone else would like to help, please do!

AWS Services in Use
-------------------

- 2x EC2 instances
- Elastic Load Balancer (Application Level)
- Route 53 + Certificate Manager
- S3
- Parameter Store

How Does This Work?
-------------------

GitHub actions has really made a difference lately on GitHub, and cookiecutter-django makes and even bigger difference when it comes to deployment.

With this GitHub action, you automatically deploy your code on-push to master branch.

TODO:

With this GitHub action, you add a release to deploy your master branch code.

The other option is to have a "deploy" branch and use `on:push:branches:`.

TODO:

If you use `ActionsPanel`_, all you need to do is login to GitHub, `click on a button`_, and deploy! (We're waiting for GitHub to add this, themselves. I personally use the above method.)

.. _ActionsPanel:https://www.actionspanel.app
.. _click on a button: https://www.actionspanel.app

Although I tried my best to get this to work with my native Django 3.0 chat application, it seems to only work with iOS and Android clients since they have built-in retries on socket disconnect.

Setup
-----

Assuming you've already go a project underway in a GitHub repository...

You'll need your IAM AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY.

1. Go to Github Settings > Secrets.
2. Add your IAM AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
    - Note, you'll never see these again on GitHub.
3.

Notes
-----

My set-up included AWS RDS and AWS ElastiCache with `Chrony`_ on AWS EC2 because I used `Django-cachalot`_ (Disclaimer: I'm a maintainer there).

.. _Chrony: https://aws.amazon.com/blogs/aws/keeping-time-with-amazon-time-sync-service/
.. _Django-cachalot: https://github.com/noripyt/django-cachalot

My Cookiecutter Setup
---------------------

.. code-block:: bash
  project_name [My Awesome Project]: GitHub EC2 Deploy
  project_slug [github_ec2_deploy]:
  description [Behold My Awesome Project!]: Deploying Cookiecutter Django to EC2 with Blue/Green Deployment and GitHub actions
  author_name [Daniel Roy Greenfeld]: Andrew Chen Wang
  domain_name [example.com]: asdfasq.de
  email [andrew-chen-wang@example.com]: acwangpython@gmail.com
  version [0.1.0]:
  Select open_source_license:
  1 - MIT
  2 - BSD
  3 - GPLv3
  4 - Apache Software License 2.0
  5 - Not open source
  Choose from 1, 2, 3, 4, 5 [1]: 2
  timezone [UTC]:
  windows [n]:
  use_pycharm [n]:
  use_docker [n]: y
  Select postgresql_version:
  1 - 11.3
  2 - 10.8
  3 - 9.6
  4 - 9.5
  5 - 9.4
  Choose from 1, 2, 3, 4, 5 [1]:
  Select js_task_runner:
  1 - None
  2 - Gulp
  Choose from 1, 2 [1]:
  Select cloud_provider:
  1 - AWS
  2 - GCP
  3 - None
  Choose from 1, 2, 3 [1]:
  Select mail_service:
  1 - Mailgun
  2 - Amazon SES
  3 - Mailjet
  4 - Mandrill
  5 - Postmark
  6 - Sendgrid
  7 - SendinBlue
  8 - SparkPost
  9 - Other SMTP
  Choose from 1, 2, 3, 4, 5, 6, 7, 8, 9 [1]:
  use_async [n]:
  use_drf [n]: y
  custom_bootstrap_compilation [n]:
  use_compressor [n]:
  use_celery [n]: y
  use_mailhog [n]: y
  use_sentry [n]:
  use_whitenoise [n]:
  use_heroku [n]:
  Select ci_tool:
  1 - None
  2 - Travis
  3 - Gitlab
  Choose from 1, 2, 3 [1]: 2
  keep_local_envs_in_vcs [y]:
  debug [n]:

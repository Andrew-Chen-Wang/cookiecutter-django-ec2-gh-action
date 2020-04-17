GitHub EC2 Deploy
=================

Deploying Cookiecutter Django to EC2 with Blue/Green Deployment and GitHub actions

.. image:: https://img.shields.io/badge/built%20with-Cookiecutter%20Django-ff69b4.svg
     :target: https://github.com/pydanny/cookiecutter-django/
     :alt: Built with Cookiecutter Django
.. image:: https://img.shields.io/badge/code%20style-black-000000.svg
     :target: https://github.com/ambv/black
     :alt: Black code style


:License: BSD

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

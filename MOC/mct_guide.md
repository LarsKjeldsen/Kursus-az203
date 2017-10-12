# GitHub User Guide for MCTs

Cloud services, such as Microsoft Azure, are updated frequently. This leads to issues for Microsoft Certified Trainers (MCTs) when they teach courses, such as *20532: Developing Microsoft Azure Solutions* or *20533: Implementing Microsoft Azure Infrastructure Solutions*, because lab steps change frequently as the service changes. Due to the frequency of the changes and the fact that there may not be any notification when changes occur, it can be difficult for the course development team to rapidly identify and address any lab changes.

To address these issues, we are using GitHub to publish the lab steps and lab scripts for courses that cover cloud services like Azure. Using GitHub allows for collaboration between the course’s authors and MCTs to keep the content current with Azure platform changes. Using GitHub allows the MCTs to provide feedback and suggestions for lab changes, and then the course authors can update lab steps and scripts quickly and relatively easily.

When you prepare to teach these courses, you should ensure that you are using the latest lab steps and scripts by downloading the appropriate files from GitHub.

This user guide is for MCTs who are new to GitHub, and it provides steps for connecting to GitHub, downloading and printing course materials, updating the scripts that students use in labs, and explaining how you can help ensure that this course’s content remains current.

**Note:** It is strongly recommended that MCTs and Partners access these materials and in turn, provide them separately to students. Pointing students directly to GitHub to access Lab steps as part of an ongoing class will require them to access yet another UI as part of the course, contributing to a confusing experience for the student. An explanation to the student regarding why they are receiving separate Lab instructions can highlight the nature of an always-changing cloud-based interface and platform. Microsoft Learning support for accessing files on GitHub and support for navigation of the GitHub site is limited to MCTs teaching this course only.

## GitHub terminology

GitHub introduces terminology that might be new to you, and the following list includes terms and concepts that this document uses. However, for a full list of GitHub terms, refer to the “GitHub Glossary” at <https://help.github.com/articles/GitHub-glossary/>.

  *Git* and *GitHub*: *Git* is an open-source, change-tracking program, and *GitHub* is a site/solution built on Git. There are other websites and solutions that use Git as their backend. You would use GitHub primarily for open-source (public) development projects, and it is free for those projects. However, if you want to use GitHub for projects that are private, and not open source, you must sign up for a paid version.

  *Repo* or *Repository*: Each project in GitHub is in a repository, or *repo*. A repo contains all of a project’s files, including documentation, and it supports revision history. A repository can be public or private, and you can have a local copy of the repo on your computer hard drive, or you can use the repo within GitHub.

  *Markdown*: This is a text-file format that you can use for creating documentation. It is text-based and very simple to update, which makes it easy to use during collaboration. GitHub then renders it as HTML.

  *GitHub flavored markdown (GFM)*: There are many variations, or flavors, of the Markdown file format. The GitHub version, commonly referred to as *GFM*, is one of the most common variations of Markdown. For more information about GFM and how you can use the Markup format for your GFM documents, refer to “Getting started with writing and formatting on GitHub” at https://help.github.com/articles/getting-started-with-writing-and-formatting-on-github/.

  *Fork*: This is a copy of another repo that resides in your GitHub account, in comparison to a *branch*, which lives in the original repo. See “Branch” directly below.

  *Branch*: This is a copy of a repository that resides in the same repository as the original. You can merge a branch with the original.

  *Fetch*: This is the process of retrieving a copy of the latest changes from an online repo. However, a fetch *does not* merge changes.

  *Pull*: This is the process of fetching the latest changes from an online repo and merging them with local changes.

  *Merge*: This is the process of fetching changes from one branch and applying them to another. This includes retrieving changes from an online repo, and then applying them to that repo’s local version.

  *Pull request*: This is a set of proposed changes to a repo that a user submit, and a repo’s owners or collaborators then can accept or reject the pull request.

  *Push*: This is the process of sending or submitting your local changes to the online repo.

  *Collaborator*: This is a GitHub user that has permissions to add, delete, or change a repo’s content.

## Overview of Microsoft Learning's GitHub solution for course labs

The Microsoft Learning team has created a solution that allows them to publish updated lab and lab answer keys (LAKs) and updated lab scripts regularly to GitHub. The solution also includes a script and tools that you can use to print labs and lab answer keys from Microsoft Word .docx files. It is highly recommended that you use the provided Word .docx files instead of building them manually.

### Downloading the latest materials for course labs

The latest lab instructions and AllFiles compressed folder are always available at the following link: <https://github.com/MicrosoftLearning/20532-DevelopingMicrosoftAzureSolutions/releases/latest>

## Receiving update notifications, suggesting changes, and collaborating on projects

You can configure your GitHub experience so that you receive notifications when updates occur to a GitHub repo. There are several ways in which you can sign up for notifications, and many of them relate to the many ways that you can collaborate on a project. To receive notifications, you can:

*Watch repositories*: When you watch a repository, GitHub subscribes you automatically to notifications for any new pull requests or issues that are created for that specific repository. You automatically watch any repository that you create or for which you are a collaborator.

*Pull request*: When you create a pull request, and propose that the owners of a repo accept a change that you make, you automatically subscribe to receive notifications for the related discussion about the pull request. In order to create a Pull request you must first create a branch.

*Comments*: When you make comments about another person’s pull request, GitHub subscribes you automatically to the forum that pertains to that comment, or you can subscribe to the forum manually.

*Issues*: An issue is a suggestion, question, or request that pertains to a repository. Each issue has its own discussion, and you can subscribe to issues, or GitHub subscribes you automatically to issues that you create.

*Mentions*: When another user mentions you in a conversation, using your GitHub user name (@*username*), GitHub subscribes you automatically to the discussion.

You can modify how and when you receive notifications, and you also can unsubscribe to any or all discussions.

### Watching a repo

The simplest way to make sure you know about any changes to a repo is to **watch** it. You can do that, even if you do not clone a local copy of the repo.

To watch a repo, perform the following steps:

1.  <span id="to-watch-a-repository" class="anchor"></span>In Internet Explorer, navigate to the repo on GitHub.

2.  Click **Watch**, and then under **Notifications**, select **Watching**.

To quit watching a repo, perform the following steps:

1.  <span id="to-unwatch-a-repository" class="anchor"></span>In Internet Explorer, navigate to the repo on GitHub.

2.  Click **Watch**, and then under Notifications, select **Not watching**.

> **Note:** You can select the **Ignoring** option under the **Watch** drop-down list. However, this means that you receive *no* notifications, even if another user includes you in a discussion with the mention functionality and your GitHub user name. Therefore, you should be careful configuring the **Ignoring** option.

### Suggesting changes and collaborating on a repo

GitHub makes it easy to collaborate with other Microsoft Learning users on the courses in which you are interested.

You can modify your own copy of the lab materials, and then submit your changes to Microsoft Learning so that they can incorporate your updates. You might want to modify your lab materials if:

You find a mistake in a lab.

The UI has changed since the lab was created.

You think that the lab needs improvements or modifications.

To modify lab materials, you should branch the repo, make updates in your branch, and then submit a pull request to the main (master) branch. This allows Microsoft Learning staff, and other MCTs and GitHub users to review, and comment on, your changes.

You can review and comment on changes that other users make, and Microsoft Learning staff then approves and merges these changes into the master branch. This action notifies any user who is watching the repo that a change has occurred.

#### To create a repo branch:

1.  In Internet Explorer, navigate to the repo on GitHub.

<!-- -->

1.  Click **Branch : *branchname***, and then from the **Branches** list, select the branch you want to copy.

2.  If there is only one branch, the **Branch** drop-down list shows **Branch: master**, and the only branch that is available is **master**.

3.  In the blank text box, type the name of the branch that you want to create.

4.  Click **Create branch: *new branch name*** when it appears.

#### To delete a repo branch:

1.  In Internet Explorer, navigate to the repo on GitHub.

<!-- -->

1.  Click ***n* branches**, where ***n*** is the number of existing branches.

2.  On the **Branches** page, in the row for the branch that you want to delete, click **Delete this branch** icon.

After you have created a Branch, you can clone the files to your local repo, update them on your computer, and then check in the changes from the GitHub Desktop. If you are working with Markdown or other text files, you can edit them in GitHub, and then check in the changes online.

#### To commit changes by using GitHub Desktop:

1.  Open GitHub Desktop.

<!-- -->

1.  Select the repo that contains your changes, and then click **Changes**.

2.  Select the changes that you want to commit, and then in the **Summary** text box, write a short description of the change.

3.  In the **Description** text box, write a more-detailed description of the change, if necessary.

4.  Click **Commit to master**, and then click **Sync** to push the local changes to the online repo.

#### To edit files and commit changes in the online repo:

1.  In Internet Explorer, navigate to the applicable repo on GitHub, and then select the file that you want to edit.

<!-- -->

1.  Click the **Edit this file** icon.

2.  Make your changes in the **Edit file** tab of the webpage, and then click **Preview changes** to view your proposed changes, without committing them.

3.  Under **Commit changes**, in the **Update *filename*** text box, enter a short description of the changes.

4.  In the **Add an optional extended description...** text box, enter a more detailed description of the change, if necessary, and then click **Commit changes**.

#### To create a pull request:

1.  In Internet Explorer, navigate to the applicable repo on GitHub.

<!-- -->

1.  Click **Branch:*branchname***, and then in the **Branches** list, select the branch for which you want to create a pull request.

2.  Click **New pull request**, and then on the **Open a pull request** page, in the **Title** text box, update the name of the pull request, if necessary.

3.  On the **Write** tab, in the **Leave a comment** text box, provide a description of the proposed change, and then click **Create pull request**.

As we noted previously, you also can comment on pull requests and proposed changes (commits) that other users make. When you comment on a commit, you view a source diff of the file, and you then you can comment on specific changes on a line-by-line basis or on the entire commit.

#### To review and comment on a pull request:

1.  In Internet Explorer, navigate to the applicable repo on GitHub.

<!-- -->

1.  Click **Pull requests *n***, where ***n*** is the number of active pull requests.

2.  Select the pull request that you want to review, and then on the **Write** tab, in the **Leave a comment** text box, input your comment.

3.  Click **Comment**.

#### To review and comment on a commit:

1.  In Internet Explorer, navigate to the repo on GitHub.

<!-- -->

1.  Click ***n* commits**, where ***n*** is the number of commits that have been submitted. If you want to review the latest commit, you can select the title/short description of the commit from file list.

2.  In the **source diff** section, select the change on which you want to comment by clicking the plus sign (**+)** that appears when the mouse hovers over the applicable change.

3.  On the **Write** tab, in the **Comment** text box, provide your comment.

4.  Click **Comment**.

    If you wish to provide an overall comment on the commit, under ***n* comments on commit**, where ***n*** is the number of comments submitted, and then under the **Write** tab, in the **Leave a comment** text box, type your comment, and Click **Comment on this commit**.

You also can make suggestions about an overall project, by submitting an Issue or commenting on an existing Issue.

#### To submit an Issue:

1.  In Internet Explorer, navigate to the applicable repo on GitHub.

<!-- -->

1.  Click **Issues**, and then click **New issue**.

2.  In the **Title** text box, enter the title for the issue, and then in the **Leave a comment** text box, type a description of the issue or suggestion.

3.  Click **Submit new issue**.

#### To review and comment on an existing issue:

1.  In Internet Explorer, navigate to the applicable repo on GitHub.

<!-- -->

1.  Click **Issues**, and then select the title of the issue that you want to review.

2.  On the **Issue name** page, on the **Write** tab, in the **Leave a comment** text box, type your comment.

3.  Click **Comment**.

> Whenever you create an issue, or a comment on a pull request or commit, you also can include other GitHub users or teams into the conversation by performing a **mention** of them in the comment’s body. If you are familiar with Twitter, this feature will look very familiar.

#### To mention a GitHub user in a comment:

1.  In Internet Explorer, navigate to the applicable repo on GitHub.

<!-- -->

1.  Create your comment or issue, as described previously, and then in the **comment** text box, type **@**, followed by the user or team name, within the comment.

> > **Note:** When you type the **@** symbol, a list appears that contains GitHub users who are collaborators on the applicable project and anyone who is participating in the project’s comments. The list uses autocomplete as you type, so that you can filter the list easily.

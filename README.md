streamtools Cookbook
====================
downloads and starts streamtools from the specified binary release

Requirements
------------

#### streamtools::default
None.

#### streamtools::source

* [golang](https://github.com/NOX73/chef-golang)

#### streamtools::patterns

* a streamtools pattern, stored in a git repository, any branch

#### streamtools::monit

* the monit cookbook in the node's runlist

Attributes
----------

#### streamtools::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['streamtools']['version']</tt></td>
    <td>String</td>
    <td>what version to install</td>
    <td><tt>0.1.2</tt></td>
  </tr>
</table>

#### streamtools::source
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['streamtools']['repository']</tt></td>
    <td>String</td>
    <td>streamtools git repo</td>
    <td><tt>https://github.com/nytlabs/streamtools.git</tt></td>
  </tr>
  <tr>
    <td><tt>['streamtools']['branch']</tt></td>
    <td>String</td>
    <td>git branch</td>
    <td><tt>master</tt></td>
  </tr>
</table>

#### streamtools::patterns

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['streamtools']['patterns_repository']</tt></td>
    <td>String</td>
    <td>streamtools patterns git repo</td>
    <td><tt>''</tt> (none)</td>
  </tr>
  <tr>
    <td><tt>['streamtools']['patterns_branch']</tt></td>
    <td>String</td>
    <td>git branch</td>
    <td><tt>master</tt></td>
  </tr>
  <tr>
    <td><tt>['streamtools']['pattern_file']</tt></td>
    <td>String</td>
    <td>path to file containing pattern json in the git repo</td>
    <td><tt>''</tt> (none)</td>
  </tr>
  <tr>
    <td><tt>['streamtools']['patterns_directory']</tt></td>
    <td>String</td>
    <td>path to clone patterns repo on the node</td>
    <td><tt>/home/ubuntu/streamtools-patterns</tt></td>
  </tr>
</table>

Usage
-----
#### streamtools::default

Just include `streamtools` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[streamtools]"
  ]
}
```

#### streamtools::source

Your server should have a working go installation. The [golang](https://github.com/NOX73/chef-golang) cookbook works well for this. Include the recipe for `streamtools::source` - and optionally `golang` - in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[golang]",
    "recipe[streamtools::source]"
  ]
}
```

Examples
--------

#### latest streamtools running on port 7070

```json
{
  "name": "your_server",
  "chef_environment": "_default",
  "normal": {
    "tags": [ ],  
    "streamtools": {
      "repository": "https://github.com/nytlabs/streamtools.git",
      "branch": "master"
    }
  },  
  "run_list": [
    "recipe[streamtools::source]"
  ]
}

```

#### latest streamtools running on port 7070 with a pattern

```json
{
  "name": "your_server",
  "chef_environment": "_default",
  "normal": {
    "tags": [ ],  

    "streamtools": {
      "repository": "https://github.com/nytlabs/streamtools.git",
      "branch": "master"
      "patterns_repository": "https://github.com/YOU/PATTERN_REPO.git",
      "patterns_branch": "master",
      "pattern_file": "YOURPATTERN.json"
    }
  },  
  "run_list": [
    "recipe[streamtools::source]",
    "recipe[streamtools::patterns]”
  ]
}
```

#### latest streamtools with nginx reverse proxy to port 80 with a pattern

```json
{
  "name": "your_server",
  "chef_environment": "_default",
  "normal": {
    "tags": [ ],  

    "streamtools": {
      "repository": "https://github.com/nytlabs/streamtools.git",
      "branch": "master"
    },  
    "nginx": {
      "default_site_enabled": false,
      "binary": "/opt/nginx-1.4.4/sbin/nginx",
      "daemon_disable": true,
      "src_binary": "/opt/nginx-1.4.4/sbin/nginx"
    }   
  },  
  "run_list": [
    "recipe[streamtools::source]",
    "recipe[nginx::source]",
    "recipe[streamtools::nginx]"
  ]
}
```

License and Authors
-------------------
Authors: TODO: List authors

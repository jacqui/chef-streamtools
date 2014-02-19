streamtools Cookbook
====================
downloads and starts streamtools from the specified binary release

Requirements
------------

#### streamtools::default
None.

#### streamtools::source

* [golang](https://github.com/NOX73/chef-golang)

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
License and Authors
-------------------
Authors: TODO: List authors

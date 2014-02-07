streamtools Cookbook
====================
downloads and starts streamtools from the specified binary release

Requirements
------------
None, apparently.

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

License and Authors
-------------------
Authors: TODO: List authors

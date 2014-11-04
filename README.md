# pe_ca_proxy

This module is a stop-gap solution for setting up CA proxying in PE
3.7.0 until full support is added to a future release. The PuppetServer
project already has proper support, this simply actiavtes it.

## Usage

Making use of this module is rather simple. There is only one main
class, `pe_ca_proxy`, and it only has one required parameter,
`proxy_target`.

The best suggested usage is to create a new group in the PE Node
Classifier called "PE Certificate Authority Proxy", add the
`pe_ca_proxy` class to it, and set the `proxy_target` parameter. Then
pin the "compile only" (or spoke) masters to this group.

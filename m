Received: from eggs.gnu.org ([2001:4830:134:3::10]:37567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1ebWGL-00048x-QY
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:47:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1ebWGH-0007tA-QG
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:47:09 -0500
Received: from mail-bn3nam01on0110.outbound.protection.outlook.com
	([104.47.33.110]:19460
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juterry@microsoft.com>)
	id 1ebWGH-0007sm-Gs
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:47:05 -0500
From: "Justin Terry (VM)" <juterry@microsoft.com>
Date: Tue, 16 Jan 2018 18:46:31 +0000
Message-ID: <CY4PR2101MB086614CE88B48D849D106664B6EA0@CY4PR2101MB0866.namprd21.prod.outlook.com>
References: <1515788548-3570-1-git-send-email-juterry@microsoft.com>
	<129c0f17-ada9-92ce-eb0d-1596da397638@weilnetz.de>
	<bedf8b0d-e6fd-103a-5e6f-4b25464a1368@weilnetz.de>
In-Reply-To: <bedf8b0d-e6fd-103a-5e6f-4b25464a1368@weilnetz.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/4] Implements the Windows Hypervisor
 Platform accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "crosthwaite.peter@gmail.com" <crosthwaite.peter@gmail.com>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>

SGV5IFN0ZWZhbiwNCg0KQWdhaW4gdGhhbmtzIGZvciB0aGUgZmVlZGJhY2suIFRoZSBzaG9ydCBh
bnN3ZXIgaXMgdGhhdCBpdCB3aWxsIGJlIGZpcnN0IGF2YWlsYWJsZSBvbiBhbiBXaW5kb3dzIDEw
IEluc2lkZXIgUHJldmlldyByZWxlYXNlOiBodHRwczovL3d3dy5taWNyb3NvZnQuY29tL2VuLXVz
L3NvZnR3YXJlLWRvd25sb2FkL3dpbmRvd3NpbnNpZGVycHJldmlld1NESy4gSSBqdXN0IGRvbuKA
mXQga25vdyB3aGljaCBvbmUgZXhhY3RseS4gV2hlbiB0aGlzIGlzIHJlbGVhc2VkIEkgd2lsbCBm
b3Igc3VyZSB1cGRhdGUgdGhlIGNvbW11bml0eSB0aGF0IGl0IGlzIG5vdyBhdmFpbGFibGUgZm9y
IGJ1aWxkaW5nIGFuZCB0ZXN0aW5nLg0KDQpXaGVuIHlvdSBzYXkgImVuaGFuY2luZyB0aGUgYnVp
bGQgaW5zdHJ1Y3Rpb25zIGZvciBRRU1VIiBkbyB5b3UgbWVhbiBoYXZpbmcgYW4gZW50cnkgb24g
dGhlIHdpa2kgZGVzY3JpYmluZyBjcm9zcyBjb21waWxpbmcgb24gV2luZG93cz8gSSB3b3VsZCBi
ZSBoYXBweSB0byBhZGQgdG8gdGhhdCB3aWtpIHBhZ2UgZGVzY3JpYmluZyB3aGF0IHdlIGRvIG5v
dy4gQ291bGQgeW91IGdpdmUgbWUgYSBwb2ludGVyIG9uIHdoZXJlIHlvdSBrZWVwIHRoZSB3aWtp
IGNvZGUgc28gSSBjYW4gYWRkIHRoZSBkZXNjcmlwdGlvbnMgdGhlcmU/DQoNClRoYW5rcywNCkp1
c3Rpbg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN0ZWZhbiBXZWls
IFttYWlsdG86c3dAd2VpbG5ldHouZGVdDQo+IFNlbnQ6IEZyaWRheSwgSmFudWFyeSAxMiwgMjAx
OCAyOjA2IFBNDQo+IFRvOiBKdXN0aW4gVGVycnkgKFZNKSA8anV0ZXJyeUBtaWNyb3NvZnQuY29t
PjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwYm9uemluaUByZWRoYXQuY29tOyBjcm9z
dGh3YWl0ZS5wZXRlckBnbWFpbC5jb207DQo+IGVoYWJrb3N0QHJlZGhhdC5jb207IHJ0aEB0d2lk
ZGxlLm5ldA0KPiBTdWJqZWN0OiBSZTogW1FlbXUtZGV2ZWxdIFtQQVRDSCAwLzRdIEltcGxlbWVu
dHMgdGhlIFdpbmRvd3MgSHlwZXJ2aXNvcg0KPiBQbGF0Zm9ybSBhY2NlbGVyYXRvcg0KPiANCj4g
QW0gMTIuMDEuMjAxOCB1bSAyMjo1NyBzY2hyaWViIFN0ZWZhbiBXZWlsOg0KPiA+PiBPdmVyIHRo
ZSBuZXh0IGZldyBkYXlzIHRoZSBwcmUtcmVsZWFzZSB2ZXJzaW9uIG9mIHRoZSBkb2N1bWVudGF0
aW9uDQo+ID4+IGZvciB0aGlzIG5ldyBBUEkgd2lsbCBiZSB2aXNpYmxlIGF0DQo+ID4+DQo+IGh0
dHBzOi8vbmEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNB
JTJGJTJGZG9jcw0KPiA+PiAubWljcm9zb2Z0LmNvbSUyRmVuLQ0KPiB1cyUyRnZpcnR1YWxpemF0
aW9uJmRhdGE9MDIlN0MwMSU3Q2p1dGVycnklNDBtaWNyb3NvZnQuY29tJTdDNzM2NDEzDQo+IDVm
ODI3ZTQ2OGZhMTAxMDhkNTVhMDhhNjY3JTdDNzJmOTg4YmY4NmYxNDFhZjkxYWIyZDdjZDAxMWRi
NDclN0MxDQo+ICU3QzElN0M2MzY1MTM5MTU4NjU1NDQwNDQmc2RhdGE9Q0dnZjJxVkJGVUFpNFVD
ZkJFbVR2clJiOEJEN1FHDQo+IGtLeXRrWnloUkNvaDQlM0QmcmVzZXJ2ZWQ9MCB1bmRlciB0aGUg
J1dpbmRvd3MgSHlwZXJ2aXNvciBQbGF0Zm9ybScNCj4gc2VjdGlvbi4gSGVyZSB5b3Ugd2lsbCBz
ZWUgdGhlIHJlcXVpcmVtZW50cywgQVBJLCBhbmQgZXhhbXBsZXMuDQo+IA0KPiBQbGVhc2UgaW5m
b3JtIHRoZSBxZW11LWRldmVsIGxpc3Qgd2hlbiB0aGUgcmVxdWlyZWQgZmlsZXMgZm9yIGJ1aWxk
aW5nIGFyZQ0KPiBhdmFpbGFibGUuDQo+IA0KPiBGb3Igbm93LCBidWlsZGluZyBmYWlsczoNCj4g
DQo+ICQgLi4vY29uZmlndXJlIC0tZW5hYmxlLXdocHgNCj4gDQo+IEVSUk9SOiBVc2VyIHJlcXVl
c3RlZCBmZWF0dXJlIHdpbmh2cGxhdGZvcm0NCj4gICAgICAgIGNvbmZpZ3VyZSB3YXMgbm90IGFi
bGUgdG8gZmluZCBpdC4NCj4gICAgICAgIHdpbmh2ZW11bGF0aW9uIGlzIG5vdCBpbnN0YWxsZWQN
Cj4gDQo+IEVuaGFuY2luZyB0aGUgYnVpbGQgaW5zdHJ1Y3Rpb25zIGZvciBRRU1VIHdvdWxkIGFs
c28gYmUgYSBnb29kIGlkZWEgdGhlbi4NCj4gDQo+IFRoYW5rcywNCj4gU3RlZmFuDQo=

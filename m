Received: from eggs.gnu.org ([2001:4830:134:3::10]:36152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1exx39-0004Ry-Bz
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1exx35-0004nh-Gy
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:50:14 -0400
Received: from smtp62.cstnet.cn ([159.226.251.62]:54238 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1exx34-0004hj-SP
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:50:11 -0400
Date: Mon, 19 Mar 2018 23:50:04 +0800 (GMT+08:00)
From: "Su Hang" <suhang16@mails.ucas.ac.cn>
In-Reply-To: <938b752e-770a-b8d2-d51f-55ef412973ae@redhat.com>
References: <1521467768-3162-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<938b752e-770a-b8d2-d51f-55ef412973ae@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7418224b.50843.1623ef40f1a.Coremail.suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH RFC] scripts/checkpatch.pl: Bug fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric blake <eblake@redhat.com>
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiRXJpYyBCbGFrZSIgPGVibGFr
ZUByZWRoYXQuY29tPgo+IFNlbnQgVGltZTogMjAxOC0wMy0xOSAyMzoyNToyMCAoTW9uZGF5KQo+
IFRvOiAiU3UgSGFuZyIgPHN1aGFuZzE2QG1haWxzLnVjYXMuYWMuY24+LCB2c2VtZW50c292QHZp
cnR1b3p6by5jb20KPiBDYzogcWVtdS1kZXZlbEBub25nbnUub3JnCj4gU3ViamVjdDogUmU6IFtR
ZW11LWRldmVsXSBbUEFUQ0ggUkZDXSBzY3JpcHRzL2NoZWNrcGF0Y2gucGw6IEJ1ZyBmaXgKCj4g
SGF2aW5nIHRoZSBjb21taXQgbWVzc2FnZSBwb2ludCB0byB0aGUgY29tbWl0IGlkIHRoYXQgaW50
cm9kdWNlZCB0aGUgYnVnIAo+IGlzIHVzZWZ1bC4gIFRoZSBncmFtbWFyIGlzIGF3a3dhcmQgKGl0
IHNvdW5kcyBsaWtlIHRoZSBidWcgaXMgdGhhdCAKPiBjaGVja3BhdGNoLnBsIHN0b3BwZWQgY29t
cGxhaW5pbmcgYWJvdXQgdGhlIHBhdHRlcm4sIHNvIHRoZSBmaXggaXMgdG8gCj4gcmVpbnN0YXRl
IHRoZSBjb21wbGFpbnQpOyBiZXR0ZXIgbWlnaHQgYmU6Cj4gCj4gQ29tbWl0IFhZWiBpbnRyb2R1
Y2VkIGEgcmVncmVzc2lvbjogY2hlY2twYXRjaC5wbCBzdGFydGVkIGNvbXBsYWluaW5nIAo+IGFi
b3V0IHRoZSBmb2xsb3dpbmcgdmFsaWQgcGF0dGVybjoKPiBkbyB7Cj4gICAgICAvKiBzb21ldGhp
bmcgKi8KPiB9IHdoaWxlIChjb25kaXRpb24pOwo+IAo+IEZpeCB0aGUgc2NyaXB0IHRvIG9uY2Ug
YWdhaW4gcGVybWl0IHRoaXMgcGF0dGVybi4KClRoYW5rIHlvdSBmb3IgY29ycmVjdGluZyBteSBt
aXN0YWtlcy4gOi0pCgo+IElzIHRoaXMgYW4gdXBkYXRlZCByZXZpc2lvbiB0byBhIHBhdGNoIHBv
c3RlZCBlYXJsaWVyPyAgSWYgc28sIGluY2x1ZGluZyAKPiAndjInIGluIHRoZSBzdWJqZWN0IGxp
bmUgKGVhc3kgaWYgeW91IHVzZSAnZ2l0IGZvcm1hdC1wYXRjaCAtdjInIG9yICdnaXQgCj4gc2Vu
ZC1lbWFpbCAtdjInKSwgYW5kIHRoZW4gdXNpbmcgdGhpcyBzcGFjZSBhZnRlciB0aGUgLS0tIHNl
cGFyYXRvciB0byAKPiBkZXNjcmliZSB3aGF0IGNoYW5nZWQgc2luY2UgdjEsIG1ha2VzIGxpZmUg
ZWFzaWVyIGZvciByZXZpZXdlcnMuCgpZZXMsIGl0J3MgYW4gdXBkYXRlZCByZXZpc2lvbiB0byBh
IGVhcmxpZXIgcGF0Y2guCkJ1dCBJIHdhc24ndCBhYm91dCBzZW5kaW5nIGl0LCB3aGVuIEkgd2Fz
IHVzaW5nIFtjdHJsICsgcl0gYW5kIFtlbnRlcl0sCkkgc2VuZCBpdCBhY2NpZGVudGFsbHkuCgpU
aGFua3MgZm9yIHlvdXIga2luZCBzdWdnZXN0aW9uLgoKQmVzdCwKU3UgSGFuZw==

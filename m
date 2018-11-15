Received: from eggs.gnu.org ([2001:4830:134:3::10]:52736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gNErR-0004VC-E8
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:26:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gNErN-00088u-DC
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:26:57 -0500
Resent-Message-Id: <E1gNErN-00088u-DC@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gNErM-0007xy-MQ
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:26:53 -0500
In-Reply-To: <20181114233831.10374-1-ehabkost@redhat.com>
Message-ID: <154227124289.21.12980929179950133314@c26723477dc9>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 15 Nov 2018 00:40:45 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2] virtio: Provide
 version-specific variants of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com
Cc: famz@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, kwolf@redhat.comfamz@redhat.com, laine@redhat.com, amit@kernel.org, libvir-list@redhat.com, armbru@redhat.com, jasowang@redhat.com, cohuck@redhat.com, stefanha@redhat.com, abologna@redhat.com, wainersm@redhat.com, mreitz@redhat.com, ccarrara@redhat.com, arei.gonglei@huawei.com, kraxel@redhat.com, crosa@redhat.com, pbonzini@redhat.com, philmd@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAx
ODExMTQyMzM4MzEuMTAzNzQtMS1laGFia29zdEByZWRoYXQuY29tClR5cGU6IHNlcmllcwpTdWJq
ZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIGZvci00LjAgdjJdIHZpcnRpbzogUHJvdmlkZSB2ZXJz
aW9uLXNwZWNpZmljIHZhcmlhbnRzIG9mIHZpcnRpbyBQQ0kgZGV2aWNlcwoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cg
LS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KCmNvbW1pdHM9IiQoZ2l0
IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBk
bwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZv
cm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9z
Y3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEK
ICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09
IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3
ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwoyMDMzMmFmIHZp
cnRpbzogUHJvdmlkZSB2ZXJzaW9uLXNwZWNpZmljIHZhcmlhbnRzIG9mIHZpcnRpbyBQQ0kgZGV2
aWNlcwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8xOiB2aXJ0aW86IFBy
b3ZpZGUgdmVyc2lvbi1zcGVjaWZpYyB2YXJpYW50cyBvZiB2aXJ0aW8gUENJIGRldmljZXMuLi4K
V0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVS
UyBuZWVkIHVwZGF0aW5nPwojNjY4OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCkVSUk9SOiBsaW5l
IG92ZXIgOTAgY2hhcmFjdGVycwojNzI0OiBGSUxFOiB0ZXN0cy9hY2NlcHRhbmNlL3ZpcnRpb192
ZXJzaW9uLnB5OjUyOgorICAgIHJldHVybiBkZXZ0eXBlIGluIFtkWyduYW1lJ10gZm9yIGQgaW4g
dm0uY29tbWFuZCgncW9tLWxpc3QtdHlwZXMnLCBpbXBsZW1lbnRzPWltcGxlbWVudHMpXQoKRVJS
T1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM3MjY6IEZJTEU6IHRlc3RzL2FjY2VwdGFuY2Uv
dmlydGlvX3ZlcnNpb24ucHk6NTQ6CitkZWYgZ2V0X2ludGVyZmFjZXModm0sIGRldnR5cGUsIGlu
dGVyZmFjZXM9WydwY2ktZXhwcmVzcy1kZXZpY2UnLCAnY29udmVudGlvbmFsLXBjaS1kZXZpY2Un
XSk6CgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojNzgwOiBGSUxFOiB0ZXN0cy9h
Y2NlcHRhbmNlL3ZpcnRpb192ZXJzaW9uLnB5OjEwODoKKyAgICAgICAgZGV2XzFfMCxudF9pZmFj
ZXMgPSBzZWxmLnJ1bl9kZXZpY2UoJyVzLW5vbi10cmFuc2l0aW9uYWwnICUgKHFlbXVfZGV2dHlw
ZSkpCgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojODA0OiBGSUxFOiB0ZXN0cy9h
Y2NlcHRhbmNlL3ZpcnRpb192ZXJzaW9uLnB5OjEzMjoKKyAgICAgICAgZGV2X3RyYW5zLHRyYW5z
X2lmYWNlcyA9IHNlbGYucnVuX2RldmljZSgnJXMtdHJhbnNpdGlvbmFsJyAlIChxZW11X2RldnR5
cGUpKQoKdG90YWw6IDIgZXJyb3JzLCAzIHdhcm5pbmdzLCA3MzIgbGluZXMgY2hlY2tlZAoKWW91
ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhl
c2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWlu
ZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpU
ZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0
b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

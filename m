Received: from eggs.gnu.org ([2001:4830:134:3::10]:40547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1cjU6J-00054Q-7R
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 12:01:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1cjU6G-0004Ph-Lk
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 12:01:11 -0500
Received: from mail-sn1nam01on0094.outbound.protection.outlook.com
	([104.47.32.94]:24677
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1cjU6G-0004OR-9n
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 12:01:08 -0500
From: Felipe Franciosi <felipe@nutanix.com>
Date: Thu, 2 Mar 2017 17:01:06 +0000
Message-ID: <F9FA9F92-B44C-401D-A892-D73D36777B47@nutanix.com>
References: <1488472983-9108-1-git-send-email-felipe@nutanix.com>
	<148847375468.285.999031041241417996@0e2666bad730>
In-Reply-To: <148847375468.285.999031041241417996@0e2666bad730>
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FA1F5BA6B3C8A418A0772BA4A5697F8@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 0/3] Introduce vhost-user-scsi and
 sample application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "famz@redhat.com" <famz@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

SGkgRXJpYywNCg0KUGluZyBvbiB0aGlzPw0KaHR0cDovL2xpc3RzLm5vbmdudS5vcmcvYXJjaGl2
ZS9odG1sL3FlbXUtZGV2ZWwvMjAxNi0xMC9tc2cwNjE2OS5odG1sDQoNCkYuDQoNCk9uIDAyLzAz
LzIwMTcsIDE2OjU1LCAiUWVtdS1kZXZlbCBvbiBiZWhhbGYgb2Ygbm8tcmVwbHlAcGF0Y2hldy5v
cmciIDxxZW11LWRldmVsLWJvdW5jZXMrZmVsaXBlPW51dGFuaXguY29tQG5vbmdudS5vcmcgb24g
YmVoYWxmIG9mIG5vLXJlcGx5QHBhdGNoZXcub3JnPiB3cm90ZToNCg0KICAgIEhpLA0KICAgIA0K
ICAgIFRoaXMgc2VyaWVzIGZhaWxlZCBidWlsZCB0ZXN0IG9uIHMzOTB4IGhvc3QuIFBsZWFzZSBm
aW5kIHRoZSBkZXRhaWxzIGJlbG93Lg0KICAgIA0KICAgIFR5cGU6IHNlcmllcw0KICAgIFN1Ympl
Y3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjQgMC8zXSBJbnRyb2R1Y2Ugdmhvc3QtdXNlci1zY3Np
IGFuZCBzYW1wbGUgYXBwbGljYXRpb24NCiAgICBNZXNzYWdlLWlkOiAxNDg4NDcyOTgzLTkxMDgt
MS1naXQtc2VuZC1lbWFpbC1mZWxpcGVAbnV0YW5peC5jb20NCiAgICANCiAgICA9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09DQrigKYNCuKApg0KICAgICAgQ0MgICAgICBjb250cmliL3Zob3N0LXVz
ZXItc2NzaS92aG9zdC11c2VyLXNjc2kubw0KICAgICAgQ0MgICAgICBjb250cmliL2xpYnZob3N0
LXVzZXIvbGlidmhvc3QtdXNlci5vDQogICAgICBDQyAgICAgIGNvbnRyaWIvaXZzaG1lbS1jbGll
bnQvaXZzaG1lbS1jbGllbnQubw0KICAgICAgQ0MgICAgICBjb250cmliL2l2c2htZW0tY2xpZW50
L21haW4ubw0KICAgIC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1uYXh1eV9rdS9zcmMvY29u
dHJpYi9saWJ2aG9zdC11c2VyL2xpYnZob3N0LXVzZXIuYzogSW4gZnVuY3Rpb24g4oCYdnVfcGFu
aWPigJk6DQogICAgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLW5heHV5X2t1L3NyYy9jb250
cmliL2xpYnZob3N0LXVzZXIvbGlidmhvc3QtdXNlci5jOjg0OjU6IGVycm9yOiBpZ25vcmluZyBy
ZXR1cm4gdmFsdWUgb2Yg4oCYdmFzcHJpbnRm4oCZLCBkZWNsYXJlZCB3aXRoIGF0dHJpYnV0ZSB3
YXJuX3VudXNlZF9yZXN1bHQgWy1XZXJyb3I9dW51c2VkLXJlc3VsdF0NCiAgICAgICAgICh2b2lk
KXZhc3ByaW50ZigmYnVmLCBtc2csIGFwKTsNCiAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fg0KICAgIGNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3Jz
DQogICAgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLW5heHV5X2t1L3NyYy9ydWxlcy5tYWs6
Njk6IHJlY2lwZSBmb3IgdGFyZ2V0ICdjb250cmliL2xpYnZob3N0LXVzZXIvbGlidmhvc3QtdXNl
ci5vJyBmYWlsZWQNCiAgICBtYWtlOiAqKiogW2NvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9z
dC11c2VyLm9dIEVycm9yIDENCiAgICBtYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBq
b2JzLi4uLg0KICAgID09PSBPVVRQVVQgRU5EID09PQ0KICAgIA0KICAgIFRlc3QgY29tbWFuZCBl
eGl0ZWQgd2l0aCBjb2RlOiAyDQogICAgDQogICAgDQogICAgLS0tDQogICAgRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uDQogICAg
UGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQGZyZWVsaXN0cy5vcmcN
Cg0K

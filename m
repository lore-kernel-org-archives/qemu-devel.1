Received: from eggs.gnu.org ([209.51.188.92]:34325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcAx-0002jy-7w
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcAr-0005yR-V1
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:28:34 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Tue, 30 Apr 2019 23:28:11 +0000
Message-ID: <cover.1556666645.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <65FD29ACA569E7458772696939AF5CB4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 0/5]  Fix some GCC 9 build warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "kraxel@redhat.com" <kraxel@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "laurent@vivier.eu" <laurent@vivier.eu>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>

djI6DQogLSBSZXdyaXRlIG1vc3QgcGF0Y2hlcyBiYXNlZCBvbiB0aGUgZmVlZGJhY2sgZnJvbSB2
MQ0KDQpBbGlzdGFpciBGcmFuY2lzICg1KToNCiAgdXRpbC9xZW11LXNvY2tldHM6IEZpeCBHQ0Mg
OSBidWlsZCB3YXJuaW5ncw0KICBody91c2IvaGNkLXhoY2k6IEZpeCBHQ0MgOSBidWlsZCB3YXJu
aW5nDQogIGh3L3VzYi9kZXYtbXRwOiBGaXggR0NDIDkgYnVpbGQgd2FybmluZw0KICBsaW51eC11
c2VyL3VuYW1lOiBGaXggR0NDIDkgYnVpbGQgd2FybmluZ3MNCiAgbGludXgtdXNlci9lbGZsb2Fk
OiBGaXggR0NDIDkgYnVpbGQgd2FybmluZ3MNCg0KIGh3L3VzYi9kZXYtbXRwLmMgICAgIHwgMTMg
KysrKysrKysrKysrKw0KIGh3L3VzYi9oY2QteGhjaS5jICAgIHwgIDEgKw0KIGxpbnV4LXVzZXIv
ZWxmbG9hZC5jIHwgIDIgKy0NCiBsaW51eC11c2VyL3VuYW1lLmMgICB8ICAyICstDQogdXRpbC9x
ZW11LXNvY2tldHMuYyAgfCAgNCArKy0tDQogNSBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMjEuMA0KDQo=

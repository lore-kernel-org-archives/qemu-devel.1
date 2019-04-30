Received: from eggs.gnu.org ([209.51.188.92]:49100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ3k-0002KV-7w
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ3j-0006zI-C6
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:09:00 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Tue, 30 Apr 2019 20:08:48 +0000
Message-ID: <cover.1556650594.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A8AA2ACCF27F947A1EDB119EA6FF4F9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 0/5]  Fix some GCC 9 build warnings
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

DQpBbGlzdGFpciBGcmFuY2lzICg1KToNCiAgdXRpbC9xZW11LXNvY2tldHM6IEZpeCBHQ0MgOSBi
dWlsZCB3YXJuaW5ncw0KICBody91c2IvaGNkLXhoY2k6IEZpeCBHQ0MgOSBidWlsZCB3YXJuaW5n
DQogIGh3L3VzYi9kZXYtbXRwOiBGaXggR0NDIDkgYnVpbGQgd2FybmluZw0KICBsaW51eC11c2Vy
L3VuYW1lOiBGaXggR0NDIDkgYnVpbGQgd2FybmluZ3MNCiAgbGludXgtdXNlci9lbGZsb2FkOiBG
aXggR0NDIDkgYnVpbGQgd2FybmluZ3MNCg0KIGh3L3VzYi9kZXYtbXRwLmMgICAgIHwgMTMgKysr
KysrKysrKysrKw0KIGh3L3VzYi9oY2QteGhjaS5oICAgIHwgIDIgKy0NCiBsaW51eC11c2VyL2Vs
ZmxvYWQuYyB8ICA0ICsrLS0NCiBsaW51eC11c2VyL3VuYW1lLmMgICB8ICA4ICsrKysrKysrDQog
dXRpbC9xZW11LXNvY2tldHMuYyAgfCAgNCArKy0tDQogNSBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNl
cnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMjEuMA0KDQo=

Received: from eggs.gnu.org ([2001:4830:134:3::10]:47937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbates@raithlin.com>) id 1gAILY-0004uR-Hu
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbates@raithlin.com>) id 1gAILU-0008SE-I7
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:32:32 -0400
Received: from mail-eopbgr670135.outbound.protection.outlook.com
	([40.107.67.135]:27975
	helo=CAN01-TO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbates@raithlin.com>) id 1gAILU-0008Pm-AH
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:32:28 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
Date: Wed, 10 Oct 2018 17:32:25 +0000
Message-ID: <5A5F4A2B-2DAF-4D70-BF1D-7ABC8461FDC8@raithlin.com>
References: <cover.1538683492.git.alistair.francis@wdc.com>
	<5dd21056229d12a1af8d65e9208f4de43ba4a2ae.camel@redhat.com>
	<3F86795E-6F41-4C86-91C6-21E8312F5E4B@eideticom.com>
	<a9cf5e6c09eed752b123d5de842bdc3264e37117.camel@redhat.com>
In-Reply-To: <a9cf5e6c09eed752b123d5de842bdc3264e37117.camel@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2B95F93D65DEC4EAE836F0E89D60AE0@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 0/5] Connect a PCIe host and graphics
 support to RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mjc@sifive.com" <mjc@sifive.com>
Cc: Keith Busch <keith.busch@intel.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "palmer@sifive.com" <palmer@sifive.com>, "Richard
	W.M. Jones" <rjones@redhat.com>

Pj4gSSBwbGFuIHRvIGFsc28gdHJ5IHdpdGggYSBlMTAwMCBuZXR3b3JrIGludGVyZmFjZSBtb2Rl
bCB0b21vcnJvdyBhbmQgc2VlIGhvdyB0aGF0IGJlaGF2ZXMuLi4uDQo+ICAgDQo+ICAgIFBsZWFz
ZSBkbyA6KQ0KICAgIA0KSSBhZGRlZCBlMTAwMCBhbmQgZTEwMDBlIHN1cHBvcnQgdG8gbXkga2Vy
bmVsIGFuZCBjaGFuZ2VkIHRoZSBRRU1VIGNvbW1hbmQgdG86DQoNCiRRRU1VIC1ub2dyYXBoaWMg
XA0KICAgICAgLW1hY2hpbmUgdmlydCBcDQogICAgICAtc21wIDEgLW0gOEcgXA0KICAgICAgLWFw
cGVuZCAiY29uc29sZT1odmMwIHJvIHJvb3Q9L2Rldi92ZGEgbnZtZS5hZG1pbl90aW1lb3V0PTEi
IFwNCiAgICAgIC1rZXJuZWwgJEtFUk5FTCBcDQogICAgICAtZHJpdmUgZmlsZT0ke1JPT1RGU30s
Zm9ybWF0PXJhdyxpZD1oZDAgXA0KICAgICAgLWRldmljZSB2aXJ0aW8tYmxrLWRldmljZSxkcml2
ZT1oZDAgXA0KICAgICAgLWRldmljZSB2aXJ0aW8tbmV0LWRldmljZSxuZXRkZXY9bmV0MCBcDQog
ICAgICAtbmV0ZGV2IHVzZXIsaWQ9bmV0MCBcDQogICAgICAtZGV2aWNlIGUxMDAwLG5ldGRldj1u
ZXQxIFwNCiAgICAgIC1uZXRkZXYgdXNlcixpZD1uZXQxDQoNCkFuZCB0aGUga2VybmVsIG9vb3Bz
Og0KDQpbICAgIDAuMjI0MDAwXSBlMTAwMDogSW50ZWwoUikgUFJPLzEwMDAgTmV0d29yayBEcml2
ZXIgLSB2ZXJzaW9uIDcuMy4yMS1rOC1OQVBJDQpbICAgIDAuMjI0MDAwXSBlMTAwMDogQ29weXJp
Z2h0IChjKSAxOTk5LTIwMDYgSW50ZWwgQ29ycG9yYXRpb24uDQpbICAgIDAuMjI0MDAwXSBlMTAw
MCAwMDAwOjAwOjAxLjA6IGVuYWJsaW5nIGRldmljZSAoMDAwMCAtPiAwMDAyKQ0KWyAgICAwLjI0
NDAwMF0gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0
IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwMDAwMDAwMDAwDQpbICAgIDAuMjQ0MDAwXSBPb3BzIFsj
MV0NClsgICAgMC4yNDQwMDBdIE1vZHVsZXMgbGlua2VkIGluOg0KWyAgICAwLjI0NDAwMF0gQ1BV
OiAwIFBJRDogMSBDb21tOiBzd2FwcGVyLzAgTm90IHRhaW50ZWQgNC4xOS4wLXJjNi1laWRldGlj
b20tcmlzY3YtMDAwMzgtZ2MyYjQ1YjJmZTI2YS1kaXJ0eSAjNDENClsgICAgMC4yNDQwMDBdIHNl
cGM6IGZmZmZmZmQyMDA0MGNjMTggcmEgOiBmZmZmZmZkMjAwNDBlOTEyIHNwIDogZmZmZmZmZDNm
N2E3N2I2MA0KWyAgICAwLjI0NDAwMF0gIGdwIDogZmZmZmZmZDIwMDdlNTk2MCB0cCA6IGZmZmZm
ZmQzZjdhYzAwMDAgdDAgOiBmZmZmZmZkM2Y3NTRiNGMwDQpbICAgIDAuMjQ0MDAwXSAgdDEgOiAw
MDAwMDAwMDAwMDAwMDAwIHQyIDogMDAwMDAwMDAwMDAwMDNhZiBzMCA6IGZmZmZmZmQzZjdhNzdi
NzANClsgICAgMC4yNDQwMDBdICBzMSA6IGZmZmZmZmQzZjc1NTRiMjAgYTAgOiBmZmZmZmZkM2Y3
NTU0YjIwIGExIDogMDAwMDAwMDAwMDAwMDAwMA0KWyAgICAwLjI0NDAwMF0gIGEyIDogMDAwMDAw
MDAwMDAwMDAwMCBhMyA6IDAwMDAwMDAwMDAwMDAwMDEgYTQgOiAwMDAwMDAwMDAwMDAwMDAyDQpb
ICAgIDAuMjQ0MDAwXSAgYTUgOiAwMDAwMDAwMDAwMDAwMDAyIGE2IDogMDAwMDAwMDBlYWMwYzZl
NiBhNyA6IDAwMDAwMDAwMDAwMDAwMDANClsgICAgMC4yNDQwMDBdICBzMiA6IDAwMDAwMDAwMDQx
NDAyNDAgczMgOiAwMDAwMDAwMDAwMDAwMDAwIHM0IDogZmZmZmZmZDNmNzU1NGYwOA0KWyAgICAw
LjI0NDAwMF0gIHM1IDogZmZmZmZmZDNmNzU1NDAwMCBzNiA6IGZmZmZmZmQyMDA3ZTc3OTQgczcg
OiBmZmZmZmZkM2Y3NTU1MDAwDQpbICAgIDAuMjQ0MDAwXSAgczggOiBmZmZmZmZkM2Y3NTU0NmMw
IHM5IDogZmZmZmZmZDNmNzU1NGIyMCBzMTA6IDAwMDAwMDAwMDAwMDEwMDANClsgICAgMC4yNDQw
MDBdICBzMTE6IDAwMDAwMDAwMDAwMDAwMDAgdDMgOiBmZmZmZmZkMjAwNzhlOTE4IHQ0IDogZmZm
ZmZmZDIwMDc4ZTkyMA0KWyAgICAwLjI0NDAwMF0gIHQ1IDogMDAwMDAwMDAwMDAwMDAwNyB0NiA6
IDAwMDAwMDAwMDAwMDAwMDYNClsgICAgMC4yNDQwMDBdIHNzdGF0dXM6IDAwMDAwMDAwMDAwMDAx
MjAgc2JhZGFkZHI6IDAwMDAwMDAwMDAwMDAwMDAgc2NhdXNlOiAwMDAwMDAwMDAwMDAwMDBmDQpb
ICAgIDAuMjUyMDAwXSAtLS1bIGVuZCB0cmFjZSAzNzFmNzcwMjgzMWU2MzNiIF0tLS0gICAgDQog
ICAgDQoNCg==

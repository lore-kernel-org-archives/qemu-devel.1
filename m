Received: from eggs.gnu.org ([2001:4830:134:3::10]:41214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gSR3a-0006JU-9D
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 13:29:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gSR3Y-0000oM-LC
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 13:28:58 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 29 Nov 2018 18:28:44 +0000
Message-ID: <22fee90b-8144-212e-ad19-94480491f05b@virtuozzo.com>
References: <1bc34791-6ae3-cbcd-222f-468b89205f64@virtuozzo.com>
	<50b00028-9f75-743b-cdec-58cd367a268a@virtuozzo.com>
	<20181127160841.GJ18381@redhat.com>
In-Reply-To: <20181127160841.GJ18381@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <C322A9A6E1CAF8489A4F83C61ACDD0C5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] encrypt in threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

DQpPbiAyNy4xMS4yMDE4IDE2OjA4LCBEYW5pZWwgUC4gQmVycmFuZ8OpIHdyb3RlOg0KPiBPbiBU
aHUsIE5vdiAyMiwgMjAxOCBhdCAwMTowMToyMFBNICswMDAwLCBWbGFkaW1pciBTZW1lbnRzb3Yt
T2dpZXZza2l5IHdyb3RlOg0KPj4gMjEuMTEuMjAxOCAyMDozMCwgVmxhZGltaXIgU2VtZW50c292
LU9naWV2c2tpeSB3cm90ZToNCj4+PiBIaSBEYW5pZWwhDQo+Pj4NCj4+PiBBZnRlciBtb3Zpbmcg
Y29tcHJlc3Npb24gdG8gdGhyZWFkcyBpbiBRY293MiBpdCdzIGFuIG9idmlvdXMgbmV4dCBzdGVw
IHRvDQo+Pj4gInRocmVhZHlmeSIgZW5jcnlwdGlvbiBpbiBRY293MiB0b28uDQo+Pj4NCj4+PiBC
dXQgaXQgdHVybmVkIG91dCB0byBiZSBub3QgYXMgc2ltcGxlIGFzIEkgYXNzdW1lZC4gSWYgSSBj
YWxsIHFjcnlwdG9fYmxvY2tfZW5jcnlwdA0KPj4+IGluIHBhcmFsbGVsIHRocmVhZHMgd2l0aCB0
aGUgc2FtZSBmaXJzdCBhcmd1bWVudCAoYmxvY2spLCBpdCBqdXN0IHByb2R1Y2Ugd3JvbmcNCj4+
PiB0aGluZ3MgKHBhdHRlcm4gdmVyaWZpY2F0aW9uIGZhaWxzIGluIGlvdGVzdHMpLi4NCj4+Pg0K
Pj4+IFNvLCBjYW4geW91IGFkdmlzZSB0aGUgd2F5IHRvIHBhcmFsbGVsaXplIGVuY3J5cHRpb24v
ZGVjcnlwdGlvbj8NCj4+Pg0KPj4gSG1tLCBqdXN0IGNyZWF0aW5nIFFDcnlwdG9CbG9jayBwZXIg
ZWFjaCB0aHJlYWQgaGVscGVkLiBJcyBpdCBjb3JyZWN0IHRoaW5nIHRvIGRvPw0KPiBUaGF0J3Mg
cmF0aGVyIGEgaGVhdnkgd2VpZ2h0IGFwcHJvYWNoIGFuZCB3b3VsZCBjYXVzZSBwYWluIHdoZW4g
d2Ugd2FudA0KPiB0byBzdXBwb3J0IGZ1dHVyZSBvcHRpb25zIHN1Y2ggYXMga2V5c2xvdCB1cGRh
dGVzLCBhbmQgaW4gdGhlIGZ1dHVyZSwNCj4gTFVLU3YyIHdpdGggbWFzdGVyIGtleSBjaGFuZ2Vz
Lg0KPg0KPiBQcm9iYWJseSB3aGF0J3MgbmVlZGVkIGlzIGNoYW5nZSB0byBRQ3J5cHRvQmxvY2sg
c3RydWN0IHNvIHRoYXQgdGhlcmUNCj4gY2FuIGJlIG11bHRpcGxlIFFDcnlwdG9DaXBoZXIgaW5z
dGFuY2VzIGFsbG9jYXRlZCAtIG9uZSBwZXIgdGhyZWFkLg0KPg0KPiBXZSBtaWdodCBhbHNvIG5l
ZWQgdG8gaW50cm9kdWNlIHNvbWUgbG9ja2luZyBhcm91bmQgdXNhZ2Ugb2YgdGhlDQo+IFFDcnlw
dG9JVkdlbiBvYmplY3QsIHNpbmNlIHRoYXQgaGFzIGEgUUNyeXB0b0NpcGhlciBoYW5kbGUgdG9v
Lg0KDQoNCkNhbiB3ZSBhbHNvIGNyZWF0ZSBRQ3J5cHRvSVZHZW4gcGVyIHRocmVhZCwgYXMgUUNy
eXB0b0NpcGhlcj8gT3IgaXQgDQpzaG91bGQgYmUgb25lPyBJZiBvbmUsIHdoeSBteSBpbXBsZW1l
bnRhdGlvbiB3aXRoIFFDcnlwdG9CbG9jayBwZXIgDQp0aHJlYWQgd29ya3MgKGF0IGxlYXN0IGl0
IHBhc3NlcyBpb3Rlc3RzLCBobW0pDQoNCg0KPg0KPiBSZWdhcmRzLA0KPiBEYW5pZWwNCg==

Received: from eggs.gnu.org ([209.51.188.92]:54092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1gmOyt-0003cT-6S
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 15:18:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1gmOyr-0000jm-9l
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 15:18:39 -0500
Received: from mail-eopbgr740097.outbound.protection.outlook.com
	([40.107.74.97]:6112
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juterry@microsoft.com>)
	id 1gmOyo-0000b0-KI
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 15:18:37 -0500
From: "Justin Terry (VM)" <juterry@microsoft.com>
Date: Wed, 23 Jan 2019 20:18:19 +0000
Message-ID: <MW2PR2101MB1132DDAF249D8EF1E9205BA1B6990@MW2PR2101MB1132.namprd21.prod.outlook.com>
References: <1521039163-138-1-git-send-email-juterry@microsoft.com>
	<00e8dbed-6ada-d023-46b9-89881fcbfb1f@weilnetz.de>
In-Reply-To: <00e8dbed-6ada-d023-46b9-89881fcbfb1f@weilnetz.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/3] WHPX introduce changes for Windows
 Insider SDK 17110
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>

SGV5IFN0ZWZhbiwNCg0KTm90IHRyeWluZyB0byBpZ25vcmUgeW91IGhlcmUuIEkgaGF2ZSByZWFj
aGVkIG91dCB0byBtZW1iZXJzIG9mIG1hbmFnZW1lbnQgb24gb3VyIHNpZGUgSSBqdXN0IGRvbuKA
mXQgaGF2ZSBhbnkgcmVzcG9uc2VzIHlldCBvbiB3aGF0IHdlIGNhbiBkbyBoZXJlLiBXaWxsIHVw
ZGF0ZSBhcyBJIGxlYXJuIG1vcmUuDQoNClRoYW5rcywNCkp1c3RpbiBUZXJyeQ0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN0ZWZhbiBXZWlsIDxzd0B3ZWlsbmV0ei5k
ZT4NCj4gU2VudDogVGh1cnNkYXksIEphbnVhcnkgMTcsIDIwMTkgMTI6MzggUE0NCj4gVG86IEp1
c3RpbiBUZXJyeSAoVk0pIDxqdXRlcnJ5QG1pY3Jvc29mdC5jb20+OyBxZW11LWRldmVsQG5vbmdu
dS5vcmcNCj4gQ2M6IHBib256aW5pQHJlZGhhdC5jb207IGVoYWJrb3N0QHJlZGhhdC5jb207IHJ0
aEB0d2lkZGxlLm5ldA0KPiBTdWJqZWN0OiBSZTogW1FlbXUtZGV2ZWxdIFtQQVRDSCAwLzNdIFdI
UFggaW50cm9kdWNlIGNoYW5nZXMgZm9yDQo+IFdpbmRvd3MgSW5zaWRlciBTREsgMTcxMTANCj4g
DQo+IEFtIDE0LjAzLjIwMTggdW0gMTU6NTIgc2NocmllYiBKdXN0aW4gVGVycnkgKFZNKSB2aWEg
UWVtdS1kZXZlbDoNCj4gPiBUaGlzIGNoYW5nZSBzZXQgZml4ZXMgdHdvIGJyZWFraW5nIGNoYW5n
ZXMgdGhhdCB3ZXJlIGludHJvZHVjZWQgaW4gdGhlDQo+ID4gV2luZG93cyBJbnNpZGVyIFNESyAx
NzExMC4gRmlyc3QsIGEgY2hhbmdlIHRvIHRoZSBXSHZHZXRDYXBhYmlsaXR5DQo+ID4gZnVuY3Rp
b24gZGVjbCB0byBpbmNsdWRlIHRoZSAnb3V0JyBXcml0dGVuU2l6ZUluQnl0ZXMuIFNlY29uZCwg
Y2hhbmdlcw0KPiA+IHRvIHRoZSBXSHZTZXRQYXJ0aXRpb25Qcm9wZXJ0eSBmdW5jdGlvbiBkZWNs
IGFuZA0KPiA+IFdIVl9QQVJUSVRJT05fUFJPUEVSVFkgc3RydWN0dXJlIHRvIGRpcmVjdGx5IHBh
c3MgdGhlIFByb3BlcnR5Q29kZSBhdA0KPiBpbnZvY2F0aW9uLg0KPiA+DQo+ID4gTGFzdGx5LCBp
dCBpbnRyb2R1Y2VzIGEgbWFqb3IgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQgaW4NCj4gPiB3aHB4
X3ZjcHVfcG9zdF9ydW4gdXNpbmcgdGhlIFZwQ29udGV4dCBleGl0IHN0cnVjdHVyZSByYXRoZXIg
dGhhbg0KPiA+IGFub3RoZXIgcm91bmQgdHJpcCBjYWxsIHRvIFdIdkdldFZpcnR1YWxQcm9jZXNz
b3JSZWdpc3RlcnMgdG8gc3luY2hyb25pemUNCj4gdnAgc3RhdGUuDQo+ID4NCj4gPiBRRU1VIGNv
bXBpbGVkIGFnYWluc3QgdGhpcyBTREsgKDE3MTEwKykgaXMgZXhwZWN0ZWQgdG8gd29yayBvbiBh
bGwNCj4gPiBXaW5kb3dzIEluc2lkZXIgQnVpbGRzICgxNzExNSspLg0KPiA+DQo+ID4gVGhhbmtz
LA0KPiA+IEp1c3RpbiBUZXJyeQ0KPiANCj4gDQo+IEhpIEp1c3RpbiwNCj4gDQo+IGFzIGZhciBh
cyBJIGtub3cgaXQgc3RpbGwgbm90IHBvc3NpYmxlIHRvIGNyb3NzIGJ1aWxkIGEgbGVnYWwgUUVN
VSBmb3IgV2luZG93cw0KPiBvbiBhIExpbnV4IG1hY2hpbmUgZHVlIHRvIHRoZSBsaWNlbnNlIGxp
bWl0YXRpb25zIG9mIHRoZSBTREsgd2hpY2ggaXMgbmVlZGVkLg0KPiBUaGUgaGVhZGVyIGZpbGVz
IG5lZWRlZCBmb3IgdGhlIFFFTVUgYnVpbGQgYXJlICJBbGwgcmlnaHRzIHJlc2VydmVkIi4NCj4g
DQo+IFBlb3BsZSBvZnRlbiBhc2sgbWUgdG8gYWRkIFdIUFggc3VwcG9ydCB0byB0aGUgUUVNVSBp
bnN0YWxsZXIgZm9yDQo+IFdpbmRvd3MsIGJ1dCBJIGhhdmUgdG8gdGVsbCB0aGVtIHRoYXQgSSBj
YW5ub3QgZG8gdGhhdCBjdXJyZW50bHkuDQo+IA0KPiBUaGlzIHByb2JsZW0gY291bGQgYmUgc29s
dmVkIGlmIHRoZSBuZWNlc3NhcnkgaGVhZGVyIGZpbGVzIHdlcmUgYWRkZWQgdG8NCj4gUUVNVSB3
aXRoIGEgcGVybWlzc2l2ZSBsaWNlbnNlIGJ5IHNvbWVvbmUgd2hvIGhhcyB0aGUgcmlnaHRzIHRv
IGRvIHNvLg0KPiANCj4gQ291bGQgeW91IGFkZCBXaW5IdkVtdWxhdGlvbi5oIGFuZCBXaW5IdlBs
YXRmb3JtLmggb3IgYW0gSSBhbGxvd2VkIHRvDQo+IG1ha2Ugc3VjaCBmaWxlcyBmcm9tIHRoZSBk
b2N1bWVudGF0aW9uIGF0DQo+IGh0dHBzOi8vbmFtMDYuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmRvY3MNCj4gLm1pY3Jvc29mdC5jb20lMkYmYW1w
O2RhdGE9MDIlN0MwMSU3Q2p1dGVycnklNDBtaWNyb3NvZnQuY29tJTdDYWUNCj4gZDI1MzJjZDA1
YjRmMmE1YTAyMDhkNjdjYmJhNThmJTdDNzJmOTg4YmY4NmYxNDFhZjkxYWIyZDdjZDAxMWRiNDcl
DQo+IDdDMSU3QzAlN0M2MzY4MzM1NDI3MTk0NjY5MjEmYW1wO3NkYXRhPSUyRkE3S2preDVmbmpN
Vm5xZXpkbXFpDQo+IHdnQ1pBRndvYU5lMm9DQSUyQlNkUGJ1byUzRCZhbXA7cmVzZXJ2ZWQ9MD8N
Cj4gDQo+IFRoYW5rcywNCj4gU3RlZmFuIFdlaWwNCg==

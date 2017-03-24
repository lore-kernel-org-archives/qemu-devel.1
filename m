Received: from eggs.gnu.org ([2001:4830:134:3::10]:53451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1crYb5-0004im-4b
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 19:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1crYb0-00018G-4p
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 19:26:19 -0400
Received: from mail-cys01nam02on0129.outbound.protection.outlook.com
	([104.47.37.129]:63360
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Andrew.Baumann@microsoft.com>)
	id 1crYaz-00016A-Uk
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 19:26:14 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Fri, 24 Mar 2017 23:11:47 +0000
Message-ID: <DM2PR21MB0060EB3339BA8636099E76789E3E0@DM2PR21MB0060.namprd21.prod.outlook.com>
References: <20170324212115.6772-1-Andrew.Baumann@microsoft.com>
	<1b72685e-c176-82f1-a540-c2e317f5374f@redhat.com>
In-Reply-To: <1b72685e-c176-82f1-a540-c2e317f5374f@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] virtio: fix vring_align() on
 64-bit win32 platforms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Stefan Weil <sw@weilnetz.de>, "Michael S . Tsirkin" <mst@redhat.com>

PiBGcm9tOiBFcmljIEJsYWtlIFttYWlsdG86ZWJsYWtlQHJlZGhhdC5jb21dDQo+IFNlbnQ6IEZy
aWRheSwgMjQgTWFyY2ggMjAxNyAxNToyMA0KDQo+IFNvIGlzICd3aW4zMicgcmVhbGx5IGEgNjQt
Yml0IHBsYXRmb3JtLCBvciBzaG91bGQgdGhlIHN1YmplY3QgYmUgJzY0LWJpdA0KPiB3aW5kb3dz
Jz8NCg0KU2lnaC4gWWVzLCBvaywgaXQncyBhIGxpdHRsZSBzaWxseSBpZiB5b3UgcHV0IGl0IGxp
a2UgdGhhdC4gSSBndWVzcyBJIHdhcyB0aGlua2luZyBvZiB0aGUgX1dJTjMyIGlmZGVmIGFuZCB0
aGUgZmlsZXMgbmFtZWQgKndpbjMyLg0KDQpJJ2xsIHNlbmQgeW91IGEgdjMuLi4NCg0KQW5kcmV3
DQoNCg==

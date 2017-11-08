Received: from eggs.gnu.org ([2001:4830:134:3::10]:60266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4780f80ac=owen.smith@citrix.com>)
	id 1eCOTz-0003DK-SJ
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:25:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4780f80ac=owen.smith@citrix.com>)
	id 1eCOTw-00068k-Hn
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:25:23 -0500
Received: from smtp.citrix.com.au ([103.14.252.240]:20732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4780f80ac=owen.smith@citrix.com>)
	id 1eCOTv-00065e-SP
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:25:20 -0500
From: Owen Smith <owen.smith@citrix.com>
Date: Wed, 8 Nov 2017 10:53:16 +0000
Message-ID: <d4402fd51c5141ecadd93254c11cba0b@AMSPEX02CL02.citrite.net>
References: <20171103115631.15175-1-owen.smith@citrix.com>
	<20171108102116.dsng42mi4a4wxopk@sirius.home.kraxel.org>
In-Reply-To: <20171108102116.dsng42mi4a4wxopk@sirius.home.kraxel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 0/4] xenfb: Enablement for Windows PV
 HID frontend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "sstabellini@kernel.org" <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

I'd imagine this would be merged via the Xen queue, as it primarily deals w=
ith the xen backend

Owen

> -----Original Message-----
> From: Gerd Hoffmann [mailto:kraxel@redhat.com]
> Sent: 08 November 2017 10:21
> To: Owen Smith <owen.smith@citrix.com>
> Cc: sstabellini@kernel.org; Anthony Perard <anthony.perard@citrix.com>;
> qemu-devel@nongnu.org; xen-devel@lists.xenproject.org
> Subject: Re: [PATCH v5 0/4] xenfb: Enablement for Windows PV HID
> frontend
>=20
> On Fri, Nov 03, 2017 at 11:56:27AM +0000, Owen Smith wrote:
> > Improve the input device model in xenfb, by updating the Qemu input
> > handlers and adding a feature to allow for raw (unscaled) absolute
> > coordinates to be represented.
>=20
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>=20
> Will this be merged via xen queue?
>=20
> If not I can queue it up in my input queue, but I'd like to have a review=
 from
> the xen folks then.
>=20
> cheers,
>   Gerd

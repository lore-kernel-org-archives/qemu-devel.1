Received: from eggs.gnu.org ([2001:4830:134:3::10]:55992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dal1r-0005cQ-Gh
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dal1o-0004YL-As
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:48:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dal1o-0004Xj-5M
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:48:44 -0400
Date: Thu, 27 Jul 2017 16:48:36 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170727154836.GZ2555@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170727141120.4970-1-berrange@redhat.com>
	<1501170486.9298.2.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1501170486.9298.2.camel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] ps2: fix sending of PAUSE/BREAK
 scancodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>

On Thu, Jul 27, 2017 at 05:48:06PM +0200, Gerd Hoffmann wrote:
>   Hi,
>=20
> > Changed in v3:
> >=20
> > =C2=A0- Treat entire '0xe1 0x1d 0x45 0xe1 0x9d 0xc5' as make code,
> > =C2=A0=C2=A0=C2=A0there is no break code for PAUSE.
>=20
> Peter just pulled, can you send this as incremetal against v2?

Sure, will do.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

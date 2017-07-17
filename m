Received: from eggs.gnu.org ([2001:4830:134:3::10]:37157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX3BQ-0005vf-Id
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:23:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX3BM-0002RC-IA
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:23:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dX3BM-0002Qo-D6
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:23:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B53D2F86CD
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 10:23:15 +0000 (UTC)
Message-ID: <1500286994.12570.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 17 Jul 2017 12:23:14 +0200
In-Reply-To: <4fb5a60b-8f4e-81ec-020e-3d3ba3690418@redhat.com>
References: <20170712072305.29233-1-kraxel@redhat.com>
	<4fb5a60b-8f4e-81ec-020e-3d3ba3690418@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] keymaps: fr-ca: add missing keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On Mon, 2017-07-17 at 11:44 +0200, Thomas Huth wrote:
> On 12.07.2017 09:23, Gerd Hoffmann wrote:
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> > =C2=A0pc-bios/keymaps/fr-ca | 2 ++
> > =C2=A01 file changed, 2 insertions(+)
> >=20
> > diff --git a/pc-bios/keymaps/fr-ca b/pc-bios/keymaps/fr-ca
> > index b645208e42..030f56a78e 100644
> > --- a/pc-bios/keymaps/fr-ca
> > +++ b/pc-bios/keymaps/fr-ca
> > @@ -48,3 +48,5 @@ parenleft 0xa shift
> > =C2=A0parenright 0xb shift
> > =C2=A0underscore 0xc shift
> > =C2=A0plus 0xd shift
> > +minus 0xc
> > +equal 0xd
> >=20
>=20
> Is that the fix for https://bugs.launchpad.net/qemu/+bug/533613 ?

No.

https://bugzilla.redhat.com/show_bug.cgi?id=3D1446565

cheers,
  Gerd

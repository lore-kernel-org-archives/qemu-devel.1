Received: from eggs.gnu.org ([2001:4830:134:3::10]:48137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1egwYs-0003XZ-EJ
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:52:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1egwYm-00009U-7z
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:52:39 -0500
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:58036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1egwYm-0008W1-1f
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:52:36 -0500
Received: from player778.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 6289BA3B3C
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 18:52:31 +0100 (CET)
Date: Wed, 31 Jan 2018 18:52:25 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180131185225.21762f12@bahia.lan>
In-Reply-To: <09678455-2c70-ff07-7f2a-f4135e28e75f@gmail.com>
References: <1516064279-14816-1-git-send-email-minyard@acm.org>
	<09678455-2c70-ff07-7f2a-f4135e28e75f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] Small IPMI fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <tcminyard@gmail.com>
Cc: minyard@acm.org, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>

On Tue, 23 Jan 2018 10:55:15 -0600
Corey Minyard <tcminyard@gmail.com> wrote:

> Michael?=C2=A0 Anyone?=C2=A0 Can we get these in?
>=20

Since you're adding yourself as a maintainer for IPMI, why not just sending
a pull request ?

> Thanks
>=20
> -corey
>=20
> On 01/15/2018 06:57 PM, minyard@acm.org wrote:
> > These are some fixes I've had for a while (mostly).  They are small
> > fixes and additions for various things.  It would be nice to be able
> > to get these into the upcoming release.
> >
> > I also add myself as the maintainer for the IPMI code, since that
> > seemed appropriate.
> >
> > Changes in v2:
> >
> > I removed the "other" fixes (the one to vl.c) from the previous patch
> > set, these are all IPMI-related changes.  I also moved adding myself
> > as the IPMI maintainer to the first patch, per Marc-Andr=C3=A9.
> > =20
>=20
>=20

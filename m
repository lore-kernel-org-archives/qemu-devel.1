Received: from eggs.gnu.org ([2001:4830:134:3::10]:53863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eh4ZF-0000Ia-91
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 21:25:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eh4ZB-0004ly-Um
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 21:25:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eh4ZB-0004lY-JH
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 21:25:33 -0500
Date: Thu, 1 Feb 2018 04:25:27 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180201042505-mutt-send-email-mst@kernel.org>
References: <1516064279-14816-1-git-send-email-minyard@acm.org>
	<09678455-2c70-ff07-7f2a-f4135e28e75f@gmail.com>
	<20180131185225.21762f12@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180131185225.21762f12@bahia.lan>
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
To: Greg Kurz <groug@kaod.org>
Cc: Corey Minyard <tcminyard@gmail.com>, minyard@acm.org, qemu-devel@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>

On Wed, Jan 31, 2018 at 06:52:25PM +0100, Greg Kurz wrote:
> On Tue, 23 Jan 2018 10:55:15 -0600
> Corey Minyard <tcminyard@gmail.com> wrote:
>=20
> > Michael?=A0 Anyone?=A0 Can we get these in?
> >=20
>=20
> Since you're adding yourself as a maintainer for IPMI, why not just sen=
ding
> a pull request ?

Alternatively if you want others to merge it, pls Cc the relevant people.

> > Thanks
> >=20
> > -corey
> >=20
> > On 01/15/2018 06:57 PM, minyard@acm.org wrote:
> > > These are some fixes I've had for a while (mostly).  They are small
> > > fixes and additions for various things.  It would be nice to be abl=
e
> > > to get these into the upcoming release.
> > >
> > > I also add myself as the maintainer for the IPMI code, since that
> > > seemed appropriate.
> > >
> > > Changes in v2:
> > >
> > > I removed the "other" fixes (the one to vl.c) from the previous pat=
ch
> > > set, these are all IPMI-related changes.  I also moved adding mysel=
f
> > > as the IPMI maintainer to the first patch, per Marc-Andr=E9.
> > > =20
> >=20
> >=20

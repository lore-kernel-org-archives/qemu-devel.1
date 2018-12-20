Received: from eggs.gnu.org ([2001:4830:134:3::10]:60665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ga0OM-0004qf-KW
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 10:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ga0OI-0002Dm-0F
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 10:37:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ga0OF-00020v-RV
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 10:37:36 -0500
Date: Thu, 20 Dec 2018 15:37:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181220153722.GV12930@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181122141741.11108-1-marcandre.lureau@redhat.com>
	<CAL1e-=h_YXP8Y-narAHaoB5GU9s3U8ehEO+mqQUAbuqFjGp6Kw@mail.gmail.com>
	<CAMxuvazCTcnV1bkmk3HCe1ufD9HSAQh_0=hkFAwXTkQqdcK6TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvazCTcnV1bkmk3HCe1ufD9HSAQh_0=hkFAwXTkQqdcK6TQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docs: apply some qemu.org-like CSS style
 to HTML
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: aleksandar.m.mail@gmail.com, "Bonzini, Paolo" <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, qemu-devel <qemu-devel@nongnu.org>

On Thu, Dec 20, 2018 at 07:24:56PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Dec 19, 2018 at 7:17 PM Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
> >
> >
> > On Nov 22, 2018 3:18 PM, "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@r=
edhat.com> wrote:
> > >
> > > Style a bit the HTML documents, to make them look like qemu.org pag=
es.
> > >
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  Makefile                     |   2 +
> > >  docs/texinfo-extra-head.html |   7 ++
> > >  docs/texinfo.css             | 226 +++++++++++++++++++++++++++++++=
++++
> > >  3 files changed, 235 insertions(+)
> > >  create mode 100644 docs/texinfo-extra-head.html
> > >  create mode 100644 docs/texinfo.css
> > >
> >
> > Marc-Andr=C3=A9,
> >
> > I salute these effort, and also my eyes say thank you to you.
> >
> > I just have a suggestion that command line examples, like this one:
> >
> > qemu-system-i386 [options] [disk_image]
> >
> > have a little larger letters. (maybe it is just my system, I see them=
 as if their size is almost twice smaller than regular text size)
>=20
> Easy, change
> pre.verbatim {
> font-size: smaller
> }
>=20
> to larger.
>=20
> >
> > Thanks again!
>=20
> Note that there is an alternative proposal that looks more interesting
> in "[qemu-web PATCH] Import historical documentation"
> I don't know what's the status about it.

Essentiall it is waiting for me to propose a v2 based on feedback


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

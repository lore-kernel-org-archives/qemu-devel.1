Received: from eggs.gnu.org ([2001:4830:134:3::10]:53493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ftE8x-00011C-Iu
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ftE8u-000356-E3
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:36:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32816 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ftE8u-00034m-8x
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:36:56 -0400
Date: Fri, 24 Aug 2018 16:36:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180824153648.GX3430@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180824073256.19626-1-kraxel@redhat.com>
	<CAFEAcA-ZtP8CUSJAE5quaE9Sr=EY9BJcoGqQRH_3EgMXi7y6ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-ZtP8CUSJAE5quaE9Sr=EY9BJcoGqQRH_3EgMXi7y6ww@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] Ui2 20180824 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Libvirt <libvir-list@redhat.com>

On Fri, Aug 24, 2018 at 04:32:54PM +0100, Peter Maydell wrote:
> On 24 August 2018 at 08:32, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > The following changes since commit 5ccac548faf041ff5229a8e8342e3be14a=
34c8af:
> >
> >   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request'=
 into staging (2018-08-23 17:35:48 +0100)
> >
> > are available in the git repository at:
> >
> >   git://git.kraxel.org/qemu tags/ui2-20180824-pull-request
> >
> > for you to fetch changes up to eb01505ea6c8330273d189acc053cc60d00bfa=
1a:
> >
> >   ui: remove support for SDL1.2 in favour of SDL2 (2018-08-24 09:31:3=
9 +0200)
> >
> > ----------------------------------------------------------------
> > ui: remove deprecated UI frontends
> >
> > ----------------------------------------------------------------
> >
> > Daniel P. Berrang=C3=A9 (3):
> >   ui: remove support for GTK2 in favour of GTK3
> >   ui: increase min required GTK3 version to 3.14.0
> >   ui: remove support for SDL1.2 in favour of SDL2
>=20
> Doesn't the last one of these depend on our fixing the
> OpenBSD VM first ?

Yep, i mentioned that in my posting of the patch series.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

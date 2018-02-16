Received: from eggs.gnu.org ([2001:4830:134:3::10]:46037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1embl2-0000nA-99
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 03:52:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1embkz-00055h-5A
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 03:52:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55908 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1embky-00055U-W7
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 03:52:37 -0500
Date: Fri, 16 Feb 2018 08:52:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180216085228.GA3181@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180215175044.8159-1-berrange@redhat.com>
	<CAFEAcA8BsQFvki-rFu4+CWwFMw=YM6UBkEy4BYs-=C7Nr3MhvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8BsQFvki-rFu4+CWwFMw=YM6UBkEy4BYs-=C7Nr3MhvQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/7] Qio next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, Feb 15, 2018 at 07:43:39PM +0000, Peter Maydell wrote:
> On 15 February 2018 at 17:50, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > The following changes since commit 8c5e7bddc22dac9d4dc3526996babce4c7=
242d9d:
> >
> >   Merge remote-tracking branch 'remotes/huth/tags/pull-request-2018-0=
2-14' into staging (2018-02-15 13:00:44 +0000)
> >
> > are available in the Git repository at:
> >
> >   ssh://git@github.com/berrange/qemu tags/qio-next-pull-request
>=20
> This isn't a publicly usable git reference; did you mean
>    git://github.com/berrange/qemu.git tags/qio-next-pull-request
>=20
> ? (I'm testing the pullreq on the assumption that you did.)

Sigh, yes. This is my first time trying git-publish, and I guess I missed
some key config parameter, to distinguish the URL it must push too, vs
the URL it must document in the cover letter.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

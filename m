Received: from eggs.gnu.org ([209.51.188.92]:52411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtEnQ-00007I-Kl
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtEnN-0001LB-St
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:51:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gtEnN-00011i-Kk
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:51:01 -0500
Date: Mon, 11 Feb 2019 16:50:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190211165026.GJ27585@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190207160617.1142-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190207160617.1142-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/18] Chardev patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On Thu, Feb 07, 2019 at 05:05:59PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> The following changes since commit 632351e0e1a861f2eaf709b053c53f96a122=
5825:
>=20
>   Merge remote-tracking branch 'remotes/elmarco/tags/dump-pull-request'=
 into staging (2019-02-07 14:20:46 +0000)
>=20
> are available in the Git repository at:
>=20
>   https://github.com/elmarco/qemu.git tags/chardev-pull-request
>=20
> for you to fetch changes up to df3afdedd23ade0c9de55cadeb1d85055689023f=
:
>=20
>   tests/test-char: add muxed chardev testing for open/close (2019-02-07=
 16:18:25 +0100)
>=20
> ----------------------------------------------------------------
> Various chardev fixes
>=20
> ----------------------------------------------------------------

BTW, I think as the maintainer sending the PULL request you are expected
to have added your own S-o-B to every patch, rather than just a R-B.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

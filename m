Received: from eggs.gnu.org ([209.51.188.92]:51130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hMVXb-0004d6-NH
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hMVXa-0002V5-Ni
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:35:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hMVXa-0002Sa-IG
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:35:42 -0400
Date: Fri, 3 May 2019 11:35:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190503103529.GD17905@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190425133503.30847-1-stefanha@redhat.com>
	<20190503101921.GC17905@redhat.com>
	<CAFEAcA_CkUBHe1fWg9wy-+HLw8WBZrp3M_oBksCN1GQc1qp4hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_CkUBHe1fWg9wy-+HLw8WBZrp3M_oBksCN1GQc1qp4hg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] security.rst: add Security Guide to
 developer docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Otubo <otubo@redhat.com>

On Fri, May 03, 2019 at 11:28:53AM +0100, Peter Maydell wrote:
> On Fri, 3 May 2019 at 11:19, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> > Everything above here is useful to QEMU devs, app devs & end users an=
d
> > should be made part of the main QEMU doc - convert it to texi and @in=
clude
> > it from qemu-doc.texi, as we do for other stuff under docs/
>=20
> If we convert it to texi we'll have to convert it back again
> as/when we migrate properly from texi to sphinx... (I would
> like to make further moves in that direction during this
> release cycle -- just need to find the time to work on it.)

Yes, but we're only talking about 100-150 lines of simple text with
minimal markup needs. Won't be a noticable extra burden compared to
the pre-existing 4700 lines of texi markup for qemu-doc.texi and its
includes.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

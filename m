Received: from eggs.gnu.org ([2001:4830:134:3::10]:47736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emk3Z-0006KM-KF
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:44:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emk3V-0007Ey-RN
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:44:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41540 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1emk3V-0007Eg-Mv
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:44:17 -0500
Date: Fri, 16 Feb 2018 17:44:05 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180216174405.GN3181@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180216164620.GA53727@humpty.home.comstyle.com>
	<c4407146-8ec6-c317-9ec8-a47ab909fb94@amsat.org>
	<CAFEAcA9ZtLWzGZvF7O8WxJzoYghJwCa-EMMNqdk6YNpkvuaeEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9ZtLWzGZvF7O8WxJzoYghJwCa-EMMNqdk6YNpkvuaeEg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] maintainers: Add myself as a OpenBSD
 maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Brad Smith <brad@comstyle.com>

On Fri, Feb 16, 2018 at 05:37:32PM +0000, Peter Maydell wrote:
> On 16 February 2018 at 17:30, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
> > But before announcing the host OS being supported again, I'd rather s=
ee
> > reproducible build/tests logs, in a (public - if possible) continuous
> > integration system. Else it is hard to notice when it get broken.
>=20
> I do include OpenBSD in my set of build/tests for merges.

There's also "make vm-build-openbsd"  for devs who want to test easily in
an OpenBSD VM, or investigate brokeness.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

Received: from eggs.gnu.org ([209.51.188.92]:58593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEuaV-0007Qu-Or
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEuaU-0000yB-E9
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:43:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hEuaU-0000xT-42
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:43:18 -0400
Date: Fri, 12 Apr 2019 12:43:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190412114307.GK25308@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190412113730.28828-1-otubo@redhat.com>
	<20190412113730.28828-2-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190412113730.28828-2-otubo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 1/1] configure: Relax check for libseccomp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, deller@gmx.de, philmd@redhat.com

On Fri, Apr 12, 2019 at 01:37:30PM +0200, Eduardo Otubo wrote:
> From: Helge Deller <deller@gmx.de>
>=20
> All major distributions do support libseccomp version >=3D 2.3.0, so th=
ere
> is no need to special-case on various architectures any longer.
>=20
> Signed-off-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Acked-by: Eduardo Otubo <otubo@redhat.com>

When sending pull requests the subsystem maintainer *must*
add their Signed-off-by as this is what has legal meaning
with respect to the developer certificate of origin.

Acked-by is something that is used to give a different
subsystem maintainer permission to merge a patch that
would normally be your responsibility.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

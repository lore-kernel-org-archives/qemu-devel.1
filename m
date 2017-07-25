Received: from eggs.gnu.org ([2001:4830:134:3::10]:57541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZvU2-00025a-EG
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZvTy-0008LT-O6
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:46:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dZvTy-0008L9-Hv
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:46:22 -0400
Date: Tue, 25 Jul 2017 09:46:14 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170725084614.GF26394@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170725011530.17958-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170725011530.17958-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: fix qemu-ga missing '.exe'
 extension on windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Sameeh Jubran <sjubran@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Daniel Rempel <daniel@daynix.com>, =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Mon, Jul 24, 2017 at 10:15:30PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Reported-by: Sameeh Jubran <sjubran@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> original report from Sameeh Jubran:
> http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg00906.html
>=20
>  Makefile  | 2 +-
>  configure | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

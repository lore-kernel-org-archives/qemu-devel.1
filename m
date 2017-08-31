Received: from eggs.gnu.org ([2001:4830:134:3::10]:53844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnLdF-0003VZ-SF
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnLdC-0008D1-Hp
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:19:25 -0400
Date: Thu, 31 Aug 2017 10:19:17 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170831091917.GD17315@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170830215523.25278-1-f4bug@amsat.org>
	<20170830215523.25278-16-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170830215523.25278-16-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 15/17] MAINTAINERS: add missing
 Cryptography entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Longpeng <longpeng2@huawei.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Wed, Aug 30, 2017 at 06:55:21PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0b77590dc8..7a0c00550e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1526,6 +1526,7 @@ S: Maintained
>  F: crypto/
>  F: include/crypto/
>  F: tests/test-crypto-*
> +F: tests/benchmark-crypto-*
>  F: qemu.sasl
> =20
>  Coroutines

Acked-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

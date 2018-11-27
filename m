Received: from eggs.gnu.org ([2001:4830:134:3::10]:36153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gRfzz-0008Ar-Sx
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:14:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gRfzw-0000Rp-RL
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:14:07 -0500
Date: Tue, 27 Nov 2018 16:13:52 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181127161352.GK18381@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-21-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181125205000.10324-21-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1 20/25] MAINTAINERS: Add missing
 test entries to the Cryptography section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Sun, Nov 25, 2018 at 09:49:55PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c73dde10a5..26727c1561 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1978,6 +1978,8 @@ F: crypto/
>  F: include/crypto/
>  F: tests/test-crypto-*
>  F: tests/benchmark-crypto-*
> +F: tests/crypto-tls-*
> +F: tests/pkix_asn1_tab.c
>  F: qemu.sasl

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

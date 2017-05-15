Received: from eggs.gnu.org ([2001:4830:134:3::10]:33607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAFaK-0004bp-CS
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAFaF-0005ha-HB
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:58:48 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dAFaF-0005hU-CK
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:58:43 -0400
Received: by mail-qk0-x243.google.com with SMTP id y128so16935553qka.3
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 05:58:43 -0700 (PDT)
Date: Mon, 15 May 2017 13:58:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170515125840.GC1201@stefanha-x1.localdomain>
References: <1494443192-17177-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Content-Disposition: inline
In-Reply-To: <1494443192-17177-1-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/9] pci, virtio, vhost: fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2017 at 10:07:58PM +0300, Michael S. Tsirkin wrote:
> The following changes since commit 76d20ea0f1b26ebd5da2f5fb2fdf3250cde887=
bb:
>=20
>   Merge remote-tracking branch 'armbru/tags/pull-qapi-2017-05-04-v3' into=
 staging (2017-05-09 15:49:14 -0400)
>=20
> are available in the git repository at:
>=20
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>=20
> for you to fetch changes up to 8b12e48950a3d59188489b2ff6c5ad9cc09e9866:
>=20
>   acpi-defs: clean up open brace usage (2017-05-10 22:04:23 +0300)
>=20
> ----------------------------------------------------------------
> pci, virtio, vhost: fixes
>=20
> A bunch of fixes that missed the release.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Please resend with the checkpatch.pl issue fixed.

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGaYAAAoJEJykq7OBq3PIFDcH/25qIFbe0Ap+V0e8gLR7kZte
plgMa4rHU7xXaLhwdv1ZYazDZCFMQYpzDnKAtbc93/Q7FxaiTsbrPwAV2tns7PXG
jnxyjzrXXvl563HS3tlhy9lRuc8lap8ayFgoZg0k+wxGbhEGF3Y55eUk7hNWhXku
iS4t/ga9s5HAk33MAwlc+P3MCmFDf9Zed89QFI3C+bN8Bzv4xw2OiPUv1/zDftaR
LydtMSK+NtE+qkVXuaKNO/l7eCb1ioLc4tWLnpCeJjyYgzP5qODEfLXm/VnijtQh
XZHpQu9MDC9BSmEDlzTk+rzxfwIXHnQH/lLRAoI35kSPrig4V/ZORN5BLBi8aD4=
=dSsM
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--

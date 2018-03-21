Received: from eggs.gnu.org ([2001:4830:134:3::10]:60190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eyXoP-00037Q-FE
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 03:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eyXoM-0001j6-5J
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 03:05:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49622 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eyXoL-0001ir-Sh
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 03:05:26 -0400
References: <1521584722-39133-1-git-send-email-mjc@sifive.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7534728b-1511-3ba1-57b1-03423b83ad87@redhat.com>
Date: Wed, 21 Mar 2018 08:05:12 +0100
MIME-Version: 1.0
In-Reply-To: <1521584722-39133-1-git-send-email-mjc@sifive.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="VdezYsn0jl3fDNQZimbACuKn1TnVdvkWx"
Subject: Re: [Qemu-devel] [PULL 00/25] RISC-V Post-merge spec conformance
 and cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VdezYsn0jl3fDNQZimbACuKn1TnVdvkWx
From: Thomas Huth <thuth@redhat.com>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Message-ID: <7534728b-1511-3ba1-57b1-03423b83ad87@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/25] RISC-V Post-merge spec conformance and
 cleanup
References: <1521584722-39133-1-git-send-email-mjc@sifive.com>
In-Reply-To: <1521584722-39133-1-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20.03.2018 23:25, Michael Clark wrote:
> The following changes since commit f1a63fcfcd92c88be8942b5ae71aef9749a4=
f135:
>=20
>   Update version for v2.12.0-rc0 release (2018-03-20 19:04:22 +0000)
>=20
> are available in the git repository at:
>=20
>   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-2.12-fixes
>=20
> for you to fetch changes up to e1a247183ac0816284dfda61423f7030b6686679=
:
>=20
>   RISC-V: Remove erroneous comment from translate.c (2018-03-20 14:34:1=
3 -0700)
>=20
> ----------------------------------------------------------------
> This is a series of spec conformance bug fixes and code cleanups
> that we would like to get in before the QEMU 2.12 release.

 Hi Michael,

for future PULL request, could you please send out all patches again
that should be pulled, and not send the cover letter alone? I.e. do a
"git format-patch --subject-prefix PULL ..." and then replace the
contents of the cover letter with the output of "git request-pull".

=2E.. this is how all other maintainers are sending PULL requests (at
least as far as I know) and this way everybody gets a very final chance
to have a look at the patches in their final state (it does not happen
very often that someone replies to such patches, but in some rare cases
we already found problems this way).

 Thank you very much for your efforts,
  Thomas


--VdezYsn0jl3fDNQZimbACuKn1TnVdvkWx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJasgQtAAoJEC7Z13T+cC21Ck8P/j3cPImDgYFaQy2FS6CgH3Dq
q+gbCOkcybfMD3GV6+G0Fq4jgp9zO9gEqk/TcEmCR7Mj0N2yCJaEZvO8wEdv4J8R
gY49Ox+CFK75FQ1/fyvfktSgqIwDH10EocynAi1UhlcvLlekE5OPMe4z3ufaPeXy
PfAr+15TrPq7ZnymVrc6cm3P4uLc7TBzbIJ3ZDUufmWpXAwMvpFiRTTA0eNlnHTo
yx5HXJkDASJjXtFsKm0JXYghpiq1bBVV3a3RJgz7kzRFasW0UP2fssveiemvBHnq
CtdxWU4Wh4ooUx4k7ZyrpMsCrJWQIoix3R2+s8wikqy83dTrjNhdQ8k5/q3ExhDL
LGc9dh0v0XwN6pXNNz/leGfBmRdRmuIvKajnWYYF90b2dYupHnSOVzl9gVUjAamY
Ml/KY8x7OmYNON499yPPsRsesY/SuAH+AJmJoIa9cUTfGPFSfSfTJU/xMBRc2LRn
w83F5NmU+xAFJlBIWKK5zKJ6gHGTla6Y0o3dgm3eaA8I4aOBUV4mD/LInE5tL1Ru
GfJ9xDJ8qB6oJtBDrWw9i0nXgiOqMyDd4coUVkFqM9KcqCoaHkv7yBxKmksA6Vy+
VFzdB3ytgDut/h6LcnakTroTAF7AcL8lmFbGlGwSSgkA/aNl03OzZcaWR0TFDrft
JlAzwEKrf5VyTMlA2Y2I
=Hz2Z
-----END PGP SIGNATURE-----

--VdezYsn0jl3fDNQZimbACuKn1TnVdvkWx--

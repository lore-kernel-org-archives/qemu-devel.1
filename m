Received: from eggs.gnu.org ([2001:4830:134:3::10]:54344)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1eFcN2-0000u2-Vb
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 03:51:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1eFcMy-0007bF-AN
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 03:51:33 -0500
Received: from mout.gmx.net ([212.227.15.15]:64137)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1eFcMx-0007Vj-VS
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 03:51:28 -0500
References: <e1e3a1d3-da53-e46a-ce9b-7d1707e3a493@linux.intel.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <cd3fcaf0-8f53-6adf-3898-d0dab2aa6f92@gmx.com>
Date: Fri, 17 Nov 2017 09:53:51 +0100
MIME-Version: 1.0
In-Reply-To: <e1e3a1d3-da53-e46a-ce9b-7d1707e3a493@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="d8EA4s9VeIv5FGaO8hh9WXxqXn6JRsMNG"
Subject: Re: [Qemu-devel] HAXM is now open source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, yu.ning@linux.intel.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d8EA4s9VeIv5FGaO8hh9WXxqXn6JRsMNG
From: Kamil Rytarowski <n54@gmx.com>
To: qemu-devel@nongnu.org, yu.ning@linux.intel.com
Message-ID: <cd3fcaf0-8f53-6adf-3898-d0dab2aa6f92@gmx.com>
Subject: Re: [Qemu-devel] HAXM is now open source
References: <e1e3a1d3-da53-e46a-ce9b-7d1707e3a493@linux.intel.com>
In-Reply-To: <e1e3a1d3-da53-e46a-ce9b-7d1707e3a493@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.11.2017 09:54, Yu Ning wrote:
> Hello,
>=20
> As some of you may have noticed, since QEMU 2.9.0, an accelerator known=

> as =E2=80=9Chax=E2=80=9D has been available for Windows and macOS build=
s of QEMU, thanks
> to the hard work of Vincent Palatin and help from this community (Paolo=

> Bonzini, Stefan Weil, et al.).
>=20
> The accelerator requires a host kernel module (driver) known as Intel
> Hardware Accelerated Execution Manager (HAXM), i.e. intelhaxm.sys on
> Windows or intelhaxm.kext on macOS, similar to how the KVM accelerator
> depends on kvm.ko on Linux.
>=20
> Today, we released the source code of the HAXM kernel module under the
> BSD 3-clause license:
>=20
> https://github.com/intel/haxm
>=20
> We look forward to working with the community to improve HAXM (both the=

> kernel module and the accelerator). The code is accompanied by some
> basic documentation (README.md and API.md), which is incomplete, but
> hopefully helps people get started. If you have any questions or
> suggestions, please create an issue or post a comment on GitHub.
>=20
> Thanks,
> Yu
>=20

Please make it clear whether this module can be ported (as host) to
other OSes and whether it can support arbitrary guests OSes (for the
same CPU).

I'm researching options to add hardware assisted virtualization for
NetBSD as host.


--d8EA4s9VeIv5FGaO8hh9WXxqXn6JRsMNG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaDqOlAAoJEEuzCOmwLnZspHMP/3FioyhQIDbTkkEXrNsaCudB
0qV7UPIOIuJRhrDepCHhNXiug3TkANIAPE1M4ZWbuyHhHSl2MdIh17qO6Mlj3AvG
lphll3j0RVNmiuuRgo5Jk6/KT3PJ/J2gQJYiKHSR7HP4wYhsGPWjfBAlvdu6tjNz
3AnNJ1NDjHT/S77ZLlZba13JTzNkxM7h71q+ZKh3+p8VWPM7JVvHO05jBoJZYpz9
6t3wgeldNTkuYzyrVt1+FwfFDMYuzND3VxsMKYA8Tb8/z/yXpZdeTG5t3GDMbpFP
pbjYz5NmUS6+SlL/oSRXaTbpmi4+bz0G/6VrsTrB6yPaMpp9+55wD1p64sLzbyUS
DTf+p1QDaWg6jX+FB03xPp155Vn+VLm5LKtviepqM5w8oB98yiQSA+DDwuEVoJ1Q
Q1A5pIt8FvynorDGmC8EU+tn8oIM2fB+TlLdiBUZ2754GWARBJs8vIrDq6i29Xoy
vMBFRp2b1+Tr5GwjVf0XEqNJtvtySlMoI1eSA4UMMdyv9Idgj+clyu1K1TUcWEO0
RfeDDSB2vbwUq5ZAAzo4sx7iYNfapovk257oMwnmUt7OmaTZB3sHDyK0fPb8Xyrd
PIH3Re/IgZZx84+1n7zpBMLLtseczmOZJQkktagM/lsI7OBb5f+nzZFbStCDp7Jr
SkE54C/Gto8HZ6KJAV5T
=Xegu
-----END PGP SIGNATURE-----

--d8EA4s9VeIv5FGaO8hh9WXxqXn6JRsMNG--

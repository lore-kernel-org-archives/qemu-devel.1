Received: from eggs.gnu.org ([2001:4830:134:3::10]:57071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fMEWH-0002A1-Ui
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fMEWE-00079y-Ny
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:20:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35068 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fMEWE-00078s-JA
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:20:38 -0400
Date: Fri, 25 May 2018 16:20:36 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180525152035.GB21895@stefanha-x1.localdomain>
References: <1527028012-21888-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <1527028012-21888-1-git-send-email-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH 0/5] trace-mem fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 22, 2018 at 06:26:47PM -0400, Emilio G. Cota wrote:
> This series fixes a few issues that I found while testing
> the tracing of guest memory accesses in TCG. Please review!
>=20
> You can fetch these patches from:
>   https://github.com/cota/qemu/commits/trace-mem

I took a quick look and am happy.

CCing Llu=EDs.

Stefan

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbCCnDAAoJEJykq7OBq3PIgUkH/1MYhAY+7xDjwD32WLwn9JY/
VElEJH0JTqaOwxjVbtYaSk5dBVB0Hr5PS90dZ3JVA0b48Dx+E1y7cPwve/AbkaVS
mWqQLICVjdA7vaU3qSKpr9cTJNYZmEb5hf0q0i9FY+SqtlHxDhcXsTCCcP5Q2lV6
/GWJHVLmxmu1iC9SuWc/HvsedRwZgPchLSXnf8wAdjQE3q4/6Js7lIcuQ+0dUf2b
ErQh83PFB4qD4RKJKmstj/CZgIJRkBaIQcvnvl+IuhemNAE75Od8o7dukx72rrqb
oomAbww+Z263dL3VhMyVKms2BRhGHM3a4Q0sfq9Xwm7EDFJkJAUvvRIdTTrFwe4=
=pwKy
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--

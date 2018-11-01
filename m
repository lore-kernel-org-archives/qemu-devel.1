Received: from eggs.gnu.org ([2001:4830:134:3::10]:41130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gIAkg-0003Iv-Ro
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 07:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gIAkd-0001XA-MF
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 07:03:02 -0400
Date: Thu, 1 Nov 2018 11:02:56 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181101110256.GL24946@stefanha-x1.localdomain>
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
	<20181031002526.14262-5-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XRwESHC7KXlqFpSs"
Content-Disposition: inline
In-Reply-To: <20181031002526.14262-5-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [PATCH v3 04/13] arm: Instantiate NRF51 random
 number generator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, "open list:NRF51" <qemu-arm@nongnu.org>


--XRwESHC7KXlqFpSs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 30, 2018 at 08:25:18PM -0400, Steffen G=F6rtz wrote:
> Use RNG in SOC.
>=20
> Signed-off-by: Steffen G=F6rtz <contrib@steffen-goertz.de>
> ---
>  hw/arm/nrf51_soc.c         | 16 ++++++++++++++++
>  include/hw/arm/nrf51_soc.h |  2 ++
>  2 files changed, 18 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--XRwESHC7KXlqFpSs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb2t1gAAoJEJykq7OBq3PIrB4IAKfXYSs3TvrmnRG0WJZllbeq
/F7UhgghPHulvBlYGOSMBs4wQImzhlfz9tJac9CUFONdVH7R8vxBDg88/TNuyrWz
wBjusREidbKWcRoOvPowzGnCqMkip763gI3Ce30TkD9DqHgOSP6m3+r4CUJg82al
L+qjoVJEYhJHtTHaQomBCPA87DrxKPyjNiQ45NmBaXHAsZBfU9HaERfPF6vvs0yj
HcPnPlJMK4JBTxqyFrKDHBhpPacZlLLr/Tw/pC7fZEKEzlQtn8VfTxlejjXjBqTn
EJRzPF25s5FkDyUAzUqVw2GycEHGnf18nQPEML+PG8vW5/YXXHD7kq6hmsE7FH0=
=fZEF
-----END PGP SIGNATURE-----

--XRwESHC7KXlqFpSs--

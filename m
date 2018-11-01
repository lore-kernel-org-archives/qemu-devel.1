Received: from eggs.gnu.org ([2001:4830:134:3::10]:44857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gIChw-0000n1-8X
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 09:08:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gIChr-0007aP-WF
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 09:08:20 -0400
Date: Thu, 1 Nov 2018 13:08:12 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181101130812.GV24946@stefanha-x1.localdomain>
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
	<20181031002526.14262-14-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b3OyYALfe3DXUU4J"
Content-Disposition: inline
In-Reply-To: <20181031002526.14262-14-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [PATCH v3 13/13] arm: Add Clock peripheral stub to
 NRF51 SOC
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


--b3OyYALfe3DXUU4J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 30, 2018 at 08:25:27PM -0400, Steffen G=F6rtz wrote:
> This stubs enables the microbit-micropython firmware to run
> on the microbit machine.
>=20
> Signed-off-by: Steffen G=F6rtz <contrib@steffen-goertz.de>
> ---
>  hw/arm/nrf51_soc.c         | 27 +++++++++++++++++++++++++++
>  include/hw/arm/nrf51_soc.h |  1 +
>  2 files changed, 28 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--b3OyYALfe3DXUU4J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb2vq8AAoJEJykq7OBq3PIktkIAJKWpH2zEto8HkjNlQyBwdkN
EeuZb7Y+W0gnCb/oCo7iYt0MSUDrHiwNqSgfU/FAj14xfFJaaND5mA5mZv76PWxo
V/4VKHw3Kmr0lnMlZqenknCf+BYdaze0A3AB393HiUKTVkvGLjvY6RSVYKAoaxnV
MzPn+02zod4bOVAhg6WTJp+tEKjyjy4AbEemrBLuw+fIyG09yDp+VRX+xucHRyGH
0fv8C43ZeYwPDLVu+BQXysbcCaonlYBiE6jfPpvNCGnpciK2n6HBzBIPDKTkzzOM
X7rmN0Hd/KyAg3fR9eooA9N1sJPFGZwsPbwwR78kc28pVTOYUIyMDwVML15PFN4=
=mtG6
-----END PGP SIGNATURE-----

--b3OyYALfe3DXUU4J--

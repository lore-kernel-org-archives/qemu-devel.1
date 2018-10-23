Received: from eggs.gnu.org ([2001:4830:134:3::10]:37233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEyhU-0007C3-Ay
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEybu-00070K-2m
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:28:47 -0400
Date: Tue, 23 Oct 2018 16:20:01 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181023152001.GN12127@umbus.hotspot.internet-for-guests.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-18-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8CNmCRe8Sh4keFKJ"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-18-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 17/45] machine: fix a typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Michael Walle <michael@walle.cc>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Li Qiang <liq3ea@163.com>, qemu-trivial@nongnu.org


--8CNmCRe8Sh4keFKJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:03:54PM -0300, Eduardo Habkost wrote:
> From: Li Qiang <liq3ea@163.com>
>=20
> Cc: qemu-trivial@nongnu.org
> Signed-off-by: Li Qiang <liq3ea@163.com>
> Message-Id: <20181010161025.34796-1-liq3ea@163.com>
> Reviewed-by: Stefano Garzarella <stefanogarzarella@gmail.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/core/machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 1987557833..da50ad6de7 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -636,7 +636,7 @@ static void machine_class_init(ObjectClass *oc, void =
*data)
>          machine_get_memory_encryption, machine_set_memory_encryption,
>          &error_abort);
>      object_class_property_set_description(oc, "memory-encryption",
> -        "Set memory encyption object to use", &error_abort);
> +        "Set memory encryption object to use", &error_abort);
>  }
> =20
>  static void machine_class_base_init(ObjectClass *oc, void *data)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8CNmCRe8Sh4keFKJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvPPCEACgkQbDjKyiDZ
s5L3+Q/+JhO7ZX8Js1h3E7W084g9DevCgdEkiDxRw/wUcYNsu/YoIa1mAw28AonM
I5ge5kV4xkqq1uJO0ZqnFPgi4GoKF+k3/i8/5GNLnl9cF97YWTxmvJOb040D9oaN
VsGoPfErDy0MW3pZNCTzTr3+MKAKoNT8yBFjfeSGMiOrRKeExPlHx/EOrm00ZDPZ
e5jcJU8h+34Xu6eBud72hstSiFYrPN/FaZChNJq/TGH+DUqGs8O1qA77B7ELc+Ne
VkKt1+OoIkWzNz52I7NKGYgWPh1MWRvTErzr/2hU4wg0CdRelUmgkLHHCZR211z1
qpkWqb9R+eZ9Re33QeaEqdpSd1rupBUGEq28PVOgmcZFvvzQ3D1vHvQbNN1oeNiH
3w2RcIZn1H+7xuAA1U7V+R30RNqqvr9K1NagvOJe8g/Wa2V2sMbJBPMMJR5WG7Rs
DXpl3g9esM7llDmSV3nDDQg4l8lClSpF1fleH0frB3AQMMzWwwcOVUVSNmpCnoh5
3oalkRlmUSn/bBHks0WNR4thV7yAOsec3cooRtJUAH79U04j4Q9BWVsb+KPBwsCQ
ziDcrNjE7DMc6QAPwKirMXdNRu+ytSKGgk7KXUOIKkbU9EkJ7lwpFqALtFFxUqnL
+Zm/5b2ZTid44ME/VfnMrvuvM+7WRMMd+M82Bz0L83kt5BjfUAo=
=WozB
-----END PGP SIGNATURE-----

--8CNmCRe8Sh4keFKJ--

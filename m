Received: from eggs.gnu.org ([2001:4830:134:3::10]:51708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV8Nn-0000Ou-A0
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 00:36:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV8Nm-0007NB-8w
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 00:36:43 -0400
Date: Tue, 19 Jun 2018 14:36:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180619043631.GC11674@umbus.fritz.box>
References: <20180618215601.8974-1-mail@sebastianbauer.info>
	<20180618235557.GB25461@umbus.fritz.box>
	<73dd5b26b622e6c59776976aa2c7a3a0@sebastianbauer.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline
In-Reply-To: <73dd5b26b622e6c59776976aa2c7a3a0@sebastianbauer.info>
Subject: Re: [Qemu-devel] [PATCH] ppc: Include vga cirrus card into the
 compiling process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sebastian Bauer <mail@sebastianbauer.info>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, balaton@eik.bme.hu, qemu-ppc@nongnu.org


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2018 at 06:32:55AM +0200, Sebastian Bauer wrote:
> Am 2018-06-19 01:55, schrieb David Gibson:
> > Have you checked the Cirrus VGA actually works on a ppc machine?
>=20
> Yes, it works for AmigaOS guests. Better than the sm501 for
> instance.

Ok.  However, your patch doesn't apply against the ppc-for-3.0 tree.
It looks like you've made it against a tree including some of BALATON
Zoltan's proposed but not yet merged patches.

Please make sure your patches are against the current ppc-for-3.0 tree
before posting.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsoiE0ACgkQbDjKyiDZ
s5JaARAAy7BRlKs/ByynHu7zGLFdCCaJUlNHnzl8ov7G0UdnIRdwONDE8SqSeUUK
LVYCqsLBpP1svri064l4AcrEMtnv4G+t60+XkG0WcINNdQBMvZQU3D3N20emxh8p
D7jEZa/bOZrAJEnYuuP2dwjKg9/sIkuU+RAb4PEnr8oMOMD7mb93RJa7lGHXWNof
/2XaHfgbVVqC/+CZMdOmd3z+5ggO/6oSwQDFpUsBLxOthFUCp5MNrL6OCulQCKeb
DlmFsb6F5I5GayfxqOXJfVAXjQhgPhsRNB9/X3Ilzs/QK2TppqkVozAaF7TZ1CRq
w2dE6yRuUDC6rdFI7R50pqXowqzidpCsXGXqshC0zabsGXxIoPR3hk3wnWHXHRyn
0sVbbFsEpxaDEpIqotLaWZUIs3yqnXYJHX2xHe7aE3YjdfA6Ds8vkLtjfLB5EXbM
5VTrrvS4iVkVU0ZjyKBaoNxvqKTRAWMXM3+zbJ8z4pkH7V5gq713qUjQNL2zeT1U
zOQd7SYPBmcuFHMjHIguDlka228fxhrxNfT7wcu+IreH8VB7jbHc5FExT0nDwHfa
7XYHgI79abafjhfRPGe8m5D52sYTVk5W7Ri417RrVTCGxH4orojlInE6AHpaCju0
kifl0Kkzg/rBHxcwF0a1NkbqX1PvQHpGmJ17kT22oOpb0XkWzz8=
=AFcg
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--

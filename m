Received: from eggs.gnu.org ([2001:4830:134:3::10]:58697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1egXzq-0002R2-9T
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:38:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1egXzj-0007YK-UU
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:38:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1egXzj-0007XO-O6
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:38:47 -0500
Date: Tue, 30 Jan 2018 12:03:42 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180130120342.GC15551@stefanha-x1.localdomain>
References: <151730107324.755.12264321256439401751.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Content-Disposition: inline
In-Reply-To: <151730107324.755.12264321256439401751.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] tests/virtio-9p: explicitely handle
 potential integer overflows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2018 at 09:32:48AM +0100, Greg Kurz wrote:
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  tests/virtio-9p-test.c |   31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
>=20
> This is based on SHA1 2eab02aa260ac5405e1e51c9cc1b4c3aa23fc45a from my
> 9p-next branch:
>=20
> https://github.com/gkurz/qemu/commits/9p-next

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJacF8eAAoJEJykq7OBq3PIN58IAKt0V++MNV+RSA/EebMlFzwI
smTAFkWQtbHJras/jHX7MQ60czrAlcQ12H7X/BOKExUdZNthbb/bvulSfi2d4FJ+
IWggvDO8dlk95rbxZJGqELBoilFOB+1dCKzDXMhjq3a174x+52jPmeeEe3EemsYN
oDgBpLGMewJV7InU1Q4l5TFquW31RBHSuWEoEjPdkTD5mphBelZRKa2l2k7Y3ImR
eOTR0+6kSwXqXq4jxdFPfledSiv1ULJk9h9A9sDAnrfeRZFsdB861w76HZz7hf+m
24Jp8Lo8Agn0SG+Zh01jXeOcbZxTzDWvCu44ybyYttf0pWb3OrHBXi3UapglC0s=
=XPMb
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--

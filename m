Received: from eggs.gnu.org ([2001:4830:134:3::10]:47849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dahoG-0005aa-JL
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dahoD-0007KU-FI
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:22:32 -0400
References: <20170727120210.6943-1-crosa@redhat.com>
	<20170727120210.6943-6-crosa@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c5df31fb-3859-ab7a-9a61-5526360fd0f7@redhat.com>
Date: Thu, 27 Jul 2017 07:22:24 -0500
MIME-Version: 1.0
In-Reply-To: <20170727120210.6943-6-crosa@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3ovhIhU8ivSDFCWE5fS2rDw1Xl8cqCIVq"
Subject: Re: [Qemu-devel] [PATCH 5/5] docs: fix broken paths to docs/interop
 dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3ovhIhU8ivSDFCWE5fS2rDw1Xl8cqCIVq
From: Eric Blake <eblake@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Message-ID: <c5df31fb-3859-ab7a-9a61-5526360fd0f7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] docs: fix broken paths to docs/interop
 dir
References: <20170727120210.6943-1-crosa@redhat.com>
 <20170727120210.6943-6-crosa@redhat.com>
In-Reply-To: <20170727120210.6943-6-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/27/2017 07:02 AM, Cleber Rosa wrote:
> With the move of some docs to docs/interop on d59157e, a couple of
> references where not updated.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  docs/devel/writing-qmp-commands.txt | 2 +-
>  qapi-schema.json                    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

Safe for 2.10, but also okay if it slips to 2.11

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3ovhIhU8ivSDFCWE5fS2rDw1Xl8cqCIVq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll52wAACgkQp6FrSiUn
Q2odMQf/dD93bwSEPNJYqxbUJrvnkl4s8Oe3YVd2U2nyLsCrf38JjcDKbOZAVFqZ
WKrlO1TDkZxh9rI9VihLhMcBy09Wv+zZ84k8AsduzgXVGl8hCdatkb8j4MdX0T+S
uBu6cNwny2GUz6rr2gt58A+GxXEDOFW29XDHsXj/80/BeWIH2yVleDANjPGt1sE1
Ss1j0IKj6KjukUOiH3gufZWHq96Cwx1zvun0XIONGjOuKuGp6m/yoNZtZd87kO78
fyXVLFBj/TtIeHYOrpgo+fC0G3Fhn1qMLqNvxG8s/8ezgVqnpLm81cOAYp+cCgmW
DMuUehoxO3ANwKURJvxdn6SvnNs6Sg==
=G1QP
-----END PGP SIGNATURE-----

--3ovhIhU8ivSDFCWE5fS2rDw1Xl8cqCIVq--

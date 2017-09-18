Received: from eggs.gnu.org ([2001:4830:134:3::10]:47727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtwsF-0000zi-Sd
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:18:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtwsB-0003q7-SX
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:18:11 -0400
References: <20170916185123.29255-1-mreitz@redhat.com>
	<20170916185123.29255-6-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4848aab9-ce77-48cb-1531-54d45b361bef@redhat.com>
Date: Mon, 18 Sep 2017 09:17:58 -0500
MIME-Version: 1.0
In-Reply-To: <20170916185123.29255-6-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Gji95KvOTE8fsNQtNRwIabwq6r3fmQsLK"
Subject: Re: [Qemu-devel] [PATCH v5 5/6] iotests: Add test for non-string
 option reopening
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Gji95KvOTE8fsNQtNRwIabwq6r3fmQsLK
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <4848aab9-ce77-48cb-1531-54d45b361bef@redhat.com>
Subject: Re: [PATCH v5 5/6] iotests: Add test for non-string option reopening
References: <20170916185123.29255-1-mreitz@redhat.com>
 <20170916185123.29255-6-mreitz@redhat.com>
In-Reply-To: <20170916185123.29255-6-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/16/2017 01:51 PM, Max Reitz wrote:
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/133     | 9 +++++++++
>  tests/qemu-iotests/133.out | 5 +++++
>  2 files changed, 14 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Gji95KvOTE8fsNQtNRwIabwq6r3fmQsLK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm/1ZYACgkQp6FrSiUn
Q2on+wf+JxeuX0FXPl891io0gw+5Qjh/brBpCscLFF3FhG2wfHqrcw2rQLdXrwW2
VlxhgfvlSD9cRAJ9ZYCbp0vnzvrdcfiGsPV7fa8QA5QFlnL/1uBxEI1qvW33Wa+d
kD2KDkxsSAz4QepWe8qebFDxgAvvtlGqKilrPPlfu76KzhxuEJC19euLoSQe419A
y+90XL+yCjctL1z6/h6XhNQs8LdfSf0PyfwO+ekVoQJoQLFxdHN2hoGgADQK7icU
eaJ26TyERbgfdGyQgSjU0x4my79TQfnjp2zPPXfOdXPzUjtqqWAYoYHf/qPzxbt8
7XRlgMpbIxMd7WYrNIywu7aiCNX2ug==
=B70L
-----END PGP SIGNATURE-----

--Gji95KvOTE8fsNQtNRwIabwq6r3fmQsLK--

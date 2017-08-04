Received: from eggs.gnu.org ([2001:4830:134:3::10]:55317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddb9c-0005EG-T7
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddb7w-00026k-9C
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:52:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ddb7v-00024u-AO
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:50:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 151015F7B0
	for <qemu-devel@nongnu.org>; Fri,  4 Aug 2017 11:50:46 +0000 (UTC)
References: <150181165680.60.17068931498958654477@93e45bedd699>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d13bf86c-036d-4178-9d1d-52443ba226b6@redhat.com>
Date: Fri, 4 Aug 2017 06:50:42 -0500
MIME-Version: 1.0
In-Reply-To: <150181165680.60.17068931498958654477@93e45bedd699>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="i5GcPpL0cKn1Kjre6R64lm5OvXmduuKvW"
Subject: Re: [Qemu-devel] [PATCH v4 00/22] Clean up around qmp() and hmp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i5GcPpL0cKn1Kjre6R64lm5OvXmduuKvW
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, armbru@redhat.com
Message-ID: <d13bf86c-036d-4178-9d1d-52443ba226b6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/22] Clean up around qmp() and hmp()
References: <150181165680.60.17068931498958654477@93e45bedd699>
In-Reply-To: <150181165680.60.17068931498958654477@93e45bedd699>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/03/2017 08:54 PM, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed automatic build test. Please find the testing comman=
ds and
> their output below. If you have docker installed, you can probably repr=
oduce it
> locally.

When will patchew have a syntax for stating dependencies? (Of course, I
should actually mention those dependencies in my cover letter, not after
the fact).

> /tmp/qemu-test/src/tests/test-qga.c: In function =E2=80=98test_qga_set_=
time=E2=80=99:
> /tmp/qemu-test/src/tests/test-qga.c:652: warning: implicit declaration =
of function =E2=80=98qmp_fd=E2=80=99

This patch series depends on my earlier cleanup:
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg00385.html
[PATCH] test-qga: Kill broken and dead QGA_TEST_SIDE_EFFECT

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--i5GcPpL0cKn1Kjre6R64lm5OvXmduuKvW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmEX5IACgkQp6FrSiUn
Q2qzlAf/dV8pxxv8h5i1kzWZxv2rwNFe+zpTuKk6fqz5124XId0iCl3XezWHS52m
cjZCqm7WXbCifae3YVYR1iDB7tBHEt0R0q/ddEP9UyKoiU5/EQUW+1zdkxeTlWWl
lYFERHf1oo0m3Aj9vS0sFjejzOIG308Y9cnTUNi3X+jKmHp3sfo6toDaZ/I/Yl/M
jCEo87AaYvlkDFaQj0OtfdXe2vd3OK4JExA0vL9YvfXfbU1E7kaZZEJJsThq/iSG
tQ/L9Wl7cVvRl08TdE7RjXlpZycVjfBVsDj2ThF6A0Pu5hpfVfyPYXj8fLwokZvb
AIQGRLTqFQ/PmADsgaAFu+E1o4LKLw==
=i3NH
-----END PGP SIGNATURE-----

--i5GcPpL0cKn1Kjre6R64lm5OvXmduuKvW--

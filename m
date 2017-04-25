Received: from eggs.gnu.org ([2001:4830:134:3::10]:38567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d30KW-0004Wl-GH
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d30KS-00064o-28
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:16:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d30KR-00064Q-TK
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:16:28 -0400
References: <C6D1F9E0-0379-4DC5-927A-A32D2281937D@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9d8c02d4-952b-170c-5441-626aa296a582@redhat.com>
Date: Tue, 25 Apr 2017 08:16:20 -0500
MIME-Version: 1.0
In-Reply-To: <C6D1F9E0-0379-4DC5-927A-A32D2281937D@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SRcme1PQGIVrIMtHaD66vbsOf6VEe8oqH"
Subject: Re: [Qemu-devel] [PATCH 1/9] Add ppc.risu file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SRcme1PQGIVrIMtHaD66vbsOf6VEe8oqH
From: Eric Blake <eblake@redhat.com>
To: G 3 <programmingkidx@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>
Message-ID: <9d8c02d4-952b-170c-5441-626aa296a582@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/9] Add ppc.risu file
References: <C6D1F9E0-0379-4DC5-927A-A32D2281937D@gmail.com>
In-Reply-To: <C6D1F9E0-0379-4DC5-927A-A32D2281937D@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2017 10:17 PM, G 3 wrote:
> Add the ppc.risu file. It defines the format for various PowerPC
> instructions.

Your emails are missing In-Reply-To and References headers, which means
you posted 10 top-level threads instead of 9 replies to the 0/9 cover
letter. Please fix that, as it becomes awkward to track a series that is
not properly threaded.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SRcme1PQGIVrIMtHaD66vbsOf6VEe8oqH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY/0wkAAoJEKeha0olJ0NqFQYH/1BjjAg3zCOlbjaC9bmkITCN
KtQlr5ArExHgvCyHEP4gj00prORypW+DGDo2qpdNecz8ctOAJ2JNdnp+kCxN8puL
zKgp4xepMfQ2enX1UruZNi/2WPBJG0DWqAGHdMTPP7bPRWsPnf2cu4Op6R1Na3vu
i4+kPc4LT4ZXKLAJ7NIWt8AstodmCK4ubyNll6FelBxX6q1RNQenIV8OMbRod5Mn
jPqsZ9l/YQ8kpJG9eAIgaMtHX1nCOcsktxwuKd+o2UzhDlv7DGscLiE+aYQAW5eN
MBuQ+E8InnlGllGfb8nGythyYK7fsELuxvLpFV5RHHIQxlj2lu8j3Xfu+hKydQs=
=mohD
-----END PGP SIGNATURE-----

--SRcme1PQGIVrIMtHaD66vbsOf6VEe8oqH--

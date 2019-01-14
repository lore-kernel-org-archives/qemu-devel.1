Received: from eggs.gnu.org ([209.51.188.92]:36681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj5Nj-0003lJ-0T
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:46:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj5Ne-0000D7-JH
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:46:32 -0500
References: <20190112175812.27068-1-eblake@redhat.com>
	<963d830d-690a-09cd-4939-79096b62cf35@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8b84e314-db63-5125-b942-54732fc2a241@redhat.com>
Date: Mon, 14 Jan 2019 10:46:07 -0600
MIME-Version: 1.0
In-Reply-To: <963d830d-690a-09cd-4939-79096b62cf35@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TdLNryfFpc0NKNdrR8keZ4a91Ynf37olN"
Subject: Re: [Qemu-devel] [PATCH v3 00/19] nbd: add qemu-nbd --list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TdLNryfFpc0NKNdrR8keZ4a91Ynf37olN
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>,
 "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Message-ID: <8b84e314-db63-5125-b942-54732fc2a241@redhat.com>
Subject: Re: [PATCH v3 00/19] nbd: add qemu-nbd --list
References: <20190112175812.27068-1-eblake@redhat.com>
 <963d830d-690a-09cd-4939-79096b62cf35@virtuozzo.com>
In-Reply-To: <963d830d-690a-09cd-4939-79096b62cf35@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/14/19 6:22 AM, Vladimir Sementsov-Ogievskiy wrote:

>>
>> Also available at:
>> https://repo.or.cz/qemu/ericb.git qemu-nbd-list-v2
>=20
> hmm, not -v2. But not -v3 too, as  I've tried to apply these patches on=

> -v3 base (commit under "maint: Allow for EXAMPLES in texi2pod") and it
> failed.
>=20
> Could you please fix tag?

Yes, I typo'd my intent to advertise a v3 tag.  To avoid confusion with
anyone that may have already pulled the old tag, I've now pushed a
qemu-nbd-list-v3a tag, on top of my most recent pull request.

Based-on:
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg02960.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--TdLNryfFpc0NKNdrR8keZ4a91Ynf37olN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw8vM8ACgkQp6FrSiUn
Q2oWXAgAkWDGR3QfZYenUSohalLxu/gmdhghfU/OEtJJ6guurIPra3JD0p85MXWa
pyEj/NZgTeA+lqhWqBOnS4JxJ5chFjpwFHCFhJ+gp+tJQBMfhe1T8bhRR0sy+2uN
4SRXinXrtJ6DuAO8bp+N/b18rY3cafiQcepPXViTcibTtvhiSn98bVBP9GuHiR1L
gTSOCl9cdG0NOD2nJjz1vCwddDOqeBAoOzlHbjF/jK8AB0cOhqTLskIeEgWUh4OH
ipR9qZ1jmdvBXXb6A7P/l81zvAb6IdmLjxcnqonXLyMuhvcj5l2tfSbcQfDLsZMq
DLW3NnoYBcDYSvatTTEqA2wmJQ7UmQ==
=a7ur
-----END PGP SIGNATURE-----

--TdLNryfFpc0NKNdrR8keZ4a91Ynf37olN--

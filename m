Received: from eggs.gnu.org ([2001:4830:134:3::10]:53900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cftxa-0000Eb-CM
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:49:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cftxX-00018b-Q1
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:49:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cftxX-00018V-KH
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:49:19 -0500
References: <1487614915-18710-1-git-send-email-den@openvz.org>
	<1487614915-18710-4-git-send-email-den@openvz.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4cc8f4df-ee57-48bb-f6ca-1922232b49cf@redhat.com>
Date: Mon, 20 Feb 2017 13:49:17 -0600
MIME-Version: 1.0
In-Reply-To: <1487614915-18710-4-git-send-email-den@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8HnLjMhHE1wJERq1E9O96HCs0RU0CniSO"
Subject: Re: [Qemu-devel] [PATCH 3/3] qmp-events: fix GUEST_PANICKED
 description formatting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8HnLjMhHE1wJERq1E9O96HCs0RU0CniSO
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4cc8f4df-ee57-48bb-f6ca-1922232b49cf@redhat.com>
Subject: Re: [PATCH 3/3] qmp-events: fix GUEST_PANICKED description formatting
References: <1487614915-18710-1-git-send-email-den@openvz.org>
 <1487614915-18710-4-git-send-email-den@openvz.org>
In-Reply-To: <1487614915-18710-4-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/20/2017 12:21 PM, Denis V. Lunev wrote:
> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> ---
>  qapi/event.json | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--8HnLjMhHE1wJERq1E9O96HCs0RU0CniSO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYq0g9AAoJEKeha0olJ0NqCjsIAIXy7k5BiIuGvM/S4kSvf99l
lF3IiLZ2/hZ65MXA+NOktftJ3Aw9+FyXBvVPaPTdAfwrV/KEHuQKp9I6BIyX+L6f
jJv7DRta3Je4fZ4UkNMbJo7O0QMCba4O4gC77pMonlcruLxNx6ql9Dn57kk/wGV8
7dAfZWMlFcu3wNJTLOFtzvumCcz55pXRnm2rB2IOHEvX4oxI5lmrkAwETmcdUgdo
fw82Vq7AOZkgYGnPTa7LfzD+DSlTPsumFkZOeYsi7VopNWX4wMuJ5EOo/R+la6Cb
tbN8qMAqVXbBdRIR+WTc1qGPN/cAqCi4wnZgtfqK67Y4zWR0puUmsDNlBHLmWbU=
=0gWu
-----END PGP SIGNATURE-----

--8HnLjMhHE1wJERq1E9O96HCs0RU0CniSO--

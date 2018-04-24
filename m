Received: from eggs.gnu.org ([2001:4830:134:3::10]:38935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB6B8-00077b-SK
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 18:12:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB6B8-0003tN-1u
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 18:12:50 -0400
References: <20180424152515.25664-1-kwolf@redhat.com>
	<20180424152515.25664-9-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b71fb9db-96ba-01df-3212-6bae5c11eb1e@redhat.com>
Date: Tue, 24 Apr 2018 17:12:32 -0500
MIME-Version: 1.0
In-Reply-To: <20180424152515.25664-9-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2fpSZT7LLb96QqL5CjuZFZSpCMvYaC8LT"
Subject: Re: [Qemu-devel] [RFC PATCH 08/33] job: Rename BlockJobType into
 JobType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2fpSZT7LLb96QqL5CjuZFZSpCMvYaC8LT
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Message-ID: <b71fb9db-96ba-01df-3212-6bae5c11eb1e@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 08/33] job: Rename BlockJobType into
 JobType
References: <20180424152515.25664-1-kwolf@redhat.com>
 <20180424152515.25664-9-kwolf@redhat.com>
In-Reply-To: <20180424152515.25664-9-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2018 10:24 AM, Kevin Wolf wrote:
> QAPI types aren't externally visible, so we can rename them without
> causing problems. Before we add a job type to Job, rename the enum
> so it can be used for more than just block jobs.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2fpSZT7LLb96QqL5CjuZFZSpCMvYaC8LT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrfq9AACgkQp6FrSiUn
Q2p7mQf/Ru8HTeVhH33pzslWJMSH1LhREgZmqa3PXnNFZq6imuB55Ack0V7nnhsh
V8Pkxvpsd4f09hxG1Fp+AOqi31+OFjBhw4wwZ1xhiF0yYrlWwo1yLpUBliOzqv6n
uBxeDOfRoT7AWiOEbwsgxdFgLQ+5HSOhVornnreHuEBrIJ+0JHurEgbB1pjc8q9h
24ZylgXtI33CZBbNF6mWGQjXknwHAthPzIEMkFgCS3oNVQdiVffaeXPoU5tgoE81
AOV/1IEpTeO2JYTkldOhsdLEPUUYtdoityiAaBBWMvFkRW0Xq+U3k02eEwbyKM8f
tsyjx02qWvyLg8SKE3LE/IU9dWG7mA==
=7w6e
-----END PGP SIGNATURE-----

--2fpSZT7LLb96QqL5CjuZFZSpCMvYaC8LT--

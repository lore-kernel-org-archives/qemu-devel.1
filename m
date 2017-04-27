Received: from eggs.gnu.org ([2001:4830:134:3::10]:47481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3jSB-0006g0-CV
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 09:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3jSA-00049s-DF
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 09:27:27 -0400
References: <1493298053-17140-1-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <22482bc3-73c5-e4ad-d19c-9f5795464f24@redhat.com>
Date: Thu, 27 Apr 2017 08:27:22 -0500
MIME-Version: 1.0
In-Reply-To: <1493298053-17140-1-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XrJt2ktP5k6pRCmh3IJPeL0gLMbGtLkfH"
Subject: Re: [Qemu-devel] [PATCH] replication: Make --disable-replication
 compile again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: wencongyang@gmail.com, zhang.zhanghailiang@huawei.com, zhangchen.fnst@cn.fujitsu.com, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XrJt2ktP5k6pRCmh3IJPeL0gLMbGtLkfH
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: wencongyang@gmail.com, zhang.zhanghailiang@huawei.com,
 zhangchen.fnst@cn.fujitsu.com, qemu-stable@nongnu.org
Message-ID: <22482bc3-73c5-e4ad-d19c-9f5795464f24@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] replication: Make --disable-replication
 compile again
References: <1493298053-17140-1-git-send-email-armbru@redhat.com>
In-Reply-To: <1493298053-17140-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2017 08:00 AM, Markus Armbruster wrote:
> Broken in commit daa33c5.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  migration/colo.c | 12 ++++++++++++
>  monitor.c        |  5 +++++
>  2 files changed, 17 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XrJt2ktP5k6pRCmh3IJPeL0gLMbGtLkfH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAfG6AAoJEKeha0olJ0NqUA8IAKJsY6BTDnIFG3godvbQdfrV
FVUsVlfZCpbqPUzxOgv3uMKqghhChri27Muc2pONUVLaKo4c1Ix7Kyx/hTK82czp
TaGCqaDaEd/N1vRfRoCnBd1twxbPornQYOyLciaItd0+85ECnIYtajCHcKUmhphK
sjUzLWwopA6SMiApDNxRkwUYAYBeA1hWQpGLfIg281V+XP4k79At2VmO01YIvL+p
tzGPUkEYkg6wuATwKFagfQiM1crEluyKoSP7Vn4E4FWXqI4zYauUFFCaMdqaNO6q
IwDSJj4Kx3OJATW4IYHSGkfG2IuQuqJpOzNjdQxZSK46mQlNpAikw9Mnhur0Ad0=
=LncW
-----END PGP SIGNATURE-----

--XrJt2ktP5k6pRCmh3IJPeL0gLMbGtLkfH--

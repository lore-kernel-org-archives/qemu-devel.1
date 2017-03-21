Received: from eggs.gnu.org ([2001:4830:134:3::10]:33544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqA3A-0006VE-J0
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqA37-0006uK-Hp
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:01:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cqA37-0006tG-8c
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:01:29 -0400
References: <1490064541056-474448.post@n7.nabble.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d866690e-fa74-147b-93d1-df60348df653@redhat.com>
Date: Mon, 20 Mar 2017 22:01:24 -0500
MIME-Version: 1.0
In-Reply-To: <1490064541056-474448.post@n7.nabble.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rv0VNFbPj2lCsCh7tpijLBQW9mnTtWffm"
Subject: Re: [Qemu-devel] Subject: [PATCH]COLO: Fix spell error in Colo doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wangguang <wang.guang55@zte.com.cn>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rv0VNFbPj2lCsCh7tpijLBQW9mnTtWffm
From: Eric Blake <eblake@redhat.com>
To: wangguang <wang.guang55@zte.com.cn>, qemu-devel@nongnu.org
Message-ID: <d866690e-fa74-147b-93d1-df60348df653@redhat.com>
Subject: Re: [Qemu-devel] Subject: [PATCH]COLO: Fix spell error in Colo doc
References: <1490064541056-474448.post@n7.nabble.com>
In-Reply-To: <1490064541056-474448.post@n7.nabble.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/20/2017 09:49 PM, wangguang wrote:
> This is an error in COLO-FT.txt.=20
> secondeary-disk0 should be secondary-disk0.=20
>=20
> Signed-off-by: Guang Wang <wang.guang55@zte.com.cn>

This is now version 6 of a patch, but failed to include that information
in the subject line.  'git send-email -v6' would do that automatically
for you.

> ---=20

I already gave a positive review on v4, and repeated that on v5.  If you
are going to continue sending revisions to the list (rather than relying
on a maintainer to fix things up), then please remember to add
Reviewed-by tags from earlier revisions if you didn't change any code,
or else to include a changelog highlighting your code changes.

Other advice on sending a good patch can be seen at:
http://wiki.qemu-project.org/Contribute/SubmitAPatch

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--rv0VNFbPj2lCsCh7tpijLBQW9mnTtWffm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0JeEAAoJEKeha0olJ0NquGsIAI6MDa3o+Ud5iuo1McEzZxf6
oFkquEGnsD/VfAHyilKkdqqdB7GkgR2P7DgamS/Ky0kasibf5587KBJB6cKlQfkf
rvmS+qbs1pQLy6yaljRJi7stqQ6+XClIyKHPNV9DrVLY/sR1Xgxhs0XtunACdfJJ
lo79IuvNZORqnQZr8+U6urLXraNeldvXlz0r7jqlx+C1IffNv9vtR5VaWxn0tUbR
l/Ow4og7iRGfL6OU0ky8rcaIIXYr8gvTh9GZMQijGL5+wjgvT1kYm0MHa9BZJtuo
8ZhUui2N2T6m/7Nm27voeZ9GQI/wFKPOibzz2WT+pFBz8f82bu3B8IVU01L3q4s=
=pdPg
-----END PGP SIGNATURE-----

--rv0VNFbPj2lCsCh7tpijLBQW9mnTtWffm--

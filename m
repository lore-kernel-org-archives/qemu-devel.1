Received: from eggs.gnu.org ([2001:4830:134:3::10]:54293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQh4L-0005wv-8r
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:01:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQh4I-0007fw-8D
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:01:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cQh4H-0007fk-VH
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:01:26 -0500
References: <1483981368-9965-1-git-send-email-ashijeetacharya@gmail.com>
	<1483981368-9965-5-git-send-email-ashijeetacharya@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3b22cfb0-ae57-0330-5b85-1ed4e910dfcb@redhat.com>
Date: Mon, 9 Jan 2017 15:01:21 -0600
MIME-Version: 1.0
In-Reply-To: <1483981368-9965-5-git-send-email-ashijeetacharya@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sGMSWp0dlNbqCAxqmGndjahHmuk4DBJQ7"
Subject: Re: [Qemu-devel] [PATCH v4 4/4] migration: Fail migration blocker
 for --only-migratble
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>, dgilbert@redhat.com
Cc: kwolf@redhat.com, peter.maydell@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org, mst@redhat.com, armbru@redhat.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, marcandre.lureau@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sGMSWp0dlNbqCAxqmGndjahHmuk4DBJQ7
From: Eric Blake <eblake@redhat.com>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>, dgilbert@redhat.com
Cc: kwolf@redhat.com, peter.maydell@linaro.org, quintela@redhat.com,
 qemu-devel@nongnu.org, mst@redhat.com, armbru@redhat.com, groug@kaod.org,
 aneesh.kumar@linux.vnet.ibm.com, marcandre.lureau@redhat.com,
 amit.shah@redhat.com, pbonzini@redhat.com, jsnow@redhat.com
Message-ID: <3b22cfb0-ae57-0330-5b85-1ed4e910dfcb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 4/4] migration: Fail migration blocker for
 --only-migratble
References: <1483981368-9965-1-git-send-email-ashijeetacharya@gmail.com>
 <1483981368-9965-5-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1483981368-9965-5-git-send-email-ashijeetacharya@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/09/2017 11:02 AM, Ashijeet Acharya wrote:

s/migratble/migratable/ in the subject

> migrate_add_blocker should rightly fail if the '--only-migratable'
> option was specified and the device in use should not be able to
> perform the action which results in an unmigratable VM.
>=20
> Make migrate_add_blocker return -EACCES in this case.
>=20
> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
> ---


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--sGMSWp0dlNbqCAxqmGndjahHmuk4DBJQ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYc/ohAAoJEKeha0olJ0Nqr2QH/2Mi75bLAvZSuYreL0n69Zxm
ao0YNjESL79mWTyE4KK7WJ8d2lW59ta2o5lz+bD4xDlQ2/WNguEEBpurse+e5dcl
AdB/Dja44vUGp15QiL4H33kLU8VObhLSGDUYZkgVSlVZD8IlF+hpykcn29ROobWt
KTGypWLadKVSQO5caZUxA4ogcfXVL0uR63w7hWZo3yPYWxZvFh4UtExLVnhl5rp0
EcsoJAmyeX93XqnuQ+X78esg0vshtR/tWeoq25J+MqlgitBzhRWuVhMoDOIeguzt
jGxp7XdyYRDzRUERQw/h8zYrRpcHs1RNF26bNzPak3V+Jo4Qwj4hJazQyOw58lg=
=VrO7
-----END PGP SIGNATURE-----

--sGMSWp0dlNbqCAxqmGndjahHmuk4DBJQ7--

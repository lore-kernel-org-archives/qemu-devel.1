Received: from eggs.gnu.org ([2001:4830:134:3::10]:54977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cVgP5-0002cr-Ng
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:19:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cVgP2-0003fv-Fg
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:19:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cVgP2-0003fe-9L
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:19:28 -0500
References: <1485163195-17547-1-git-send-email-pradeep.jagadeesh@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f72e7a6d-72eb-5ac0-d63d-a0fb0bf773fa@redhat.com>
Date: Mon, 23 Jan 2017 09:19:25 -0600
MIME-Version: 1.0
In-Reply-To: <1485163195-17547-1-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="T7umlHdCiNTlcc0cuJ8jI5C24tmRxurxa"
Subject: Re: [Qemu-devel] [PATCH V1] throttle:Removed duplicate throtlle
 code from block and 9p files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Greg Kurz <groug@kaod.org>
Cc: Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T7umlHdCiNTlcc0cuJ8jI5C24tmRxurxa
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Greg Kurz <groug@kaod.org>
Cc: Alberto Garcia <berto@igalia.com>,
 Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org
Message-ID: <f72e7a6d-72eb-5ac0-d63d-a0fb0bf773fa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V1] throttle:Removed duplicate throtlle code
 from block and 9p files
References: <1485163195-17547-1-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1485163195-17547-1-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/23/2017 03:19 AM, Pradeep Jagadeesh wrote:

s/throtlle/throttle/ in the subject line (as is, the subject is rather
long, and missing a space after ':')

> This will allow other subsystems (i.e. fsdev) to implement throttling
> without duplicating the command line options.
>=20
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> ---

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--T7umlHdCiNTlcc0cuJ8jI5C24tmRxurxa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYhh79AAoJEKeha0olJ0NqbisH/0c5C0WF2pZ1Bu/cGRntH2k8
6NT77PwEPBYapGnUU9A4mFgglwo1OcriJhNXG0YV9+BFHoFit01CIhe3sOOqOj+h
rh6gntBe6ItKoNz6j22V7bSrIIPAMxccVjRSrkW1T0Ga/Q1nNzzzvQOR8odGm7bp
fUJ+jue8TamYYGWBh//q2E55ZpRtIY+MP6xz1vny1J/NxW26HS7Kes8ae0GHSWmo
D93PxOclPb5R6C1vX63oV870l65UhUBexdMwN/GPlpFJuUpkP/mTi901VrmsdKuo
AaBlF025o8cpAAUMU8TwdmcxF8fVRFeTWs7EAUHGlWkeamVan7A9pxIkxFwYpOE=
=xURu
-----END PGP SIGNATURE-----

--T7umlHdCiNTlcc0cuJ8jI5C24tmRxurxa--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cq3Ws-00016P-HA
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 16:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cq3Wr-0004oo-Ci
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 16:03:46 -0400
References: <1490014548-15083-1-git-send-email-armbru@redhat.com>
	<1490014548-15083-6-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c2110a8d-b4f8-3781-469c-59b99a062d6a@redhat.com>
Date: Mon, 20 Mar 2017 15:03:37 -0500
MIME-Version: 1.0
In-Reply-To: <1490014548-15083-6-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JpsBTp8a5VXR2wb8R2tmpSVWFk4KIMJGQ"
Subject: Re: [Qemu-devel] [PATCH for-2.9 5/5] MAINTAINERS: Add myself for
 files I touched recently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JpsBTp8a5VXR2wb8R2tmpSVWFk4KIMJGQ
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <c2110a8d-b4f8-3781-469c-59b99a062d6a@redhat.com>
Subject: Re: [PATCH for-2.9 5/5] MAINTAINERS: Add myself for files I touched
 recently
References: <1490014548-15083-1-git-send-email-armbru@redhat.com>
 <1490014548-15083-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1490014548-15083-6-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/20/2017 07:55 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

By the way, where do we stand on the idea of having checkpatch.pl reject
patches that introduce new files without mentioning a maintainer?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--JpsBTp8a5VXR2wb8R2tmpSVWFk4KIMJGQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0DWZAAoJEKeha0olJ0NqXmoIAIsTEXPGo61O6e7cDkxz7Yl4
7z0GtTV5m4YlE5u4ellgKX2KF07SlhhLwDCdZZrcrZzzF4V9J0+JCTOlsuasEITu
pJouq8vMz1dixKaH34Gv6zxdO08aVE75ODUHFXr2/PIfICeC0y9FZFm9jBmILqVq
c7ji1AwdcSukrlipSs5rKHR12g1tHeZ4SjXz0GTndvMsP8v9LrGabtYA3+3Nzret
KPyegpcOjMeEzwgxrzLMI1Qo459xuR1agCnkl5RFpwvUF3HHBSrDetrrvl09amWQ
6MB+rgUUiZDAZU93sttxHZeHKLvC8FjB7IHaKrwuuCgBFbbUlt4wuPVnLqN6Bio=
=NF6a
-----END PGP SIGNATURE-----

--JpsBTp8a5VXR2wb8R2tmpSVWFk4KIMJGQ--

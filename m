Received: from eggs.gnu.org ([2001:4830:134:3::10]:39338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cntL1-0002U1-Ts
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cntKx-0007nM-BK
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:46:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cntKx-0007mu-6J
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:46:31 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-34-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b4d7801f-8710-1fd7-e491-7e582ddbc051@redhat.com>
Date: Tue, 14 Mar 2017 15:46:28 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-34-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cfSIQn2vwJR0J5L24eLWWantWERbOkPLw"
Subject: Re: [Qemu-devel] [PATCH for-2.9 33/47] qapi: Improve error message
 on @NAME: in free-form doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cfSIQn2vwJR0J5L24eLWWantWERbOkPLw
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <b4d7801f-8710-1fd7-e491-7e582ddbc051@redhat.com>
Subject: Re: [PATCH for-2.9 33/47] qapi: Improve error message on @NAME: in
 free-form doc
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-34-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-34-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi.py                           | 17 ++++++-----------
>  tests/qapi-schema/doc-invalid-section.err |  2 +-
>  2 files changed, 7 insertions(+), 12 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--cfSIQn2vwJR0J5L24eLWWantWERbOkPLw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyFakAAoJEKeha0olJ0NqqhEH/0zgwGiNmXbpS5kbnKFfCrt3
lbPIa7tOKfzlTVbBVP1pxrg68TP8SHRPdYLgZ/RbvT8o+Nw212JCHQq48X2ixJ32
6P+CvPN1Q4qKS41B1m49bEtLJsjAvIuRlvNm0TGQNmLAwe5GvOzTEZHp2FF6HEH6
cSTXGEOVaPxITq/IRdKjnfRf05nEuNzdTHt53X5dM/ESNj07KAN9a7EjCZA+Wd5z
jiCUPqSGb80wSa8mpNIzR2pGua48ZsJddlLgq2GeHd9DwLuTwqfVCxxeR57a6qA/
kaPprfkw3+VqGs5ktlIVR+Zh5/tClDlEyN2tapZd/B3WoD+o+7gLrZNK9PI+6sk=
=ZSu1
-----END PGP SIGNATURE-----

--cfSIQn2vwJR0J5L24eLWWantWERbOkPLw--

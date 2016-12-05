Received: from eggs.gnu.org ([2001:4830:134:3::10]:55976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cE0cc-0002sE-QA
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:16:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cE0cY-0001bs-R4
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:16:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cE0cY-0001b7-IY
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:16:22 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD433883A4
	for <qemu-devel@nongnu.org>; Mon,  5 Dec 2016 21:16:21 +0000 (UTC)
References: <1478105438-20883-1-git-send-email-prasanna.kalever@redhat.com>
	<1478105438-20883-4-git-send-email-prasanna.kalever@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <732df575-5fe6-9d4f-f72b-7e164b18716a@redhat.com>
Date: Mon, 5 Dec 2016 15:16:12 -0600
MIME-Version: 1.0
In-Reply-To: <1478105438-20883-4-git-send-email-prasanna.kalever@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gbqHkbCtC0G1rSkhavLooQqsoPdE2e1xg"
Subject: Re: [Qemu-devel] [PATCH for-2.8 v3 3/3] qemu-doc: update gluster
 protocol usage guide
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, qemu-devel@nongnu.org
Cc: jcody@redhat.com, vbellur@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gbqHkbCtC0G1rSkhavLooQqsoPdE2e1xg
From: Eric Blake <eblake@redhat.com>
To: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 qemu-devel@nongnu.org
Cc: jcody@redhat.com, vbellur@redhat.com
Message-ID: <732df575-5fe6-9d4f-f72b-7e164b18716a@redhat.com>
Subject: Re: [PATCH for-2.8 v3 3/3] qemu-doc: update gluster protocol usage
 guide
References: <1478105438-20883-1-git-send-email-prasanna.kalever@redhat.com>
 <1478105438-20883-4-git-send-email-prasanna.kalever@redhat.com>
In-Reply-To: <1478105438-20883-4-git-send-email-prasanna.kalever@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/02/2016 11:50 AM, Prasanna Kumar Kalever wrote:
> Document:
> 1. The new debug and logfile options with their usages
> 2. New json format and its usage and
> 3. update "GlusterFS, Device URL Syntax" section in "Invocation"
>=20
> Signed-off-by: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> ---
>  qemu-doc.texi   | 59 +++++++++++++++++++++++++++++++++++++++++++------=
--------
>  qemu-options.hx | 25 ++++++++++++++++++++++--
>  2 files changed, 68 insertions(+), 16 deletions(-)

This is documentation-only, so it should be safe (even if a bit late)
for inclusion in 2.8.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--gbqHkbCtC0G1rSkhavLooQqsoPdE2e1xg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYRdkcAAoJEKeha0olJ0Nq1bUIAIHMBsNcMvJrRp4N4R2WVFI8
UvFwbXR24cnMLbsiELQzDtrW9hKlCq1gFG25Sff8Qsz4N4WcEDhh/RBLLc3uZzkf
nTU71rlrfGOOKtoYHXsOcHsn97UHYmZnGnz/IuVe6VGiMlHpkSVVD13cUzrBoJ2a
uBa+rPXV2Zpz6sqKqarxepOuUI+9oIq+ZoE3kCcYtM/tvHEL7LO7SRFjxpfxLZL3
LxgrC66iVA1JgQi0yO373MkUcQ6er3wyaLqRaA6vNvIWalmAS+aEo4ek/SJYgTuH
hCQN5z+iD3MTT8gUlybQmHMLGgVAAOi01xw3U/5abtD46Vc1fKk9yf0dparZax0=
=QE6D
-----END PGP SIGNATURE-----

--gbqHkbCtC0G1rSkhavLooQqsoPdE2e1xg--

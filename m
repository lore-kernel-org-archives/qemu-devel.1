Received: from eggs.gnu.org ([2001:4830:134:3::10]:34186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw7kJ-0004v1-BI
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw7kE-0000oR-I3
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:46:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cw7kE-0000o8-BV
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:46:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 46CFD3DBC2
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 13:46:37 +0000 (UTC)
References: <20170406131326.2418-1-quintela@redhat.com>
	<20170406131326.2418-2-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e1ac640f-23ed-e311-c45d-55c86ff929e1@redhat.com>
Date: Thu, 6 Apr 2017 08:46:30 -0500
MIME-Version: 1.0
In-Reply-To: <20170406131326.2418-2-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iaaFdg1GqaWCssmjGXSKtgX1R3ghHC2Ml"
Subject: Re: [Qemu-devel] [PATCH 1/5] qdev: qdev_hotplug is really a bool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iaaFdg1GqaWCssmjGXSKtgX1R3ghHC2Ml
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com
Message-ID: <e1ac640f-23ed-e311-c45d-55c86ff929e1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] qdev: qdev_hotplug is really a bool
References: <20170406131326.2418-1-quintela@redhat.com>
 <20170406131326.2418-2-quintela@redhat.com>
In-Reply-To: <20170406131326.2418-2-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2017 08:13 AM, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/core/qdev.c         | 4 ++--
>  include/hw/qdev-core.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--iaaFdg1GqaWCssmjGXSKtgX1R3ghHC2Ml
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5ka2AAoJEKeha0olJ0Nq+CAH/A3TNGL4LUBljB+HF9LBS+ES
a6rrMJ81LqoPcVmzS5d12O0MPDGMyxIKVy5Oi6tKazCemD3bMVRHnZYkeu6+wsd4
hSSdK09Qss5UYAfHhBr1Kaa/0pOohqZ3hgGxCQA0cGEB/FvzJwrmWwAHxAt0UPP6
Lip5i0uBuFnoUcm0YWWKaAywhgivJop6NE8gwWXY9ZhuUeSTF0oBNSysfGXjTkiV
HAu+EOHjr+XgKdYSOXdxxUxhiE7c0nlcAZIOqjM/iG2YpG7oUgDxtPRQrgoAru6q
3dJ53kOladfWkOGVtwN7k4vSM6abZpgbw72EH2OXe6PDNpXbFdJcXFhAChc3sYY=
=Ge2B
-----END PGP SIGNATURE-----

--iaaFdg1GqaWCssmjGXSKtgX1R3ghHC2Ml--

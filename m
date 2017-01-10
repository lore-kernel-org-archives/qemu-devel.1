Received: from eggs.gnu.org ([2001:4830:134:3::10]:39341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cQr8p-0000Ba-Ts
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 02:46:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cQr8l-0004Lw-0D
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 02:46:47 -0500
References: <1483966644-14049-1-git-send-email-thuth@redhat.com>
	<20170110003924.GL12515@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f52ab4ba-a80f-14ee-ee4e-09150c552627@redhat.com>
Date: Tue, 10 Jan 2017 08:46:34 +0100
MIME-Version: 1.0
In-Reply-To: <20170110003924.GL12515@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="IvD5nogs4VjjKSpW352s6Mu0UOWs9JAoo"
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/spapr: Allow POWER9 as
 hot-pluggable CPU for pseries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Bharata B Rao <bharata@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IvD5nogs4VjjKSpW352s6Mu0UOWs9JAoo
From: Thomas Huth <thuth@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf
 <agraf@suse.de>, Bharata B Rao <bharata@linux.vnet.ibm.com>
Message-ID: <f52ab4ba-a80f-14ee-ee4e-09150c552627@redhat.com>
Subject: Re: [PATCH] hw/ppc/spapr: Allow POWER9 as hot-pluggable CPU for
 pseries
References: <1483966644-14049-1-git-send-email-thuth@redhat.com>
 <20170110003924.GL12515@umbus.fritz.box>
In-Reply-To: <20170110003924.GL12515@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.01.2017 01:39, David Gibson wrote:
> On Mon, Jan 09, 2017 at 01:57:24PM +0100, Thomas Huth wrote:
>> Running "qemu-system-ppc64 -M pseries -cpu POWER9" currently does not =
work
>> yet and results in this error message:
>>
>>  qemu-system-ppc64: Unable to find sPAPR CPU Core definition
>>
>> Since we want to support the pseries machine with POWER9 in the future=
,
>> allow using POWER9 as hot-pluggable CPU there, too.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>=20
> I'm not sure it makes sense to apply this until we have at least the
> basics of the POWER9 PAPR pieces implemented in qemu.

OK, then I'll keep it in my private branch for my experiments...

 Thomas



--IvD5nogs4VjjKSpW352s6Mu0UOWs9JAoo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYdJFfAAoJEC7Z13T+cC210KIP/2Fk/dVRS6hk+Cl5+QtQ6gGv
rAg5n4r1qKEyJLbuYPWnfg2Hdg+jZv/2MH9sCTb2FU21W/+Ch4d7jJG0tafQB+mI
xRwiPUsl3xUVuxPStiJRCbpZJUGBM5ZS2TJmBNWqgxXuewuVs7VXh/tqkyQsX6QF
ur3VoItYN2MKySLlzF1rszeOZFeWXedPrA5t/Q4YfUexi38ZbhgCQXMCwncqjvve
LYeoQ8nN54EM7g8+GEXHQfv7i4LheLCIDQIMmLrkJyEEUAG/sVhxsQUNAcTXm7Wg
TakUKTRP8DPK08ELCJsZQPfqgc/ESKZNJZOpKEtqOGOIiGsGs9ndW50mCudMrAcw
t52PaIXu74124Ex6DIMMKjZRbU1OpyG0uZu30zhHLhWJmrAWPi3BIgo3u8dULB1t
sthQJiAmDMVkmisHCO3AvbOLwIYT259PEvJZrCp8Kex5JPFi7QyUcEh8pBjtJsCM
WQqm2OaO416hufFqIWn5A+Ll/O3DxTl0FKguIX9Q1BqfOp4iXHjBWVAUYHrF5Ism
oC4uWCOXHV1cq8wEYAAo9wHAU0xeYkqGEztLzxuoqlAO6D/9RsNa8EzNwUdyPW3f
k/m0+Ow+W0uERzyZfqpKuw5Vba8zx9ppVNAEWNAT7bEnUeUF+MTfMNb9M7QIZmik
qG+G5AEmJR7yzalvUr7A
=sZyo
-----END PGP SIGNATURE-----

--IvD5nogs4VjjKSpW352s6Mu0UOWs9JAoo--

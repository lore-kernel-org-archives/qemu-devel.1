Received: from eggs.gnu.org ([2001:4830:134:3::10]:56299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnooX-0004zl-8I
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:56:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnooT-0003It-E4
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:56:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnooT-0003H2-78
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:56:41 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-9-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b2ec8f48-eda6-0511-37c4-7c11e3a2e7fd@redhat.com>
Date: Tue, 14 Mar 2017 10:56:38 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-9-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JXBH3g7utN5RXRi40UX7q6cVAPu4j6HiT"
Subject: Re: [Qemu-devel] [PATCH for-2.9 08/47] tests/qapi-schema: Cover
 empty union base
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
--JXBH3g7utN5RXRi40UX7q6cVAPu4j6HiT
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <b2ec8f48-eda6-0511-37c4-7c11e3a2e7fd@redhat.com>
Subject: Re: [PATCH for-2.9 08/47] tests/qapi-schema: Cover empty union base
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-9-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> The new test case shows off qapi.py choking on an empty union base.

We're still finding ways to choke the parser ;)

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--JXBH3g7utN5RXRi40UX7q6cVAPu4j6HiT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyBK2AAoJEKeha0olJ0NqngkH/25cyTqJuMBZ8caKGu4bGb80
3pxs6qSr/BMH4xWREa+U9Nvx4Tv8d0CkA1MGpqmt4MnhhmAdIsbLKHg5Uc/nnoAr
tAI/ExzQX2fEIeyWtpE6NBG5DyUAESTQVyyFJVs0EIYUU3ndo8uE25rQ7wVtb5Ek
IGZbhLbakQBTZu3P2EtLWH7W06kQxEBzfAiUdlrk8+ZAkjdLyunQGeHZLtzqIo7/
TN7ujEP+u7D9LJX+xvzyCaI6Zx2S7lOHC7xFBHP1d/atINF31lW5r16SIUc6S8JV
FkkiWINVXNb16aDDj/h/teRNfH8Q0044lM7nIaRM2QKZdcZCNy3vFl90qXPKDz8=
=v8LY
-----END PGP SIGNATURE-----

--JXBH3g7utN5RXRi40UX7q6cVAPu4j6HiT--

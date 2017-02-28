Received: from eggs.gnu.org ([2001:4830:134:3::10]:36933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cimbE-0005Nk-RQ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:34:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cimbB-00008U-Pr
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:34:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cimbB-000089-K6
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:34:09 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9555EC049D5D
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 18:34:09 +0000 (UTC)
References: <1488303560-18803-1-git-send-email-armbru@redhat.com>
	<1488303560-18803-23-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <685f819c-bd3c-abbc-4de1-71cae3f534cf@redhat.com>
Date: Tue, 28 Feb 2017 12:34:07 -0600
MIME-Version: 1.0
In-Reply-To: <1488303560-18803-23-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rB3UXSc2j0UFrHW2I0r8IIIP3F03fjjB0"
Subject: Re: [Qemu-devel] [PATCH v3 22/26] test-qobject-input-visitor: Cover
 missing nested struct member
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rB3UXSc2j0UFrHW2I0r8IIIP3F03fjjB0
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <685f819c-bd3c-abbc-4de1-71cae3f534cf@redhat.com>
Subject: Re: [PATCH v3 22/26] test-qobject-input-visitor: Cover missing nested
 struct member
References: <1488303560-18803-1-git-send-email-armbru@redhat.com>
 <1488303560-18803-23-git-send-email-armbru@redhat.com>
In-Reply-To: <1488303560-18803-23-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/28/2017 11:39 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-qobject-input-visitor.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--rB3UXSc2j0UFrHW2I0r8IIIP3F03fjjB0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtcKfAAoJEKeha0olJ0NqLNMIAI9aiDYvsiDoxb4rY+0iW9xT
DxEfXicY6NriigdIB7xojLgqyPRvVx+TUAiwCXbxyKxktEwLfcbiAcPGBPNxqJTX
LXCldLKsjlo+Y2OA21ZTz46ux0sQvW5MhYZWNasZSyz6fEoJcjaZ13SWrhI+WcIp
aR7wMtkqYqmxlPxi6B7LExc07PDmWpG3XIFOFzPRsbtwNJbou99ypINzY7EYMRRC
MuKwzPmd/kLmID0apG6z207Pj51JqM4I5wTQvgkxJduuZIcQMA/Tg5xw1XZNP8sT
1LTh3DC02lAievWOMiLRKXHLdMDw681MqtrRsG5kN1Jsr7fI8Mj87DSQo3DP2sU=
=GTwG
-----END PGP SIGNATURE-----

--rB3UXSc2j0UFrHW2I0r8IIIP3F03fjjB0--

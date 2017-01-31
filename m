Received: from eggs.gnu.org ([2001:4830:134:3::10]:39971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYYyk-0003gs-2P
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:00:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYYyh-0002cu-3d
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:00:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cYYyg-0002ch-Uc
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:00:11 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA66765743
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 14:00:10 +0000 (UTC)
References: <1485870106-25016-1-git-send-email-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1955e341-7504-0362-343a-8908ff23ce64@redhat.com>
Date: Tue, 31 Jan 2017 08:00:05 -0600
MIME-Version: 1.0
In-Reply-To: <1485870106-25016-1-git-send-email-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CL20MtSA33FHXEXkESxpKcML5TshOOaKU"
Subject: Re: [Qemu-devel] [PULL 00/10] ui patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CL20MtSA33FHXEXkESxpKcML5TshOOaKU
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Message-ID: <1955e341-7504-0362-343a-8908ff23ce64@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/10] ui patch queue
References: <1485870106-25016-1-git-send-email-kraxel@redhat.com>
In-Reply-To: <1485870106-25016-1-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2017 07:41 AM, Gerd Hoffmann wrote:
>   Hi,
>=20
> Here comes the ui patch queue.  Nothing outstanding here.  Bugfixes and=

> small improvements all user interfaces.
>=20
> please pull,
>   Gerd

You probably want a v2;

>=20
> Kevin Wolf (1):
>       gtk: Hardcode LC_CTYPE as C.utf-8
>=20

Reviewers pointed out that this should be C.UTF-8.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--CL20MtSA33FHXEXkESxpKcML5TshOOaKU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYkJhlAAoJEKeha0olJ0NqaxAIAIQLbvHMz5b75ReYpNJmALqx
SCupae0CBcbCx6qskM3s4Hf+q9H2nK0tLVXGvnUpYrvcEhZaB9EWScDyljLul6cq
qISX2z3m9mkueqzFvlIEPCyRMcaJwl1mW2dQZL3IgQjzSvkC4i5HhcByjtUBQRVs
Ti/QHc1gnEPRBZHKuP2pu7XF2NQMug7MX2KmiBj7UQoB7YlhZqR8kd6T/+wbv8G3
z0bPgtPVjHPrPnKHh8/pKUtNrHnAmQG8+5IVz2p7Mhqytv3U25Ufj4Zg5zxLkeir
fEE7AXwi3EgHNP2J9BM5TG2zYhVwLmG5J6n2xlbeAM21bpRhJFOTmaG7yNONQtc=
=BpBK
-----END PGP SIGNATURE-----

--CL20MtSA33FHXEXkESxpKcML5TshOOaKU--

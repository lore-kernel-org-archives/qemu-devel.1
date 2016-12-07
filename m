Received: from eggs.gnu.org ([2001:4830:134:3::10]:36650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEdqP-0007nc-EZ
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:09:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEdqL-0007C9-6e
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:09:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cEdqL-0007Bq-0R
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:09:13 -0500
References: <20161207125130.5184-1-fziglio@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1116d039-b29e-980a-e2ba-8893dc27f5fc@redhat.com>
Date: Wed, 7 Dec 2016 09:08:59 -0600
MIME-Version: 1.0
In-Reply-To: <20161207125130.5184-1-fziglio@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eTMR2dQgBCeW6gXXtr3aH2wK4xBEUdIwn"
Subject: Re: [Qemu-devel] [PATCH] egl-helpers: Change file licensing to LGPL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frediano Ziglio <fziglio@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Cole Robinson <crobinso@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eTMR2dQgBCeW6gXXtr3aH2wK4xBEUdIwn
From: Eric Blake <eblake@redhat.com>
To: Frediano Ziglio <fziglio@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cole Robinson
 <crobinso@redhat.com>, Gonglei <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <1116d039-b29e-980a-e2ba-8893dc27f5fc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] egl-helpers: Change file licensing to LGPL2
References: <20161207125130.5184-1-fziglio@redhat.com>
In-Reply-To: <20161207125130.5184-1-fziglio@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2016 06:51 AM, Frediano Ziglio wrote:
> Signed-off-by: Frediano Ziglio <fziglio@redhat.com>

Very sparse on the commit message.  I would highly recommend being
verbose with something like "all people listed below have agreed to the
relicense" (prior to listing the signatures that have been collected in
the various threads so far), as well as stating that the relicense
permits sharing the code with LGPL Spice.  See commits 74523b8 or
2b3bc6c for examples of commit text justifying a relicense.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--eTMR2dQgBCeW6gXXtr3aH2wK4xBEUdIwn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYSCYLAAoJEKeha0olJ0Nq6j4IAJNWgNrxkoMkf91KYpZYwsx+
dHRXKnBoNoXPI5MAevTVSP8S+oBo10NC6TZ+9Boz0ih337y8nTjiZXo7TbnOqMQC
3xTIeDACmhq/GxDOlhY0x/POr6QlsHK5NXoEv7zyBX6bywmKIPJFgfL6ETHmHXcM
uLRQ3+WhTZQG+yxynnu47Nn0BIfdkzeOwv8A6xZJ+FJ5W37PFaWgJi8aLdbzqi6h
UDhvZjwDrtNH67fcV+4PMzq3wG65wJyEUgPPCQzl7HeaNFA/xfJhlm6aksos7Wic
WUo5yAUS3UG7EbRtBgdaAE00kCOaINNm+eOZ17WZVpRN+IWMpVjmr2KLWvEsdvQ=
=xB3j
-----END PGP SIGNATURE-----

--eTMR2dQgBCeW6gXXtr3aH2wK4xBEUdIwn--

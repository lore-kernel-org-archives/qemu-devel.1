Received: from eggs.gnu.org ([2001:4830:134:3::10]:37712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egZKN-0002PR-2d
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:04:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egZJt-0007NR-UI
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:04:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egZJt-0007Mk-Mb
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:03:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9F9362EA7
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 17:03:40 +0000 (UTC)
References: <20180130102202.28519-1-armbru@redhat.com>
	<20180130102202.28519-10-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b1243892-d946-e504-dbf7-941a5695439b@redhat.com>
Date: Tue, 30 Jan 2018 11:03:37 -0600
MIME-Version: 1.0
In-Reply-To: <20180130102202.28519-10-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UQ1zlhhG2IgDKeA5ygYx1gFAHzE80iQ1U"
Subject: Re: [Qemu-devel] [PATCH 09/18] Include qapi/qmp/qobject.h exactly
 where needed
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
--UQ1zlhhG2IgDKeA5ygYx1gFAHzE80iQ1U
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <b1243892-d946-e504-dbf7-941a5695439b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/18] Include qapi/qmp/qobject.h exactly
 where needed
References: <20180130102202.28519-1-armbru@redhat.com>
 <20180130102202.28519-10-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-10-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 04:21 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UQ1zlhhG2IgDKeA5ygYx1gFAHzE80iQ1U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpwpWkACgkQp6FrSiUn
Q2qRFAgAkZb/6EyPni4XZ1XZl1dRQ6qAwpDY0PsFEQGExThWEvvXONFWW7fRnYhf
NT6gt1NSnv19rMFqn1CXtatcVPQniRgQBUyVa06ZzWOOTq+j1+cn0lgdnkPWgiHg
ZwpnUDLPZr8qYn45pohkWNtfnirX4ekrYhX0uuGrJfY1DRKnaBMN9tiyBPs3/alF
bCUghYghhz9tYTsfglIRGm2PncDXLBbYpgG8L8ixJCFsBgAdI47H/iQT+/rh1FqO
bwx3HuLwYjcGFXz2zS/Y7PWAu7w/pixkRFPdmSAi23MoREEuYhx9T3mKfEeF1DQw
046Ic+PGD6xIm/0Wdujfx/+ntqoBgg==
=DVOl
-----END PGP SIGNATURE-----

--UQ1zlhhG2IgDKeA5ygYx1gFAHzE80iQ1U--

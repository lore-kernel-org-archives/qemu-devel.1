Received: from eggs.gnu.org ([2001:4830:134:3::10]:57569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fCBbB-00046D-HL
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 18:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fCBb6-0007cj-Pg
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 18:12:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51110 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fCBb6-0007cR-IW
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 18:12:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E8227B4A7
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 22:12:08 +0000 (UTC)
References: <1524841523-95513-1-git-send-email-imammedo@redhat.com>
	<1524841523-95513-7-git-send-email-imammedo@redhat.com>
	<cd942a4c-cd04-7acc-8249-96be0471af56@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <42456c6c-0c0d-ec7b-55bf-e4a5bcbd9338@redhat.com>
Date: Fri, 27 Apr 2018 17:12:07 -0500
MIME-Version: 1.0
In-Reply-To: <cd942a4c-cd04-7acc-8249-96be0471af56@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XKgzDBP432ucDFUx4YlRiOAOUXz4VGFNF"
Subject: Re: [Qemu-devel] [PATCH v6 06/11] tests: let qapi-schema tests
 detect allowed-in-preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: pkrempa@redhat.com, ehabkost@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XKgzDBP432ucDFUx4YlRiOAOUXz4VGFNF
From: Eric Blake <eblake@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: pkrempa@redhat.com, ehabkost@redhat.com, armbru@redhat.com
Message-ID: <42456c6c-0c0d-ec7b-55bf-e4a5bcbd9338@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 06/11] tests: let qapi-schema tests detect
 allowed-in-preconfig
References: <1524841523-95513-1-git-send-email-imammedo@redhat.com>
 <1524841523-95513-7-git-send-email-imammedo@redhat.com>
 <cd942a4c-cd04-7acc-8249-96be0471af56@redhat.com>
In-Reply-To: <cd942a4c-cd04-7acc-8249-96be0471af56@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2018 05:08 PM, Eric Blake wrote:
> On 04/27/2018 10:05 AM, Igor Mammedov wrote:
>> use new allowed-in-preconfig parameter in tests.
>>

>=20
> Might also be worth adding a negative test, similar to oob-test.json, a=
s
> well as tweaking qapi-schema.json to have at least one command with the=

> property set to true...

Answering myself - see patch 7.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XKgzDBP432ucDFUx4YlRiOAOUXz4VGFNF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrjoDcACgkQp6FrSiUn
Q2oPXwgAkVlNz6rnagTD3Ohk56y1dHUp2DzsRrGsZujyo2QRvx5JY0CxDsFri0vJ
O52+Lxca5SffjdMOMDiMc6B7qRgeDaWGu9mpI4abDY7/flUXiDY9zM2xwla+TkR1
vI4ycFrnHHfChm57rdqnhwUXNGCqjLvV86hqwk5gS3eBovFg+vqp/Nj81ioZnPwY
HLX7ePazT8Ci8uYEM/IF1FYBeVQFFtpAYvjtVgHoZrAdznigfUzfqu2LFKlZZZ5o
bp5nvaUzimuy/AR3YHo+a7SGzrs/Hp5hyhgOXYxWdoUv8cuvpdMfyMouQ6Sg23ae
OnpjB0YIHVE3kg/Gbg3TOh70GZivug==
=oJrn
-----END PGP SIGNATURE-----

--XKgzDBP432ucDFUx4YlRiOAOUXz4VGFNF--

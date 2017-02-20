Received: from eggs.gnu.org ([2001:4830:134:3::10]:53968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cftyE-0000ZF-W2
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:50:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cftyC-0001CQ-Dj
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:50:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cftyC-0001CK-5I
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:50:00 -0500
References: <1487266760-80500-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1487266760-80500-2-git-send-email-anton.nefedov@virtuozzo.com>
	<6882690d-5972-8b42-61ad-302531dc6d7e@redhat.com>
	<1cc2dad1-8ffd-0b7a-1a2a-881db663488f@redhat.com>
	<bfa8ba02-23a1-a30e-4d8a-8a86ed5943fe@openvz.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9f1d2fac-4760-3830-42d0-a2e3209cdf65@redhat.com>
Date: Mon, 20 Feb 2017 13:49:57 -0600
MIME-Version: 1.0
In-Reply-To: <bfa8ba02-23a1-a30e-4d8a-8a86ed5943fe@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VrHTsfiNLWmPECqC8AbiC1dqt5dF9sblK"
Subject: Re: [Qemu-devel] [PATCH] qmp-events: fix GUEST_PANICKED description
 formatting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VrHTsfiNLWmPECqC8AbiC1dqt5dF9sblK
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com
Message-ID: <9f1d2fac-4760-3830-42d0-a2e3209cdf65@redhat.com>
Subject: Re: [PATCH] qmp-events: fix GUEST_PANICKED description formatting
References: <1487266760-80500-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1487266760-80500-2-git-send-email-anton.nefedov@virtuozzo.com>
 <6882690d-5972-8b42-61ad-302531dc6d7e@redhat.com>
 <1cc2dad1-8ffd-0b7a-1a2a-881db663488f@redhat.com>
 <bfa8ba02-23a1-a30e-4d8a-8a86ed5943fe@openvz.org>
In-Reply-To: <bfa8ba02-23a1-a30e-4d8a-8a86ed5943fe@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/20/2017 12:12 PM, Denis V. Lunev wrote:

>> But for 2.9, we only need to change the union.  Eric, can you do that
>> for us since my QAPI-fu is limited?
>>
>> Paolo
>>
> give me 5 minutes, I have patches for that, received them today.

Yep, I've reviewed those patches.  Thanks for the fast followup.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--VrHTsfiNLWmPECqC8AbiC1dqt5dF9sblK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYq0hlAAoJEKeha0olJ0Nqe/EIAJAfUQy7E7QQLS7AeL1vlksA
bQGP2J55onbh813nXG54r/6vdf2MsaawdSyYO4BTXnK+Qwnf/iwXh+PFR4zNB6nk
ORxjUlNGAuGe6/aMXk6urFxF3TdisC9c+U3fdHopaD8WNxigdhtOVY8IG1J8hsVo
tKySg8TYn5YM/azgteFh6A8JpLGtCc3mIXA5oYG3/dRsTRHKQmIojeRIGNIpW7PQ
BHBRG09LQlT1wyVo5/RcLM+mJ/JJUEayqqFbJjcLEDVG2jOUcfWrRA8M8pRO6g1Q
i7NDriQsL4d+eMW5qdMlDGPBwv+gRY5WAcT7V+NobsOpG+szmHSQDU2m8Ee3C9Q=
=I7xF
-----END PGP SIGNATURE-----

--VrHTsfiNLWmPECqC8AbiC1dqt5dF9sblK--

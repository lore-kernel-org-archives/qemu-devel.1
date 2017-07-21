Received: from eggs.gnu.org ([2001:4830:134:3::10]:55368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYXDz-0006Hs-UG
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:40:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYXDw-0000Td-Nn
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:40:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYXDw-0000So-Eb
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:40:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CC7B336F08
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 12:40:03 +0000 (UTC)
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-9-quintela@redhat.com>
	<20170719170825.GI3500@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5d2a281f-0e7c-18fa-83fc-b9ae7b419dbf@redhat.com>
Date: Fri, 21 Jul 2017 07:39:58 -0500
MIME-Version: 1.0
In-Reply-To: <20170719170825.GI3500@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hu4rKTfO9DBpniCk0d478t1Nicx7UkHQx"
Subject: Re: [Qemu-devel] [PATCH v5 08/17] migration: Split
 migration_fd_process_incomming
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hu4rKTfO9DBpniCk0d478t1Nicx7UkHQx
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com
Message-ID: <5d2a281f-0e7c-18fa-83fc-b9ae7b419dbf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 08/17] migration: Split
 migration_fd_process_incomming
References: <20170717134238.1966-1-quintela@redhat.com>
 <20170717134238.1966-9-quintela@redhat.com> <20170719170825.GI3500@work-vm>
In-Reply-To: <20170719170825.GI3500@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/19/2017 12:08 PM, Dr. David Alan Gilbert wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> We need that on posterior patches.
>=20
> following/subsequent/later is probably a better word.

I'd go with 'later'.

Also, s/incomming/incoming/ in the subject

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--hu4rKTfO9DBpniCk0d478t1Nicx7UkHQx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEyBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllx9h4ACgkQp6FrSiUn
Q2rf6Af4vsrwdHqgXoE3uI2iPJv8+MOhlkJsqZThbdYF9YOntSEBTZeAO53RPhTL
TtaBAC1Uo+EH+P0JTfZJA+Jo8EqR1tJWnIFSjf3y6x3pInowT5yKeaokvQbRKEhM
dVBpQ6N0Ide3D/qlZ0OhATjz5gQjDzsqmrXaxQH2Ta/0PHefubzGTpyNm5oW3PhX
z0zyDkLTTBrmWnMGT2D4o1UsvChwjVp1EIbNpvQYmBKM8jy3Z8G2yZRb1kjqW67/
NviXmyI2FyYhNRjEs4WlSQImG1ToDSbkz+m93aNu4Tz1AqKU2cFAIJ7c/kQndgi6
klNGlEEPmO8PKFshJkq7rVWy69V6
=OKvd
-----END PGP SIGNATURE-----

--hu4rKTfO9DBpniCk0d478t1Nicx7UkHQx--

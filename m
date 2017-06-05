Received: from eggs.gnu.org ([2001:4830:134:3::10]:53045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHv4W-0000l0-5g
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHv4S-0002UT-71
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:41:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dHv4R-0002TX-UG
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:41:36 -0400
References: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
	<1496320911-51305-18-git-send-email-pbonzini@redhat.com>
	<c39f198a-1b68-5d39-1c9a-7eaecb8d96d9@redhat.com>
	<EE0BCD97-9983-4753-B690-FE9BD68A6E3A@nutanix.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <da0c88bf-061d-190f-9cfd-4b5fbeee7424@redhat.com>
Date: Mon, 5 Jun 2017 11:41:33 -0500
MIME-Version: 1.0
In-Reply-To: <EE0BCD97-9983-4753-B690-FE9BD68A6E3A@nutanix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TArPglp8qNr31t94FN1B0nXdLKF69n2BU"
Subject: Re: [Qemu-devel] [PULL 17/33] vhost-user-scsi: Introduce
 vhost-user-scsi host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TArPglp8qNr31t94FN1B0nXdLKF69n2BU
From: Eric Blake <eblake@redhat.com>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Message-ID: <da0c88bf-061d-190f-9cfd-4b5fbeee7424@redhat.com>
Subject: Re: [Qemu-devel] [PULL 17/33] vhost-user-scsi: Introduce
 vhost-user-scsi host device
References: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
 <1496320911-51305-18-git-send-email-pbonzini@redhat.com>
 <c39f198a-1b68-5d39-1c9a-7eaecb8d96d9@redhat.com>
 <EE0BCD97-9983-4753-B690-FE9BD68A6E3A@nutanix.com>
In-Reply-To: <EE0BCD97-9983-4753-B690-FE9BD68A6E3A@nutanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/05/2017 11:38 AM, Felipe Franciosi wrote:

>>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>>> Message-Id: <1488479153-21203-4-git-send-email-felipe@nutanix.com>
>>> ---
>>
>> This pull request still hasn't landed, and now it needs a rebase:
>=20
> Hi Eric,
>=20
> Thanks for the report. Looks simple. Part of the series have been merge=
d. Should I rebase+resend just the two missing patches (as a new series?)=
 or should Paolo do this? I'm not sure what's the workflow here.

Paolo has to re-spin his PULL request, but I'm sure it would help him to
have updated patches from you that work out of the box, instead of
making him figure out the changes that have to be made.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TArPglp8qNr31t94FN1B0nXdLKF69n2BU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZNYm9AAoJEKeha0olJ0Nqz48H/2oCs/djaxNR+M1WWkaKRTha
ZUmBJJQAUAiahv54jO//Jg927UP5tooph5uZxIX7b/KrGzFPCJxQSfknLqDMG/hG
Z6GauEmbnR+eQOJO+bvTrbTCvfrtZ4ygUYxAwJ6/VhBuTnofDYNJEvLPQBc5G4Tb
0Cuymu0rb/SJL9oz6YuFJczvMyoLH/I79aOD+N6kUdTAlaU1ILeF2FxceYXEVFrE
Qe7JMSFbovpAejzS9vWAye8rDT02UQ8v4/fmAw6vCK/QVMP8LSuWzqOCvbdbee9R
SToqAotGwJ6lDcguMh4IXtxgg7uWnOENhw4/ILMlsECM0zmcLPhD3x8C6frAGtE=
=0aq5
-----END PGP SIGNATURE-----

--TArPglp8qNr31t94FN1B0nXdLKF69n2BU--

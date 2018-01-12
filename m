Received: from eggs.gnu.org ([2001:4830:134:3::10]:55183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ea031-0001TR-JZ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ea02y-0006kN-TU
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:11:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ea02y-0006iY-KS
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:11:04 -0500
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-12-peterx@redhat.com>
	<f545e9b6-621b-e2e6-505b-f520625c173d@redhat.com>
	<20180112042809.GG2551@xz-mi>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8bae9175-5339-665c-445d-2eadbb41ad58@redhat.com>
Date: Fri, 12 Jan 2018 08:10:54 -0600
MIME-Version: 1.0
In-Reply-To: <20180112042809.GG2551@xz-mi>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="chGb3NbhkjxGaxkfstVvSR8RzsjHFgqGg"
Subject: Re: [Qemu-devel] [RFC v6 11/27] qmp: introduce QMPCapability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--chGb3NbhkjxGaxkfstVvSR8RzsjHFgqGg
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <8bae9175-5339-665c-445d-2eadbb41ad58@redhat.com>
Subject: Re: [RFC v6 11/27] qmp: introduce QMPCapability
References: <20171219084557.9801-1-peterx@redhat.com>
 <20171219084557.9801-12-peterx@redhat.com>
 <f545e9b6-621b-e2e6-505b-f520625c173d@redhat.com>
 <20180112042809.GG2551@xz-mi>
In-Reply-To: <20180112042809.GG2551@xz-mi>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2018 10:28 PM, Peter Xu wrote:
> On Thu, Jan 11, 2018 at 05:07:11PM -0600, Eric Blake wrote:
>> On 12/19/2017 02:45 AM, Peter Xu wrote:
>>> There was no QMP capabilities defined.  Define the first "oob" as
>>
>> s/was/were/
>=20
> Fixed.
>=20
> Just to confirm: is "There was no QMP capability" also correct?

Yes, that also matches singular vs. plural between the verb and object.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--chGb3NbhkjxGaxkfstVvSR8RzsjHFgqGg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpYwe4ACgkQp6FrSiUn
Q2rLRwf/YbUMGO0hFVdRGx6guvhm69C2ejfcXOvNNjt+Ua3HuYz8jNJjfaO6ssN0
rC3CBBEGPQ3YVfqnSFcaRTrKnKaxMlqbck0KvJcOv03leOEhX0FHUk2IuWmKUE92
4ChwlagotzFX6UrLzRIqDSI1PjFRHNybl9+8wjzT2lCotAvwXY7R0bWtb/XKIeHE
mSMLx0bvUDpGV/a0bKQcfKQJDwkxQUK6QrV4G4trjm0yhGe3ubNOos3olUxOJnN5
uYwwoKKl2r0tZMg5KBx2bDTz3ZO1VzVO+AeMNvpJlIKa6l9w6OTuk1jvaz6qYtR2
xjQnlVE6JHuoSahSWCFhkMvQgzuZcg==
=U1sd
-----END PGP SIGNATURE-----

--chGb3NbhkjxGaxkfstVvSR8RzsjHFgqGg--

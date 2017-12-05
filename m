Received: from eggs.gnu.org ([2001:4830:134:3::10]:32945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eMF3H-0005zh-4U
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:22:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eMF3C-0006ot-30
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:22:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eMF3B-0006ny-Q8
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:22:26 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB5FKSCv119059
	for <qemu-devel@nongnu.org>; Tue, 5 Dec 2017 10:22:21 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2enu28spcr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 10:22:20 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 5 Dec 2017 15:22:18 -0000
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
	<20171201143136.62497-4-pasic@linux.vnet.ibm.com>
	<927acf90-4a00-3fa2-9bf3-e34afc6be199@redhat.com>
	<f892b02d-58b6-bb81-439c-f9177259f013@linux.vnet.ibm.com>
	<71010746-2491-ae85-be6b-bf8b265924db@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 5 Dec 2017 16:21:57 +0100
MIME-Version: 1.0
In-Reply-To: <71010746-2491-ae85-be6b-bf8b265924db@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="rNf8CgIaQ10S63x6Dkul707Ta6pUnMMgi"
Message-Id: <ea4e7a4e-d2ca-257e-6838-f7b4a9122655@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 3/3] s390x: deprecate
 s390-squash-mcss machine prop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rNf8CgIaQ10S63x6Dkul707Ta6pUnMMgi
From: Halil Pasic <pasic@linux.vnet.ibm.com>
To: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Message-ID: <ea4e7a4e-d2ca-257e-6838-f7b4a9122655@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 3/3] s390x: deprecate
 s390-squash-mcss machine prop
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
 <20171201143136.62497-4-pasic@linux.vnet.ibm.com>
 <927acf90-4a00-3fa2-9bf3-e34afc6be199@redhat.com>
 <f892b02d-58b6-bb81-439c-f9177259f013@linux.vnet.ibm.com>
 <71010746-2491-ae85-be6b-bf8b265924db@redhat.com>
In-Reply-To: <71010746-2491-ae85-be6b-bf8b265924db@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 12/05/2017 03:54 PM, Eric Blake wrote:
> On 12/05/2017 06:05 AM, Halil Pasic wrote:
>=20
>> Good catch! Regarding omitting the machine name, I was surprised that
>> it works, but it does. Our documentation is a bit strange on this: we
>> document the machine name as non-optional:
>> "-machine [type=3D]name[,prop=3Dvalue[,...]]"
>> but then use -machine prop=3Dvalue in the deprecation section (that's
>> with no name).
>=20
> QemuOpts at their "finest".  If it sees the first hunk as a value
> without an =3D, then that value is fed to type=3Dname; but you are also=
 free
> to make the first hunk be an explicit name=3Dvalue (whether type=3Dname=
 or
> prop=3Dvalue), at which point it is up to the backend whether type can =
be
> omitted.  So in this case, '-machine prop=3Dvalue' manages to work just=

> fine, and it's a question of how you would convey that information in
> the --help documentation.
>=20

I would have spontaneously said something like=20
-machine [[type=3D]name | prop=3Dvalue][,prop=3Dvalue,[,...]]

It is kind of complicated and it does not precisely reflect what is possi=
ble
(one can specify the machine multiple times, and it does not have to be
a prefix of the list for example) but that ain't necessarily a problem.

I'm not saying we should change this. I just wanted to say: wow, this was=

new to me.

>>
>> Since the documentation doesn't make it clear that the property is
>> existent only for the s390-ccw-virtio family of the machines I think
>> being your suggestion has a lot of charm. @Connie: do you agree to
>> removing the machine name (type)?
>>


--rNf8CgIaQ10S63x6Dkul707Ta6pUnMMgi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQIcBAEBAgAGBQJaJrmlAAoJEA0vhuyXGx0ALFIQALla3/9qF2pNlPXyUOWjcqYb
/PqsxzjDrfZ+2jZkql/hsw1mnpX44j6Q6xrodxuoSkTKmeUfctz5HKu7dhIqHNYs
cdadXWrg2hYAiSoWj0iC/fHBpYaYMLT2zHNReQKX7gwYiceMTyWDNL+RouvhkbuZ
QiQLne9ONtmELeZa5vma0rTcjW5d+FsG1NAvtNFD/oKaUOyF3iVGXbfZCDUN/FKl
SOWPxCt3W9oDxInGTeIibFMAgl+I08u8972zkqKsb8AM4aYgSYzadBO8GKZbFcFF
Yvl3Ip7JKQpMm68bHREYYxCEfT8pEVH/Iia6+VUddvLTBYkP7GBP5cS5BIZBhNCW
4co/lqqzNql3tVhNmhneADVO0c7fFYy6hY1iutnNTcwAmBH73wcL/guPFD1DR+Rh
WWvBdtXuKwulReS+xfIkiGLWkroOHyLYFb1BmD8ucOYUeuINQQJUYhZcucPNoAj+
9oD51ejARrnKJqa2MJ1jKitLvEU3AUj7AZm+3R3NeHsGOe3/q4J/upvoPaljWfO9
ePV7eQb6AhbGs2b293Q1YU5Dkg553ULd/vBKkxRmg+pKTKha4MfwwiMOiWxgQIcF
6c7mMp+cGv7/L4+/jzUcpdxvzeccEw2rCeBHxpXYVoSZZnZRM2vfsv7/Z4SRMKDj
RPchTs58LWfixL3VCMOI
=qecQ
-----END PGP SIGNATURE-----

--rNf8CgIaQ10S63x6Dkul707Ta6pUnMMgi--

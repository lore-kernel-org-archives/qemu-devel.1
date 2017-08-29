Received: from eggs.gnu.org ([2001:4830:134:3::10]:37173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dmbr6-0004uy-Oa
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 04:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dmbr2-000677-QL
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 04:26:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dmbr2-00066b-GN
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 04:26:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B6455D698
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 08:26:35 +0000 (UTC)
References: <bc356364-fde1-bf49-d922-719847f8b152@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bb2a358c-0aea-5e77-fc3e-b936ab6b8736@redhat.com>
Date: Tue, 29 Aug 2017 10:26:28 +0200
MIME-Version: 1.0
In-Reply-To: <bc356364-fde1-bf49-d922-719847f8b152@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="gRsOrxCP8ctgrvLXWvMeiA2KbHnjA1tTB"
Subject: Re: [Qemu-devel] understanding qemu devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gRsOrxCP8ctgrvLXWvMeiA2KbHnjA1tTB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.07.2017 23:44, Eric Blake wrote:
> Based on an IRC conversation today, here's some notes that may help
> newcomers understand what is actually happening with qemu devices.  The=

> initial question was how does a guest mount a qcow2 file (the poster wa=
s
> wondering if it was a loop or FUSE filesystem) - does it mean the guest=

> has to understand qcow2?
>=20
> (Hopefully, someone with more experience with good documentation layout=
s
> and time might be willing to take this and further enhance it into a
> nice part of the qemu.org website.)

I just found some spare minutes to read through your mail. Thanks for
the text, I think this is a good summary for newcomers, indeed!

And yes, I agree, this should appear somewhere on the qemu.org website!
I think the best place is either a page in the Wiki, or a post in the
QEMU blog. I assume you already have a wiki account? If not, let me
know. Or for doing a blog post, you basically have to
 git clone git://git.qemu-project.org/qemu-web.git
and add a new file in the "_posts" directory. Have a look at the other
files there to know how to specify the meta information. Then send a
patch to qemu-devel, with Paolo on CC (and myself if you want to get a
review or test with Jekyll).

 Thomas


--gRsOrxCP8ctgrvLXWvMeiA2KbHnjA1tTB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZpSU5AAoJEC7Z13T+cC21oUwP/2tOnPBzrcfjUtpvQ/unSqAF
ayHdqQwXqPICKly0hYjagviuIi2MK8hvqEsPbAjBv/fAq4irBzjlpCRmEePszENG
0EAfvV+R+G2K+84mdxirI7x90xL82Rdk3fuI2gJCnhhXZQTcDX/XSiPhbj315UsR
oepuNc4UnPCjtP2mqeyA0c9pW6ySSnc4bqfcyDQ/VUbTLvz/7U1nzxIH1RDF+niS
Mvbuf76mqWM6MQu6h7rnu37UBJS1OftChMqYCmVUZZi/PGspAiqNHVhp/hDrILqH
NWAxW6wJrpPmvDexzaTDKpF2plBGvC6NekVruHE6kwnU6KYHyYoIyeicEElMhGST
EttC3Te9EyvrUbrZzFUy2Z8/ZZ04CNW65Ju37CPMePBUGH1/0/x8m7maBtIWL9wx
ptyQryqK6ReJk5VtvqCm9h3Ys/Z6O+QDnYHI+kXgZyeV8IyN4+IuJmSUczw7A3GS
dlhimo+wPa0GI5MLOY80k89FvjxUrr/6tukBVwM0NMlhHjnaNcKup0/E47mlTmJ7
/1CpmqCqTWZ1VZq1RWBlFyeapjfzozkiAsUZxZu0IfU8tNBDPtm5ducmnBuIfoQc
nCKWYI+AnJdqfskleDaEMGMJE1ukiSnn+Tv8eUk6TeRRqic2yhYsATMPSfBFOOxx
WZPH3h6Qf6BXubnECogQ
=+bme
-----END PGP SIGNATURE-----

--gRsOrxCP8ctgrvLXWvMeiA2KbHnjA1tTB--

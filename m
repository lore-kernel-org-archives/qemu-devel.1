Received: from eggs.gnu.org ([2001:4830:134:3::10]:58984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHCxw-0007pZ-Gd
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHCxv-0006gY-Kh
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:03:40 -0500
Received: from mail.avalus.com ([2001:41c8:10:1dd::10]:49036)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cHCxv-0006gN-Dt
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:03:39 -0500
Content-Type: multipart/signed;
	boundary="Apple-Mail=_804FA160-16E5-4FDD-842F-DEF096E719FF";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <bf93346f-a875-8d09-0e20-431c7a379c3b@redhat.com>
Date: Wed, 14 Dec 2016 17:03:38 +0000
Message-Id: <85DCCA45-96E3-4263-89FF-647ABDA3986E@alex.org.uk>
References: <20161214150840.10899-1-alex@alex.org.uk>
	<bf93346f-a875-8d09-0e20-431c7a379c3b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Markus Pargmann <mpa@pengutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>


--Apple-Mail=_804FA160-16E5-4FDD-842F-DEF096E719FF
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


> On 14 Dec 2016, at 16:58, Eric Blake <eblake@redhat.com> wrote:
> 
> s/botht he/both the/

Thanks - fixed

--
Alex Bligh





--Apple-Mail=_804FA160-16E5-4FDD-842F-DEF096E719FF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJYUXtqAAoJEBPm5K7i9iORm68P/jyNPlGWXeC+5Oi5nS9pF+DY
x6hTHUsIuzXh0f4an4hQ6CUETfLgJ/uKFQbgHWpii6Tg+h3qOc3t8k6/Oh3rnQHW
RSqxElZ9F4s9eISrB/weRb7zECiw/0XL9TEs19uHoDGxpGVba+N4nfgGkjOOU51d
ick+s/1BdutWO7gYzZBf8hOhx91rEt+LGM/EvBKddIHXeaBwQbOjXVMKUpiNIrC7
rRTNw8GYsDZyh5s86BAXtTLEV1YuuBOAJDPtSZxXkaWzJ5534rmmRthw5HjF+FAt
5Wv+R+pkT+F6I3a5/YbkN3Rohc7BSBSgq4gijVKHDVuj0j0TN0nwAd3qTKyXfxFN
dq1Q7007v0wl7I6Yifqt4zD6s4wJ9vYNXHoqDG5tevRAba11Sla8QgYCfy48zget
e0myIA9Bg5K87ep9Z/RxrkHVp6n93f9VN/YCx+TvNIUmvFvSQmPdtI8fEkt0Co4j
QRjRyG3GAyL2q9uSgLl0k/ebjwd/7rGs6u4ScIqrlP82n3LppnRhgwSivagYL9r3
o5ZLQ2oWRq40EGbWYur/krKZJyhXblMWWRuFbZS4csH55u/vV+3PBMNejUGFYFaP
2kDWbuaH28mpWqjTExoZNOiW1MkUmFI2FUUDqTjBcjI/fuGq+E0LrBOPYqh2LxrM
tgxmPU3PHwekOKfVf5tK
=AAED
-----END PGP SIGNATURE-----

--Apple-Mail=_804FA160-16E5-4FDD-842F-DEF096E719FF--

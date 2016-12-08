Received: from eggs.gnu.org ([2001:4830:134:3::10]:59200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cF1Ax-0003kU-Bg
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 11:04:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cF1As-0003MZ-GJ
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 11:04:03 -0500
Received: from mail.avalus.com ([89.16.176.221]:58905)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cF1As-0003MR-Ah
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 11:03:58 -0500
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed;
	boundary="Apple-Mail=_34899647-AF9C-49B9-A95F-2423725E87F0";
	protocol="application/pgp-signature"; micalg=pgp-sha512
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <d0ce8e00-5875-d3c9-f040-b9d5daebbb2c@redhat.com>
Date: Thu, 8 Dec 2016 16:03:51 +0000
Message-Id: <1E99821C-61FA-422E-8E9A-32E8E966A05E@alex.org.uk>
References: <1480073296-6931-1-git-send-email-vsementsov@virtuozzo.com>
	<F075D231-9CBE-437C-B9F0-0DE2AB98007B@alex.org.uk>
	<ed5f8fc7-c7c8-c678-668f-17047dbe0b23@redhat.com>
	<4329D951-F1D0-4B0B-99AB-9F1B7D3DA99B@alex.org.uk>
	<C9D4A99C-1E81-4144-976B-289FF959430B@alex.org.uk>
	<20161208094436.7o4rm54ob2xh4eui@grep.be>
	<42260F0E-9D94-44D4-A5FF-EE8F5962ADA0@alex.org.uk>
	<d0ce8e00-5875-d3c9-f040-b9d5daebbb2c@redhat.com>
Subject: Re: [Qemu-devel] [Nbd] [PATCH v3] doc: Add NBD_CMD_BLOCK_STATUS
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Markus Pargmann <mpa@pengutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>


--Apple-Mail=_34899647-AF9C-49B9-A95F-2423725E87F0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


> On 8 Dec 2016, at 15:59, Eric Blake <eblake@redhat.com> wrote:
> 
> We should use similar wording to whatever we already say about what a
> client would see when reading data cleared by NBD_CMD_TRIM.  After all,
> the status of STATE_HOLE set and STATE_ZERO clear is what you logically
> get when TRIM cannot guarantee reads-as-zero.

Yes. It was actually exactly that discussion I was trying to remember.

--
Alex Bligh





--Apple-Mail=_34899647-AF9C-49B9-A95F-2423725E87F0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJYSYRoAAoJEBPm5K7i9iORDOgP/2oixmcMYHxioY0ckQbgjjvI
yjjyWrZ+Q3JD0HQP2Oiu9mNXvz/xpDXy20vil8nTQMpWNtIfSZv9lr+fCrRj9ONV
6+iH+PwkpTdyQZbgYsGnJZ+PhWXMCDs9kI+p2yp0xo1BTWH3BTCB+SthOHA4aA6G
7GzvkrY5kWlUGR34Qji7gB7yaYU2z299kMX+bhtaiBw+sHoDTRXaMItC056eRRe/
K9AzmJbz5qjbHMKn8Q7i8Js8HD+QT5Yc2Ygw51rpDbemi5hSiTHi0fkq58AkVTa5
uPvrYFmHXygS9OUnD931x+dJAkUu6iY46XUiePpQ3n/8MfbKZo4KdCWn3afm5+t7
9UvmLIFt/C/GH431VBu5/lQc1Vpg1g6ev3lu002JH8hvyIRP428e2jP2nkLyao7U
0BjUzmMX6Dis48Wf/bauqykOP7yjfECs7LrDbwRASXdJQXH+WUhYg3e7Cnaq+h7+
YExV8Qq+/CSC6gz2JmFOjJM90E+i15YcjCnXlCKXXKs3pW59PqjQQGHHwncERI7O
WLiIBkfLnz1eHErIQSGi9oMbtiJJma2cbT1bKHRucJ6JJ7memEXjxNEcJoKJ4XLZ
zwTmSvJ2oBGY8NV2sU5dcBG3lhNPjbk/2c/E4lZtEqXdgxUHZs3e5ZWNWvv2dLt9
Nj9CJ/6uJAy9wcoZCBwh
=hs7K
-----END PGP SIGNATURE-----

--Apple-Mail=_34899647-AF9C-49B9-A95F-2423725E87F0--

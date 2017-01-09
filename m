Received: from eggs.gnu.org ([2001:4830:134:3::10]:42165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ossman@cendio.se>) id 1cQcaZ-0007jf-J5
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:14:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ossman@cendio.se>) id 1cQcaY-0007RM-Kn
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:14:27 -0500
Received: from hayek.cendio.se ([193.12.253.119]:60092 helo=mail.cendio.se)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ossman@cendio.se>) id 1cQcaY-0007Pf-DM
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:14:26 -0500
References: <3fcc534530370027118377dc24d4049a1cef590e.1481807806.git.ossman@cendio.se>
	<1481820076.21413.23.camel@redhat.com>
	<9ef03a73-2139-e586-7c2d-c234863bdcac@cendio.se>
	<1483520239.5670.47.camel@redhat.com>
From: Pierre Ossman <ossman@cendio.se>
Message-ID: <c9340775-8d3c-f617-7f55-96fa24b25e1a@cendio.se>
Date: Mon, 9 Jan 2017 17:14:25 +0100
MIME-Version: 1.0
In-Reply-To: <1483520239.5670.47.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vnc: track LED state separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On 04/01/17 09:57, Gerd Hoffmann wrote:
>
> /me wonders how you've tested the patch ...
>

That would be not at all. Or rather, just a compile. :)

>
> Tried, but checkpatch found some more issues:
>

Fixed. New patch incoming.

Regards
--=20
Pierre Ossman           Software Development
Cendio AB               https://cendio.com
Teknikringen 8          https://twitter.com/ThinLinc
583 30 Link=C3=B6ping        https://facebook.com/ThinLinc
Phone: +46-13-214600    https://plus.google.com/+CendioThinLinc

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

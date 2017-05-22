Received: from eggs.gnu.org ([2001:4830:134:3::10]:35578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dCgp5-00062j-GF
	for qemu-devel@nongnu.org; Mon, 22 May 2017 02:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dCgp2-0005i8-Dl
	for qemu-devel@nongnu.org; Mon, 22 May 2017 02:28:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dCgp2-0005gu-7z
	for qemu-devel@nongnu.org; Mon, 22 May 2017 02:28:04 -0400
Message-ID: <1495434480.28581.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 22 May 2017 08:28:00 +0200
In-Reply-To: <65de474b-ab36-727a-4d3a-dadb8ad22f9b@riseup.net>
References: <65de474b-ab36-727a-4d3a-dadb8ad22f9b@riseup.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] xhci: bump the link TRB cycle detection
 limit.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: anonym <anonym@riseup.net>
Cc: qemu-devel@nongnu.org

On Fr, 2017-05-19 at 19:42 +0000, anonym wrote:
> Gentle ping! :)
>=20
> I've lost the Message-IDs of my previous posts on this topic but its abou=
t this patch submission:
>=20
> * https://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg03433.html
> * https://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg03434.html
>=20

That one slipped though.  Same thing was noticed by someone else
meanwhile though and it is fixed in master (commit
99f9aeba5d461f79c9ce73f968ba0feb77fc1f5a).

cheers,
  Gerd

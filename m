Received: from eggs.gnu.org ([2001:4830:134:3::10]:54913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cEzRk-0005k5-Dl
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 09:13:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cEzRh-0004ve-6c
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 09:13:16 -0500
Received: from mail.avalus.com ([89.16.176.221]:53467)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cEzRh-0004vV-0s
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 09:13:13 -0500
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <ee7fc746-eb1d-3f89-df3c-308a2dd4a026@virtuozzo.com>
Date: Thu, 8 Dec 2016 14:13:06 +0000
Content-Transfer-Encoding: quoted-printable
Message-Id: <9547F239-73C4-4018-8C0B-3D0294BBF611@alex.org.uk>
References: <1480073296-6931-1-git-send-email-vsementsov@virtuozzo.com>
	<F075D231-9CBE-437C-B9F0-0DE2AB98007B@alex.org.uk>
	<ed5f8fc7-c7c8-c678-668f-17047dbe0b23@redhat.com>
	<4329D951-F1D0-4B0B-99AB-9F1B7D3DA99B@alex.org.uk>
	<C9D4A99C-1E81-4144-976B-289FF959430B@alex.org.uk>
	<ee7fc746-eb1d-3f89-df3c-308a2dd4a026@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v3] doc: Add NBD_CMD_BLOCK_STATUS extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Alex Bligh <alex@alex.org.uk>, John Snow <jsnow@redhat.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Pargmann <mpa@pengutronix.de>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Wouter Verhelst <w@uter.be>, Paolo Bonzini <pbonzini@redhat.com>


> On 8 Dec 2016, at 06:58, Vladimir Sementsov-Ogievskiy =
<vsementsov@virtuozzo.com> wrote:
>=20
> An idea: let's not use uppercase. Why to shout the namespace? 'base' =
and 'x-' would be better I think. BASE and X- will provoke all =
user-defined namespaces be in uppercase too and a lot of uppercase will =
come to the code =3D(

I agree

--=20
Alex Bligh

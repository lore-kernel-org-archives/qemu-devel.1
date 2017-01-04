Received: from eggs.gnu.org ([2001:4830:134:3::10]:54032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOhrC-0005j4-Uk
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 04:27:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOhr8-0007Gj-2y
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 04:27:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cOhr7-0007GA-SX
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 04:27:37 -0500
Message-ID: <1483519820.5670.45.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 04 Jan 2017 09:50:20 +0100
In-Reply-To: <87mvfhw3i0.fsf_-_@mail.parknet.co.jp>
References: <87inqavlzj.fsf@mail.parknet.co.jp>
	<feca54b3-9c38-4ce7-4edc-b1f9f88fb7a1@reactos.org>
	<87fuletg61.fsf@mail.parknet.co.jp>
	<f8044f23-52ef-89f8-5ca7-b27de2989cc7@reactos.org>
	<8737h9xidn.fsf@mail.parknet.co.jp>
	<87mvfhw3i0.fsf_-_@mail.parknet.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3] ps2: Fix lost scancodes by recent
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: =?ISO-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

On Mi, 2016-12-28 at 04:55 +0900, OGAWA Hirofumi wrote:
> With "ps2: use QEMU qcodes instead of scancodes", key handling was
> changed to qcode base. But all scancodes are not converted to new one.
>=20
> This adds some missing qcodes/scancodes what I found in using.

Added to ui queue.

thanks,
  Gerd

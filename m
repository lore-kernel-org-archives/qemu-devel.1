Received: from eggs.gnu.org ([2001:4830:134:3::10]:44880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQupc-0000TE-BY
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 06:43:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQupZ-0002h1-9q
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 06:43:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cQupZ-0002gx-4A
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 06:43:09 -0500
Message-ID: <1484048583.19018.86.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Jan 2017 12:43:03 +0100
In-Reply-To: <87o9zmk177.fsf_-_@mail.parknet.co.jp>
References: <87bmw2vgvy.fsf@mail.parknet.co.jp>
	<1483519725.5670.44.camel@redhat.com>
	<87vatuk19y.fsf@mail.parknet.co.jp>
	<87o9zmk177.fsf_-_@mail.parknet.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] ui/gtk: Fix mouse wheel on 3.4.0 or
 later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: qemu-devel@nongnu.org

On Do, 2017-01-05 at 05:41 +0900, OGAWA Hirofumi wrote:
> On 3.4.0 or later, send GDK_SCROLL_SMOOTH event, instead of
> GDK_SCROLL_UP/DOWN.
>=20
> This fixes it by converting any smooth scroll to up/down.
> (I.e. without smooth support)
>=20
> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Added to ui queue.

thanks,
  Gerd

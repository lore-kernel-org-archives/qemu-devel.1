Received: from eggs.gnu.org ([2001:4830:134:3::10]:58867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fs5YV-0007vQ-Tt
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fs5YV-0005qP-A8
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:14:39 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fs5YV-0005p1-3A
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:14:39 -0400
Received: by mail-wr1-x444.google.com with SMTP id g1-v6so15673712wru.2
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 05:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180821111313.27792-1-kraxel@redhat.com>
In-Reply-To: <20180821111313.27792-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Aug 2018 14:14:26 +0200
Message-ID: <CAJ+F1CJ__EGBzUHbBd8iq73mAdbvnrgxV4NAezoUs2ThkZ6g-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] virtio-vga: fix reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, Aug 21, 2018 at 1:13 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>
>
> Gerd Hoffmann (2):
>   virtio-vga: fix reset
>   Revert "virtio-gpu: fix crashes upon warm reboot with vga mode"

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>
>  include/hw/virtio/virtio-gpu.h |  2 +-
>  hw/display/virtio-gpu.c        |  7 +------
>  hw/display/virtio-vga.c        | 17 +++++------------
>  3 files changed, 7 insertions(+), 19 deletions(-)
>
> --
> 2.9.3
>


--=20
Marc-Andr=C3=A9 Lureau

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fa28n-0006Ti-BL
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fa28m-0003Aa-NB
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:57:29 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:40914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fa28m-00039h-5N
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:57:28 -0400
Received: by mail-wm0-x243.google.com with SMTP id z13-v6so9437449wma.5
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 09:57:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180702162443.16796-1-kraxel@redhat.com>
References: <20180702162443.16796-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 2 Jul 2018 18:57:26 +0200
Message-ID: <CAJ+F1CLhxeSHCmV8GKW+Jy=9FEgsz=KyBvEYDffG_GSc8FEW_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] virtio-gpu: scanout tracking fixes.
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

On Mon, Jul 2, 2018 at 6:24 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>
> Gerd Hoffmann (3):
>   virtio-gpu: tweak scanout disable.
>   virtio-gpu: update old resource too.
>   virtio-gpu: disable scanout when backing resource is destroyed
>

Series:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>  hw/display/virtio-gpu.c | 64 ++++++++++++++++++++++++++++++++++---------=
------
>  1 file changed, 45 insertions(+), 19 deletions(-)
>
> --
> 2.9.3
>
>



--=20
Marc-Andr=C3=A9 Lureau

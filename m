Received: from eggs.gnu.org ([209.51.188.92]:34247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hMblN-0007D1-Rh
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:14:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hMblM-0001RQ-UJ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:14:21 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:37685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liboxuan@connect.hku.hk>)
	id 1hMblM-0001QL-Io
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:14:20 -0400
Received: by mail-yw1-xc44.google.com with SMTP id l8so1956801ywm.4
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 10:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190503154424.73933-1-liboxuan@connect.hku.hk>
	<87bm0j4im0.fsf@zen.linaroharston>
	<CALM0=-=b+z2aW-cuM=hmk3_oKG7w3ianMo_ZA7gj8zMgCOfC3g@mail.gmail.com>
	<878svn4gnq.fsf@zen.linaroharston>
In-Reply-To: <878svn4gnq.fsf@zen.linaroharston>
From: "LI, BO XUAN" <liboxuan@connect.hku.hk>
Date: Sat, 4 May 2019 01:13:43 +0800
Message-ID: <CALM0=-m0Vd1YMn6s36oRbsqFCwjPwdga5Q0XRoO41dq6iw1Lzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] hw/virtio/virtio-mmio: Convert DPRINTF
 to trace and log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Yuval Shaia <yuval.shaia@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>

Gotcha, thanks for the tip!

Best regards,
Boxuan Li

On Sat, May 4, 2019 at 1:00 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:

>
> LI, BO XUAN <liboxuan@connect.hku.hk> writes:
>
> > Hi Alex,
> >
> > Sorry about that, I am still trying to get familiar with the patch
> > submission process. Since my patch has been changed from your last
> review,
> > I thought it would be safe to not include the r-b tag from last time.
> Will
> > take care next time!
>
> That's ok. As a general rule as long as you haven't substantially
> changed a patch it's safe to keep previous r-b tags. You can always
> mention it in your cover letter if you are unsure.
>
> --
> Alex Benn=C3=A9e
>

Received: from eggs.gnu.org ([209.51.188.92]:59130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMbXx-0005oR-1Z
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMbXw-0002F8-0A
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:00:28 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMbXv-0002DC-Np
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:00:27 -0400
Received: by mail-wr1-x443.google.com with SMTP id d22so1605854wrb.4
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 10:00:27 -0700 (PDT)
References: <20190503154424.73933-1-liboxuan@connect.hku.hk>
	<87bm0j4im0.fsf@zen.linaroharston>
	<CALM0=-=b+z2aW-cuM=hmk3_oKG7w3ianMo_ZA7gj8zMgCOfC3g@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CALM0=-=b+z2aW-cuM=hmk3_oKG7w3ianMo_ZA7gj8zMgCOfC3g@mail.gmail.com>
Date: Fri, 03 May 2019 18:00:25 +0100
Message-ID: <878svn4gnq.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: "LI, BO XUAN" <liboxuan@connect.hku.hk>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Eric Blake <eblake@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Yuval Shaia <yuval.shaia@oracle.com>, "Michael S.
	Tsirkin" <mst@redhat.com>


LI, BO XUAN <liboxuan@connect.hku.hk> writes:

> Hi Alex,
>
> Sorry about that, I am still trying to get familiar with the patch
> submission process. Since my patch has been changed from your last review,
> I thought it would be safe to not include the r-b tag from last time. Will
> take care next time!

That's ok. As a general rule as long as you haven't substantially
changed a patch it's safe to keep previous r-b tags. You can always
mention it in your cover letter if you are unsure.

--
Alex Benn=C3=A9e

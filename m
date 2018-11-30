Received: from eggs.gnu.org ([2001:4830:134:3::10]:56986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSm5q-0002dD-OA
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:56:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSm5p-0003RI-W9
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:56:42 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:42804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSm5p-0003R4-Qj
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:56:41 -0500
Received: by mail-ot1-x32b.google.com with SMTP id v23so5673148otk.9
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 08:56:41 -0800 (PST)
MIME-Version: 1.0
References: <20181130093852.20739-1-maozhongyi@cmss.chinamobile.com>
	<20181130093852.20739-22-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181130093852.20739-22-maozhongyi@cmss.chinamobile.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 16:56:30 +0000
Message-ID: <CAFEAcA9d6fazrUCE4woOt1Zty3AE81eYt2ATdFY-O6LQNQ+-TA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 21/21] core/sysbus: remove the
 SysBusDeviceClass::init path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <alistair.francis@wdc.com>, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

On Fri, 30 Nov 2018 at 09:39, Mao Zhongyi
<maozhongyi@cmss.chinamobile.com> wrote:
>
> Currently, all sysbus devices have been converted to realize(),
> so remove this path.
>
> Cc: ehabkost@redhat.com
> Cc: thuth@redhat.com
> Cc: pbonzini@redhat.com
> Cc: armbru@redhat.com
> Cc: peter.maydell@linaro.org
> Cc: richard.henderson@linaro.org
> Cc: alistair.francis@wdc.com
>
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

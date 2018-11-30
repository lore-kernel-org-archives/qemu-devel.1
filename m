Received: from eggs.gnu.org ([2001:4830:134:3::10]:32943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSktY-0004Wt-28
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:39:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSktX-00056b-3D
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:39:55 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSktW-00056I-SL
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:39:55 -0500
Received: by mail-oi1-x241.google.com with SMTP id y23so5067298oia.4
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 07:39:54 -0800 (PST)
MIME-Version: 1.0
References: <1543407172-16175-1-git-send-email-peng.hao2@zte.com.cn>
	<1543407172-16175-3-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1543407172-16175-3-git-send-email-peng.hao2@zte.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 15:39:42 +0000
Message-ID: <CAFEAcA8zYJQd=f3Q3BSPRHkxe6RgWDACwdRx1+hDiGJ1-cjuNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V10 2/9] hw/misc/pvpanic: Cosmetic renaming
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: Andrew Jones <drjones@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Wed, 28 Nov 2018 at 03:49, Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> To ease the MMIO device addition in the next patch, rename:
> - ISA_PVPANIC_DEVICE -> PVPANIC_ISA_DEVICE.
> - MemoryRegion io -> mr.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

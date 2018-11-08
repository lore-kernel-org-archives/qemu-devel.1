Received: from eggs.gnu.org ([2001:4830:134:3::10]:56537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKgmT-0000Xm-Gq
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:39:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKgmS-0006Lm-LP
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:39:17 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKgmS-0006IW-Be
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:39:16 -0500
Received: by mail-oi1-x242.google.com with SMTP id v198-v6so16414925oif.2
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 01:39:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <467e77d8-48af-5361-3e31-b9eac79d968d@redhat.com>
References: <1540495397-88089-1-git-send-email-peng.hao2@zte.com.cn>
	<1540495397-88089-4-git-send-email-peng.hao2@zte.com.cn>
	<467e77d8-48af-5361-3e31-b9eac79d968d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Nov 2018 09:38:54 +0000
Message-ID: <CAFEAcA-tkcsCFXQZmZyqLDXQKvXX9Am0dgNviVw=Ccq6tX+w_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V4 3/5] hw/misc/pvpanic: Add the MMIO
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Peng Hao <peng.hao2@zte.com.cn>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 25 October 2018 at 12:38, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> Depending of the response to Peter's question [*]:
>
>     I'd also like some confirmation from folks more familiar with the
>     current state of the art in guest-to-management-layer communication
>     that pvpanic is still the recommended way to achieve this goal,
>     and hasn't been obsoleted by something else.

Paolo? Stefan?

thanks
-- PMM

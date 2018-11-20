Received: from eggs.gnu.org ([2001:4830:134:3::10]:37675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP6vZ-0002oe-FL
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP6vY-0001G4-Lv
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:22:57 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP6vY-0001Fm-HJ
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:22:56 -0500
Received: by mail-ot1-x342.google.com with SMTP id k98so1794889otk.3
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 06:22:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1542365406-81310-2-git-send-email-peng.hao2@zte.com.cn>
References: <1542365406-81310-1-git-send-email-peng.hao2@zte.com.cn>
	<1542365406-81310-2-git-send-email-peng.hao2@zte.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 14:22:35 +0000
Message-ID: <CAFEAcA_6ZpUaGPpzHy=gcH31_PRuQ-avWRs_4dRrFOj1mP4BUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V7 1/6] hw/misc/pvpanic: Build the pvpanic
 device in $(common-obj)
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

On 16 November 2018 at 10:50, Peng Hao <peng.hao2@zte.com.cn> wrote:
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> The 'pvpanic' ISA device can be use by any machine with an ISA bus.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Hi, Peng -- this should have your Signed-off-by: line
below Philippe's. This shows that the patch passed through
you rather than coming directly from Philippe.

Other than that,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

Received: from eggs.gnu.org ([209.51.188.92]:54001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1uTa-0004VD-PP
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:58:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1uTa-000084-5v
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:58:26 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1uTZ-00007B-VV
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:58:26 -0500
Received: by mail-oi1-x244.google.com with SMTP id t82so13100176oie.12
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 06:58:25 -0800 (PST)
MIME-Version: 1.0
References: <1550029560-30530-1-git-send-email-sandra@codesourcery.com>
	<1550029560-30530-3-git-send-email-sandra@codesourcery.com>
In-Reply-To: <1550029560-30530-3-git-send-email-sandra@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2019 14:58:12 +0000
Message-ID: <CAFEAcA-Ocow8GzPCPO=346hnc4CZ6M02TwVp-e6G2EjY5-FESQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 2/2] Add Nios II semihosting support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sandra Loosemore <sandra@codesourcery.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marek Vasut <marex@denx.de>

On Wed, 13 Feb 2019 at 04:02, Sandra Loosemore <sandra@codesourcery.com> wrote:
>
> This patch adds support for libgloss semihosting to Nios II bare-metal
> emulation.
>
> Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
> Signed-off-by: Julian Brown <julian@codesourcery.com>

Do you have a link to the spec that defines this semihosting
ABI, please ?

thanks
-- PMM

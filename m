Received: from eggs.gnu.org ([2001:4830:134:3::10]:47300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYZfA-00045C-EJ
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYZf9-0006ou-Jw
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:20:52 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:43736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYZf9-0006nm-Dh
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:20:51 -0400
Received: by mail-oi0-x242.google.com with SMTP id 8-v6so1119234oin.10
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 09:20:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529699547-17044-5-git-send-email-alindsay@codeaurora.org>
References: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
	<1529699547-17044-5-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 17:20:29 +0100
Message-ID: <CAFEAcA9WbdJSY57hqzRiZVTiYR8_oCYD5WUp_ueVjhhbrw4cKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 04/13] target/arm: Add ARM_FEATURE_V7VE
 for v7 Virtualization Extensions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aclindsa@gmail.com>

On 22 June 2018 at 21:32, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/cpu.c   | 21 ++++++++++++++-------
>  target/arm/cpu.h   |  1 +
>  target/arm/kvm32.c |  8 ++++----
>  3 files changed, 19 insertions(+), 11 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

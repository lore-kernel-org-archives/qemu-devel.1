Received: from eggs.gnu.org ([2001:4830:134:3::10]:57172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fM9Qj-0007XO-Dw
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fM9Qi-000120-H3
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:54:37 -0400
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:44830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fM9Qi-00011i-CL
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:54:36 -0400
Received: by mail-ot0-x22f.google.com with SMTP id g7-v6so5403120otj.11
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 02:54:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180525081754.29506-1-laurent@vivier.eu>
References: <20180525081754.29506-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 May 2018 10:54:14 +0100
Message-ID: <CAFEAcA-a=S0xkRFjhqaH40hVhu4Ut8txZUdRo82mh_CgDvvkdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/13] Linux user for 2.13 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 25 May 2018 at 09:17, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 62b9b076d9d37117696ec64f0b3544c1205ff7f9:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20180524-pull-request' into staging (2018-05-24 17:48:01 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-2.13-pull-request
>
> for you to fetch changes up to 4f71086665360eb15cb0cc3392bd5063f26ee934:
>
>   gdbstub: Clarify what gdb_handlesig() is doing (2018-05-25 10:10:55 +0200)
>
> ----------------------------------------------------------------
> This pull request includes:
> - fixes for some comments
> - netlink update and fix
> - rework/cleanup fo socket.h,
>   including fixes for SPARC part.
>

Applied, thanks.

-- PMM

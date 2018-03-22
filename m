Received: from eggs.gnu.org ([2001:4830:134:3::10]:50757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyz6Q-0000dX-Pn
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 08:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyz6P-0005Iy-WA
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 08:13:54 -0400
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:38170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyz6P-0005IU-RA
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 08:13:53 -0400
Received: by mail-oi0-x229.google.com with SMTP id c3-v6so7111848oib.5
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 05:13:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180320204351.28167-1-laurent@vivier.eu>
References: <20180320204351.28167-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Mar 2018 12:13:32 +0000
Message-ID: <CAFEAcA-y5o+MgZZRUyGOO-AvkdwEZDdhMEE3DwsHWOajzDoX8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Linux user for 2.12 patches
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

On 20 March 2018 at 20:43, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 036793aebfc1dd0ce124fa278d7668d89b5da936:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-03-20 12:56:20 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-2.12-pull-request
>
> for you to fetch changes up to 2a53535af471f4bee9d6cb5b363746b8d5ed21dd:
>
>   linux-user: init_guest_space: Try to make ARM space+commpage continuous (2018-03-20 18:26:40 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Luke Shumaker (1):
>   linux-user: init_guest_space: Try to make ARM space+commpage
>     continuous
>
>  linux-user/elfload.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>

Applied, thanks.

-- PMM

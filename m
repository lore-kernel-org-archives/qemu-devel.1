Received: from eggs.gnu.org ([2001:4830:134:3::10]:37271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cT7EF-0004gw-97
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:21:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cT7EE-0006fu-An
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:21:43 -0500
Received: from mail-ua0-x233.google.com ([2607:f8b0:400c:c08::233]:33783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cT7EE-0006fo-7B
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:21:42 -0500
Received: by mail-ua0-x233.google.com with SMTP id i68so80993529uad.0
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 05:21:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484244501-20283-1-git-send-email-laurent@vivier.eu>
References: <1484244501-20283-1-git-send-email-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jan 2017 13:21:21 +0000
Message-ID: <CAFEAcA-kgb-YnMD3kCUUkyODAXuJHdoL0paTeUtxy+dCO4jCig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/4] M68k for 2.9 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 12 January 2017 at 18:08, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 4201e616c0fa48de99a505a6ade979f0c2c65e28:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/pull-audio-20170111-1' into staging (2017-01-12 15:57:18 +0000)
>
> are available in the git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.9-pull-request
>
> for you to fetch changes up to ad9075ac2cc6cfe4003f5e47d421c0e5b2ad08a3:
>
>   m68k: Remove PCI and USB from config file (2017-01-12 18:49:09 +0100)
>
> ----------------------------------------------------------------
> This is the list of the remaining patches that was part of series
> reviewed during the freeze period. They use the new new deposit
> and extract ops.
> There is also a cleanup patch from Thomas.
> ----------------------------------------------------------------

Applied, thanks.

-- PMM

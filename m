Received: from eggs.gnu.org ([2001:4830:134:3::10]:47478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUGlz-0001F4-7K
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:45:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUGly-0001R9-GE
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:45:19 -0500
Received: from mail-ua0-x22d.google.com ([2607:f8b0:400c:c08::22d]:35457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUGly-0001QI-CC
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:45:18 -0500
Received: by mail-ua0-x22d.google.com with SMTP id y9so41586489uae.2
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 09:45:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170117230332.16279-1-rth@twiddle.net>
References: <20170117230332.16279-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 17:44:55 +0000
Message-ID: <CAFEAcA-Kn2g0Aj4rvhCYL9FD4zB=k9cnWXpAbe8TmoY=J1B-Sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/2] Fixes for x86 host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 17 January 2017 at 23:03, Richard Henderson <rth@twiddle.net> wrote:
> Fixing a regression reported by Eduardo.
>
>
> r~
>
>
> The following changes since commit 23eb9e6b6d5315171cc15969bbc755f258004df0:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-01-16' into staging (2017-01-17 13:53:50 +0000)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20170117
>
> for you to fetch changes up to 39f099ec9d6d420b6fe6f7f4f8ed80ae29c65ff2:
>
>   tcg/i386: Always use TZCNT when available (2017-01-17 12:02:08 -0800)
>
> ----------------------------------------------------------------
> tcg/i386 fixes
>

Applied, thanks.

-- PMM

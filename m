Received: from eggs.gnu.org ([2001:4830:134:3::10]:54575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cii1f-0005Mz-7P
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cii1e-0002RJ-50
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:41:11 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cii1d-0002R0-V3
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:41:10 -0500
Received: by mail-wr0-x22a.google.com with SMTP id l37so9060241wrc.1
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 05:41:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170228004651.20674-1-rth@twiddle.net>
References: <20170228004651.20674-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 13:40:48 +0000
Message-ID: <CAFEAcA8-LwcREBz0e1NFsUY7exLxeX3e0EufRPjLxto_6CWUcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL] Enable MTTCG for target/alpha
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

On 28 February 2017 at 00:46, Richard Henderson <rth@twiddle.net> wrote:
> Thanks to Alex for the heroics getting the patch set in.
> This is a tiny follow-up to enable it for Alpha.
>
>
> r~
>
>
> The following changes since commit 8f2d7c341184a95d05476ea3c45dbae2b9ddbe51:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/pull-qcrypto-2017-02-27-1' into staging (2017-02-27 15:33:21 +0000)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-axp-20170228
>
> for you to fetch changes up to 5ee4f3c2c750ce55f825116610beb3340daedeca:
>
>   target/alpha: Enable MTTCG by default (2017-02-28 11:41:46 +1100)
>
> ----------------------------------------------------------------
> Enable MTTCG for Alpha guest
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM

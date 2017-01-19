Received: from eggs.gnu.org ([2001:4830:134:3::10]:43367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUIGx-00044P-Kv
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:21:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUIGw-0007e0-Mt
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:21:23 -0500
Received: from mail-vk0-x22e.google.com ([2607:f8b0:400c:c05::22e]:34439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUIGw-0007dJ-In
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:21:22 -0500
Received: by mail-vk0-x22e.google.com with SMTP id r136so37344362vke.1
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 11:21:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
References: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 19:21:01 +0000
Message-ID: <CAFEAcA8kGGfUBjNre4RDOfdf0zoAjVtbMvxxUk3MjqA9qxc3yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/30] target-sparc sun4v support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <rth@twiddle.net>

On 18 January 2017 at 22:38, Artyom Tarasenko <atar4qemu@gmail.com> wrote:
> This series adds sun4v support. Its v2 was previously submitted via Richard's tree, but produced
> a clang warning due to a missing #ifdef.
>
> v2 -> v3:
> added an #ifdef to avoid unused function warning in user mode
>
> The following changes since commit 23eb9e6b6d5315171cc15969bbc755f258004df0:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-01-16' into staging (2017-01-17 13:53:50 +0000)
>
> are available in the git repository at:
>
>   https://github.com/artyom-tarasenko/qemu/ tags/pull-sun4v-20170118
>
> for you to fetch changes up to a2664ca0eced57dfc9f261fa1b210f24ddac649d:
>
>   target-sparc: fix up niagara machine (2017-01-18 22:03:44 +0100)
>

Applied, thanks.

-- PMM

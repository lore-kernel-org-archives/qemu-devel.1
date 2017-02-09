Received: from eggs.gnu.org ([2001:4830:134:3::10]:48213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbk56-0008RM-NQ
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 03:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbk56-0008Ve-0e
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 03:27:56 -0500
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cbk55-0008U6-Pm
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 03:27:55 -0500
Received: by mail-wr0-x22c.google.com with SMTP id o16so78182016wra.1
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 00:27:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486496748-15674-1-git-send-email-peter.maydell@linaro.org>
References: <1486496748-15674-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Feb 2017 08:27:33 +0000
Message-ID: <CAFEAcA8v4dvWeJqkTN1MxOfA+B_dwACq20N=-=J+R-SvgZ7SAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 00/13] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 7 February 2017 at 19:45, Peter Maydell <peter.maydell@linaro.org> wrote:
> A random mix of items here, nothing very major. v2 is just
> squashing in the fix for the clang unused-function error.
>
> thanks
> -- PMM
>
>
> The following changes since commit d0dff238a87fa81393ed72754d4dc8b09e50b08b:
>
>   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20170206' into staging (2017-02-07 15:29:26 +0000)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170207-1
>
> for you to fetch changes up to aecfbbc97a2e52bbee34a53c32f961a182046a95:
>
>   stellaris: Use the 'unimplemented' device for parts we don't implement (2017-02-07 18:55:15 +0000)
>

Applied, thanks.

-- PMM

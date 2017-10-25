Received: from eggs.gnu.org ([2001:4830:134:3::10]:43717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7Mb3-0006o4-TJ
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 10:23:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7Mb3-0007lb-3R
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 10:23:53 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:56471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e7Mb2-0007kl-T1
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 10:23:53 -0400
Received: by mail-wm0-x22a.google.com with SMTP id z3so2301481wme.5
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 07:23:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171023091947.20771-1-kraxel@redhat.com>
References: <20171023091947.20771-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Oct 2017 15:23:30 +0100
Message-ID: <CAFEAcA_-Rt2mi1w=bVzhy_ZrH_p4UKo61Jte0FFaa=z8S9JJYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] Input 20171023 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 October 2017 at 10:19, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit e822e81e350825dd94f41ee2538ff1432b812eb9:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-10-20 15:04:00 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/input-20171023-pull-request
>
> for you to fetch changes up to 2182608f1ca00f4559486e9173a8e4242dd2d65d:
>
>   ui: pull in latest keycodemapdb (2017-10-23 10:50:02 +0200)
>
> ----------------------------------------------------------------
> input: fixes for ui input code and ps/2 keyboard (mostly sysrq key)
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM

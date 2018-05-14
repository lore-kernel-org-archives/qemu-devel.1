Received: from eggs.gnu.org ([2001:4830:134:3::10]:60736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIGiV-00063l-3e
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIGiU-0003nk-85
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:52:55 -0400
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:36911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIGiU-0003nD-2G
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:52:54 -0400
Received: by mail-ot0-x22f.google.com with SMTP id 77-v6so15070032otd.4
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 09:52:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1526284560-20266-1-git-send-email-jasowang@redhat.com>
References: <1526284560-20266-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 17:52:32 +0100
Message-ID: <CAFEAcA-h6wihH-O72i4J-2uRQbGW7msRwEEqC3ywV9sJKL=SKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 14 May 2018 at 08:55, Jason Wang <jasowang@redhat.com> wrote:
> The following changes since commit c74e62ee3e2dc2955e07d004c71badecb68a84eb:
>
>   Merge remote-tracking branch 'remotes/rth/tags/cota-target-pull-request' into staging (2018-05-11 15:41:29 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 0e0266c2e475b82b39a757c875fa03e64272fbe7:
>
>   net: Get rid of 'vlan' terminology and use 'hub' instead in the doc files (2018-05-14 15:47:14 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
> Thomas Huth (4):
>       net: Fix memory leak in net_param_nic()
>       net: Remove the deprecated "vlan" parameter
>       net: Get rid of 'vlan' terminology and use 'hub' instead in the source files
>       net: Get rid of 'vlan' terminology and use 'hub' instead in the doc files
>

Applied, thanks.

-- PMM

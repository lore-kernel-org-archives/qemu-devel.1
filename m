Received: from eggs.gnu.org ([2001:4830:134:3::10]:43894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esvGt-0000WL-JX
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:55:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esvGs-0004pZ-OF
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:55:39 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:42897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1esvGs-0004pO-IT
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:55:38 -0500
Received: by mail-oi0-x243.google.com with SMTP id c18so12848935oiy.9
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 10:55:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180305094006.21446-1-stefanha@redhat.com>
References: <20180305094006.21446-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Mar 2018 18:55:17 +0000
Message-ID: <CAFEAcA_D95VQ7br5Bf9N1M9Pq5ykwHzkVYjzr7DszqSXr_1DkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On 5 March 2018 at 09:40, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 136c67e07869227b21b3f627316e03679ce7b738:
>
>   Merge remote-tracking branch 'remotes/bkoppelmann/tags/pull-tricore-2018-03-02' into staging (2018-03-02 16:56:20 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 23500c6a9409efc80d696aede0629bfbe7556a90:
>
>   README: Document 'git-publish' workflow (2018-03-05 09:03:17 +0000)
>
> ----------------------------------------------------------------
> Pull request
>
> Mostly patches that are only indirectly related to the block layer, but I've
> reviewed them and there is no maintainer.
>
> ----------------------------------------------------------------
>
> Fam Zheng (2):
>   Add a git-publish configuration file
>   README: Document 'git-publish' workflow
>
> Su Hang (3):
>   util/uri.c: Coding style check, Only whitespace involved
>   util/uri.c: remove brackets that wrap `return` statement's content.
>   util/uri.c: wrap single statement blocks with braces {}
>
> Thomas Huth (1):
>   tests/libqos: Check for valid dev pointer when looking for PCI devices
>
>  tests/libqos/virtio-pci.c |    4 +-
>  util/uri.c                | 1733 ++++++++++++++++++++++++---------------------
>  .gitpublish               |   51 ++
>  README                    |   31 +-
>  4 files changed, 1014 insertions(+), 805 deletions(-)
>  create mode 100644 .gitpublish

Applied, thanks.

-- PMM

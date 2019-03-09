Received: from eggs.gnu.org ([209.51.188.92]:47047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2fst-0007Pz-0g
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 12:35:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2fss-00064s-9L
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 12:35:42 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:39023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2fss-00063z-1r
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 12:35:42 -0500
Received: by mail-oi1-x22f.google.com with SMTP id b4so590291oif.6
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 09:35:41 -0800 (PST)
MIME-Version: 1.0
References: <20190308125823.32535-1-kwolf@redhat.com>
In-Reply-To: <20190308125823.32535-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Mar 2019 17:35:29 +0000
Message-ID: <CAFEAcA_bJdG+SD9hDiYG_W0kSv_bK8Q0H+=wyecmxZV6EUyjpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/33] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 8 Mar 2019 at 12:58, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit c4e0780ed1ffd056f205348d387a61b4136a45df:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.0-pull-request' into staging (2019-03-07 18:40:43 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to e88153ea9a40009a8ae7648282c0eac1b7f5494f:
>
>   qcow2 spec: Describe string header extensions (2019-03-08 12:26:46 +0100)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - qcow2: Support for external data files
> - qcow2: Default to 4KB for the qcow2 cache entry size
> - Apply block driver whitelist for -drive format=help
> - Several qemu-iotests improvements
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

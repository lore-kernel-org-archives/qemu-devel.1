Received: from eggs.gnu.org ([209.51.188.92]:39205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h18J4-0005q1-QH
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 06:32:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1892-00062T-N5
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 06:22:06 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:42665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1892-0005wG-5A
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 06:22:00 -0500
Received: by mail-oi1-x22d.google.com with SMTP id s16so6519905oih.9
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 03:21:59 -0800 (PST)
MIME-Version: 1.0
References: <1551769940-22739-1-git-send-email-jasowang@redhat.com>
In-Reply-To: <1551769940-22739-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2019 11:21:47 +0000
Message-ID: <CAFEAcA8Z3V3gZa-ttX9HiHQn1EEN0Y9zi8kP7xwX6q_6NOAj_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL V2 00/13] Net patches
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

On Tue, 5 Mar 2019 at 07:12, Jason Wang <jasowang@redhat.com> wrote:
>
> The following changes since commit b6179aaff961627fcb59d7b234297966b81ac726:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-cocoa-20190304' into staging (2019-03-04 16:50:41 +0000)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 4b9b70000218640a42c3ea908a12665e5840b6cd:
>
>   tests: Add a test for qemu self announcements (2019-03-05 11:27:41 +0800)
>
> ----------------------------------------------------------------
>
> Changes from V1:
> - build fixes for qmp controlled announcing
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

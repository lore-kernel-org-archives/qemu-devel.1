Received: from eggs.gnu.org ([209.51.188.92]:46254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDuVi-0008L1-Gs
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDuVh-0003JW-H8
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:26:14 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:45672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDuVf-0003DJ-H5
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:26:11 -0400
Received: by mail-oi1-x236.google.com with SMTP id y84so14216645oia.12
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 10:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <1554827719-10184-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1554827719-10184-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 18:25:48 +0100
Message-ID: <CAFEAcA8fs_H-gwk251mCq1V2tOBF=Mr96e4FY0aePyCre-D9NA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 0/5] Misc patches for QEMU 5.0-rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, 9 Apr 2019 at 17:36, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 248987f92cfda8305d6d44ced23e173e62a8bc0e:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.0-pull-request' into staging (2019-04-09 10:02:30 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 3e20c81ed87cb15cd04f929b075e244e0758641a:
>
>   tests: Make check-block a phony target (2019-04-09 18:34:21 +0200)
>
> ----------------------------------------------------------------
> * fixes for Alpine and SuSE
> * fix crash when hot-plugging nvdimm on older machine types
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

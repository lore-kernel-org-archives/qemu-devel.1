Received: from eggs.gnu.org ([209.51.188.92]:47157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1vdT-0000sr-G2
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:12:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1vdR-0002Ss-RH
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:12:42 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1vdQ-0002Pm-Ny
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:12:40 -0500
Received: by mail-oi1-x244.google.com with SMTP id w66so13329354oia.4
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 08:12:40 -0800 (PST)
MIME-Version: 1.0
References: <20190307152450.20340-1-peter.maydell@linaro.org>
In-Reply-To: <20190307152450.20340-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2019 16:12:28 +0000
Message-ID: <CAFEAcA-M7vo-rF=njSjdKiA85-2d4y=8B+otTdzDnuX=1h4Cnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/12] sphinx queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 7 Mar 2019 at 15:24, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The only difference from the v3 patchset is that I've
> changed a -d to -e in patch 10 as suggested by RTH.
>
> thanks
> -- PMM
>
> The following changes since commit 32694e98b8d7a246345448a8f707d2e11d6c65e2:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2019-03-06 18:52:19 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-sphinx-20190307
>
> for you to fetch changes up to c10e01b996df09f6cb4eceb2b7a9754bece927c9:
>
>   MAINTAINERS: Add entry for Sphinx documentation infrastructure (2019-03-07 14:26:47 +0000)
>
> ----------------------------------------------------------------
> Enable building and installing rST docs with Sphinx
>
> ---------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

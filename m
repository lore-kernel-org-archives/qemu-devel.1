Received: from eggs.gnu.org ([209.51.188.92]:59285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gs3rl-0000cS-Io
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 05:58:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gs3rj-0004Nn-Cl
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 05:58:41 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:43216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gs3rf-0004IA-1R
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 05:58:37 -0500
Received: by mail-ot1-x32b.google.com with SMTP id a11so5091679otr.10
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 02:58:33 -0800 (PST)
MIME-Version: 1.0
References: <20190207140316.16103-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190207140316.16103-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Feb 2019 10:58:21 +0000
Message-ID: <CAFEAcA-2fL29+5spAbtwR5Nmgki3gsFtVMEX9AevxBz-vv5mTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULLv4 00/32] More work towards libslirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

On Thu, 7 Feb 2019 at 14:03, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> The following changes since commit 713acc316ddca119fe168e72846f1d2dd0548430:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190206' into staging (2019-02-07 11:46:40 +0000)
>
> are available in the Git repository at:
>
>   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to ee261c02332ea856352f250b295a8ecd1eeb748e:
>
>   slirp: API is extern C (2019-02-07 15:49:08 +0200)
>
> ----------------------------------------------------------------
> More work towards libslirp
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

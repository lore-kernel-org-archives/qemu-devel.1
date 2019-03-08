Received: from eggs.gnu.org ([209.51.188.92]:55993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2Es0-0005J4-5j
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:45:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2Erv-0006ee-Cc
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:44:58 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:37663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2Erv-0006CV-0L
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:44:55 -0500
Received: by mail-ot1-x329.google.com with SMTP id b3so17224840otp.4
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 04:44:51 -0800 (PST)
MIME-Version: 1.0
References: <20190307115143.780-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190307115143.780-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2019 12:44:39 +0000
Message-ID: <CAFEAcA-9QPtsktrrNnzA7NZOnKe1dnd45sT0tkg1pg1pV6c8kQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULLv2 00/12] slirp updates
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

On Thu, 7 Mar 2019 at 11:51, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> The following changes since commit 32694e98b8d7a246345448a8f707d2e11d6c65e2:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2019-03-06 18:52:19 +0000)
>
> are available in the Git repository at:
>
>   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to be1911ff7504be95d5cf2c18bc99ce07246a91e5:
>
>   slirp: remove QEMU Makefile.objs (2019-03-07 12:46:31 +0100)
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

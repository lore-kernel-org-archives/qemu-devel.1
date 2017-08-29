Received: from eggs.gnu.org ([2001:4830:134:3::10]:51003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dmchZ-00064P-Vv
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dmchY-00030I-SF
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:20:53 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:33721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dmchY-000309-LW
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:20:52 -0400
Received: by mail-wr0-x22a.google.com with SMTP id k94so8340052wrc.0
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 02:20:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170827230506.12683-1-samuel.thibault@ens-lyon.org>
References: <20170827230506.12683-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2017 10:20:31 +0100
Message-ID: <CAFEAcA8LYZ28FFmb=HLvoBbx=w60OjBAKFogGScxV1bL8bee-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] slirp updates
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

On 28 August 2017 at 00:05, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
> warning: redirection vers https://people.debian.org/~sthibault/qemu.git/
> The following changes since commit 04d74e07b4542aad5aa4ad03951b38b767f5314a:
>
>   slirp: fix clearing ifq_so from pending packets (2017-08-26 01:04:12 +0200)
>
> are available in the git repository at:
>
>   http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to 04d74e07b4542aad5aa4ad03951b38b767f5314a:
>
>   slirp: fix clearing ifq_so from pending packets (2017-08-26 01:04:12 +0200)
>
> ----------------------------------------------------------------
> slirp updates
>
> ----------------------------------------------------------------

Is this pull request intended to be for 2.10 (in which
case it needs justification) or for 2.11 (in which case
it's a bit early) ?

thanks
-- PMM

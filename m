Received: from eggs.gnu.org ([2001:4830:134:3::10]:47477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f0pVq-0003Ad-Iw
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f0pVp-000235-MO
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:23:46 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:46408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f0pVp-00021y-Hn
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:23:45 -0400
Received: by mail-oi0-x232.google.com with SMTP id e123-v6so17120110oih.13
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 07:23:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180326202039.21070-1-mreitz@redhat.com>
References: <20180326202039.21070-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Mar 2018 15:23:24 +0100
Message-ID: <CAFEAcA_zRVbEVPS+idwWSXHUNYQPd1NcdwCTxuHcj=f4JuNcSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] Block patches for 2.12.0-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 26 March 2018 at 21:20, Max Reitz <mreitz@redhat.com> wrote:
> The following changes since commit 7b93d78a04aa242d377ae213b79db6c319c71847:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-03-26 15:17:25 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/XanClic/qemu.git tags/pull-block-2018-03-26
>
> for you to fetch changes up to a77672ea3d95094a0cb4f974de84fb7353c67cc0:
>
>   vmdk: return ERROR when cluster sector is larger than vmdk limitation (2018-03-26 21:17:24 +0200)
>
> ----------------------------------------------------------------
> A fix for dirty bitmap migration through shared storage, and a VMDK
> patch keeping us from creating too large extents.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM

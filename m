Received: from eggs.gnu.org ([2001:4830:134:3::10]:41156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSOd0-0007yP-Vj
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSOd0-00035w-7N
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:21:06 -0400
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:35368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fSOd0-00035i-1c
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:21:06 -0400
Received: by mail-ot0-x236.google.com with SMTP id q17-v6so24228947otg.2
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 08:21:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180611142611.6609-1-mreitz@redhat.com>
References: <20180611142611.6609-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Jun 2018 16:20:45 +0100
Message-ID: <CAFEAcA-fS22p06yPo4xpzU+DnZqYi6bS_tEG28i1p33t=UMwvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/29] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>

On 11 June 2018 at 15:25, Max Reitz <mreitz@redhat.com> wrote:
> The following changes since commit 9f55925b8f50a962d1d08d815044db7767ae3838:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-3.0-pull-request' into staging (2018-06-11 12:46:16 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/XanClic/qemu.git tags/pull-block-2018-06-11
>
> for you to fetch changes up to c50abd175a88cd41c2c08339de91f6f6e4a7b162:
>
>   iotests: Add case for a corrupted inactive image (2018-06-11 16:18:45 +0200)
>
> ----------------------------------------------------------------
> Block patches:
> - Various bug fixes
> - Removal of qemu-img convert's deprecated -s option
> - qemu-io now exits with an error when a command failed
>

Applied, thanks.

-- PMM

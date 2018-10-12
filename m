Received: from eggs.gnu.org ([2001:4830:134:3::10]:34295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAvng-0008Dn-SR
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:40:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAvnf-0005dg-8n
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:40:12 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gAvne-0005Yq-OS
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:40:11 -0400
Received: by mail-ot1-x341.google.com with SMTP id v2so4920282otk.1
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 04:40:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181012015026.17441-1-famz@redhat.com>
References: <20181012015026.17441-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Oct 2018 12:39:48 +0100
Message-ID: <CAFEAcA8j8tPD1L9CLh3P1HXnXx=o34bJbr+S1RGjRyrkUpwfEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 12 October 2018 at 02:50, Fam Zheng <famz@redhat.com> wrote:
> The following changes since commit 75e50c80e051423a6f55a34ee4a1eec842444a=
5b:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2018-10-10'=
 into staging (2018-10-11 10:43:37 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/famz/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 6388147296cd4c841a7d4409ba622c200332a8c7:
>
>   nvme: correct locking around completion (2018-10-12 09:46:14 +0800)
>
> ----------------------------------------------------------------
> Block patches
>
> One fix from Marc-Andr=C3=A9 for iothread.
> One fix from Paolo on nvme:// driver.
>
> ----------------------------------------------------------------
>
> Marc-Andr=C3=A9 Lureau (1):
>   iothread: fix crash with invalid properties
>
> Paolo Bonzini (1):
>   nvme: correct locking around completion
>
>  block/nvme.c | 2 --
>  iothread.c   | 9 ++++++---
>  2 files changed, 6 insertions(+), 5 deletions(-)

Applied, thanks.

-- PMM

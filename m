Received: from eggs.gnu.org ([209.51.188.92]:50827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gj68Z-0008Ju-Sg
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 12:35:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gj68X-0001mO-JS
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 12:34:58 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:43983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gj68X-0001lx-20
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 12:34:57 -0500
Received: by mail-oi1-x230.google.com with SMTP id u18so18546305oie.10
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 09:34:57 -0800 (PST)
MIME-Version: 1.0
References: <20190114135154.16826-1-anthony.perard@citrix.com>
In-Reply-To: <20190114135154.16826-1-anthony.perard@citrix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Jan 2019 17:34:45 +0000
Message-ID: <CAFEAcA8_h=ab5Fuhz49YZf3-DVHyYogC8uz9C7q-fx4Z=VKELg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/25] Xen queue v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>

On Mon, 14 Jan 2019 at 13:52, Anthony PERARD <anthony.perard@citrix.com> wrote:
>
> The following changes since commit 7260438b7056469610ee166f7abe9ff8a26b8b16:
>
>   Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-3.2-part2' into staging (2019-01-14 11:41:43 +0000)
>
> are available in the Git repository at:
>
>   https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20190114
>
> for you to fetch changes up to c6025bd197d0dbcc5067553fd12538d8b29383c2:
>
>   xen-block: avoid repeated memory allocation (2019-01-14 13:45:40 +0000)
>
> ----------------------------------------------------------------
> Xen queue
>
> * Xen PV backend 'qdevification'.
>   Starting with xen_disk.
> * Performance improvements for xen-block.
> * Remove of the Xen PV domain builder.
> * bug fixes.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

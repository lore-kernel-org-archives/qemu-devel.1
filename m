Received: from eggs.gnu.org ([209.51.188.92]:57187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBLrt-0004lj-H1
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBLrs-0006e7-As
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:02:33 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:43119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hBLrr-0006bk-RI
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:02:32 -0400
Received: by mail-oi1-x232.google.com with SMTP id t81so10896616oig.10
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 09:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190402150803.23863-1-armbru@redhat.com>
In-Reply-To: <20190402150803.23863-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2019 23:02:19 +0700
Message-ID: <CAFEAcA_jhgk1qX4y3wa1yjmfJnwDXbAXkwfq92VBTyK6FbROOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/8] Miscellaneous patches for 2019-04-02
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, 2 Apr 2019 at 22:10, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit d61d1a1fb2f1db6c54651844a28389c523f3f8c7:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20190402-pull-request' into staging (2019-04-02 08:18:24 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-misc-2019-04-02
>
> for you to fetch changes up to 79b9d4bde7db3f760851217b329c68a883184c6b:
>
>   accel: Unbreak accelerator fallback (2019-04-02 13:50:09 +0200)
>
> ----------------------------------------------------------------
> Miscellaneous patches for 2019-04-02
>
> Two regression fixes for 4.0:
>
> * Unbreak migration for Xen
> * Unbreak accelerator fallback
>
> Three safe bug fixes thrown in:
>
> * Fix error location of qemu-system-FOO positional arguments
> * COLOStatus minor doc fix
> * COLOStatus member rename to conform to naming rules
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

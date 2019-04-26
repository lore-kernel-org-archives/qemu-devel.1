Received: from eggs.gnu.org ([209.51.188.92]:53723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hK2vP-0007SZ-0b
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 11:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hK2vN-0006Cf-1K
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 11:38:06 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:37727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hK2vL-00064Z-9D
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 11:38:04 -0400
Received: by mail-ot1-x32c.google.com with SMTP id r20so1873964otg.4
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 08:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190425175659.24876-1-ehabkost@redhat.com>
In-Reply-To: <20190425175659.24876-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Apr 2019 16:37:35 +0100
Message-ID: <CAFEAcA-9NBHWb9GCsYAHZ6HMw0NTRi3Ms-2171QO1Wnig8256w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/11] Machine queue, 2019-04-25
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On Thu, 25 Apr 2019 at 18:57, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 3284aa128153750f14a61e8a96fd085e6f2999b6:
>
>   Merge remote-tracking branch 'remotes/lersek/tags/edk2-pull-2019-04-22' into staging (2019-04-24 13:19:41 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to 119906afa5ca610adb87c55ab0d8e53c9104bfc3:
>
>   util/mmap-alloc: support MAP_SYNC in qemu_ram_mmap() (2019-04-25 14:17:36 -0300)
>
> ----------------------------------------------------------------
> Machine queue, 2019-04-25
>
> * 4.1 machine-types (Cornelia Huck)
> * Support MAP_SYNC on pmem memory backends (Zhang Yi)
> * -cpu parsing fixes and cleanups (Eduardo Habkost)
> * machine initialization cleanups (Wei Yang, Markus Armbruster)
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

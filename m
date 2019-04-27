Received: from eggs.gnu.org ([209.51.188.92]:48729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hKUBv-0004Sf-66
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 16:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hKU1r-0004IC-Ak
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 16:34:36 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:42588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hKU1r-0004Fk-4z
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 16:34:35 -0400
Received: by mail-ot1-x32e.google.com with SMTP id f23so5513560otl.9
	for <qemu-devel@nongnu.org>; Sat, 27 Apr 2019 13:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190425181342.15360-1-ehabkost@redhat.com>
In-Reply-To: <20190425181342.15360-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 27 Apr 2019 21:34:21 +0100
Message-ID: <CAFEAcA9w6LJhGvQR5QWLF3c0d8i=ydcauPV2yZc2wpFNNJrB2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] x86 queue, 2019-04-25
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>

On Thu, 25 Apr 2019 at 19:13, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 3284aa128153750f14a61e8a96fd085e6f2999b6:
>
>   Merge remote-tracking branch 'remotes/lersek/tags/edk2-pull-2019-04-22' into staging (2019-04-24 13:19:41 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-next-pull-request
>
> for you to fetch changes up to a4e0b436f44a4bb47ed4a75b0c05d2547cf12b1c:
>
>   Pass through cache information for TOPOEXT CPUs (2019-04-25 14:52:28 -0300)
>
> ----------------------------------------------------------------
> x86 queue, 2019-04-25
>
> * Hygon Dhyana CPU model (Pu Wen)
> * Categorize a few devices in hw/i386 (Ernest Esene)
> * Support host-cache-info on TOPOEXT CPUID leaf (Stanislav Lanci)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

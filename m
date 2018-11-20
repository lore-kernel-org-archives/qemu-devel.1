Received: from eggs.gnu.org ([2001:4830:134:3::10]:44520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP7Fl-0002b6-3H
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:43:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP7Fk-0006ww-Bw
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:43:49 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:42539)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP7Fk-0006wi-7P
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:43:48 -0500
Received: by mail-oi1-x235.google.com with SMTP id w13so1650700oiw.9
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 06:43:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181120134908.8439-1-ehabkost@redhat.com>
References: <20181120134908.8439-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 14:43:27 +0000
Message-ID: <CAFEAcA84zSLMi=0ZSiVTquFLZ1fMtsOT6JF+SuKoUKwNh80ysQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] [for -rc2] pc-*-3.1 machine-types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, Richard Henderson <rth@twiddle.net>

On 20 November 2018 at 13:49, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Hopefully in time for -rc2.
>
> commit 9b4cf107 ("hyperv: only add SynIC in compatible configurations") breaks
> compatibility on pc-*-3.0, so this is required as a bug fix.
>
> The following changes since commit 46cabfb41e9cb269affc14c8188f0c8745f8cd55:
>
>   Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging (2018-11-20 12:24:09 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-for-3.1-pull-request
>
> for you to fetch changes up to 4a93722f9c279184e95b1e1ad775c01deec05065:
>
>   hw/i386: add pc-i440fx-3.1 & pc-q35-3.1 (2018-11-20 11:42:32 -0200)
>
> ----------------------------------------------------------------
> pc-*-3.1 machine-types
>
> ----------------------
Applied, thanks.

-- PMM

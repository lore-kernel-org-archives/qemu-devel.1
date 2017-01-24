Received: from eggs.gnu.org ([2001:4830:134:3::10]:33343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW4Pq-0006cM-CM
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:57:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW4Pp-0008GU-OB
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:57:54 -0500
Received: from mail-vk0-x235.google.com ([2607:f8b0:400c:c05::235]:33039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cW4Pp-0008GH-K5
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:57:53 -0500
Received: by mail-vk0-x235.google.com with SMTP id k127so115792520vke.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 08:57:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170123232738.20796-1-ehabkost@redhat.com>
References: <20170123232738.20796-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 16:57:32 +0000
Message-ID: <CAFEAcA8ULdNumtUQuuoOyKY4wH9QO-FyZjqoagouVMeu8aFc1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/13] x86, machine, numa queue (2017-01-23)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 23 January 2017 at 23:27, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit 3879284d6517dc22529395bdb259f4183b589127:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/pull-qio-2017-01-23-2' into staging (2017-01-23 15:59:09 +0000)
>
> are available in the git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-and-machine-pull-request
>
> for you to fetch changes up to d99569d9d8562c480e0befab601756b0b7b5d0e0:
>
>   kvm: Allow invtsc migration if tsc-khz is set explicitly (2017-01-23 21:26:27 -0200)
>
> ----------------------------------------------------------------
> x86, machine, numa queue (2017-01-23)
>
> ----------------------------------------------------------------

Applied, thanks (since we've tracked down the makeinfo issue).

-- PMM

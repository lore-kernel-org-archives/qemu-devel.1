Received: from eggs.gnu.org ([2001:4830:134:3::10]:36942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyHhy-00042J-TY
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 09:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyHhy-0003OQ-2V
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 09:53:46 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:34430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyHhx-0003Nz-Tp
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 09:53:46 -0400
Received: by mail-oi0-x22b.google.com with SMTP id u141-v6so1376769oif.1
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 06:53:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180319201255.9317-1-ehabkost@redhat.com>
References: <20180319201255.9317-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Mar 2018 13:53:24 +0000
Message-ID: <CAFEAcA-c-KGT3+aBWXh6yOJnLeUJR9jX_j1uLaozB4XTHvhcbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 0/7] Machine and x86 queue, 2018-03-19
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 19 March 2018 at 20:12, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Changes v2 (2018-03-15) -> v3 (2018-03-19):
> * Fix bogus warnings on machine-none-test
> * Included Intel PT CPUID fix
>
> Changes v1 (2018-03-12) -> v2 (2018-03-15):
> * Fix bsd-user build error
>
> The following changes since commit 2c8cfc0b52b5a4d123c26c0b5fdf941be24805be:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2018-03-19 11:44:26 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to c078ca968c6c7cb62781c1843d840cb0f5c72781:
>
>   i386: Disable Intel PT if packets IP payloads have LIP values (2018-03-19 17:05:57 -0300)
>
> ----------------------------------------------------------------
> Machine and x86 queue, 2018-03-19
>
> * cpu_model/cpu_type cleanups
> * x86: Fix on Intel Processor Trace CPUID checks
>

Applied, thanks.

-- PMM

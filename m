Received: from eggs.gnu.org ([2001:4830:134:3::10]:54392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRbQu-0000xK-6q
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:21:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRbQs-0006PD-FH
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:21:36 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:37478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gRbQq-0006L9-Hq
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:21:34 -0500
Received: by mail-ot1-x32f.google.com with SMTP id 40so19742650oth.4
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 03:21:30 -0800 (PST)
MIME-Version: 1.0
References: <20181126205941.19021-1-ehabkost@redhat.com>
In-Reply-To: <20181126205941.19021-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Nov 2018 11:21:18 +0000
Message-ID: <CAFEAcA_Swkik_WX0_qHgN0LnjZJNwb7KbGd=S0oMziT2tjWR5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] x86 fixes for -rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm-devel <kvm@vger.kernel.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>

On Mon, 26 Nov 2018 at 20:59, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit d522fba24478474911b0e6e488b6d1dcf1af54f8:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20181126' into staging (2018-11-26 13:58:46 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-for-3.1-pull-request
>
> for you to fetch changes up to 30a759b61a9247378a9cb84fbe4e437ae66e0461:
>
>   hw/hyperv: fix NULL dereference with pure-kvm SynIC (2018-11-26 14:14:38 -0200)
>
> ----------------------------------------------------------------
> x86 fixes for -rc3
>
> * Fix SynIC crash
> * Fix x86 crash on MSR code on AMD hosts
>
> ----------------------------------------------------------------


Applied, thanks.

-- PMM

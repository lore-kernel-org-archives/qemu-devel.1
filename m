Received: from eggs.gnu.org ([2001:4830:134:3::10]:52021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faGzv-00074o-2j
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:49:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faGzu-000533-9W
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:49:19 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:40951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1faGzu-00052m-3O
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:49:18 -0400
Received: by mail-oi0-x233.google.com with SMTP id w126-v6so2241384oie.7
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 01:49:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1530546340-4366-1-git-send-email-pbonzini@redhat.com>
References: <1530546340-4366-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Jul 2018 09:48:56 +0100
Message-ID: <CAFEAcA93OQURX2FbJtO36ata2X8NPzwVBaB-Y0uc7teHvDQaRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/50] More misc patches for 3.0 soft
 freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 July 2018 at 16:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 646f34fa5482e495483de230b4cf0f2ae4fd2781:
>
>   tcg: Fix --disable-tcg build breakage (2018-07-02 13:42:05 +0100)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to c40d479207b1bb6569ffde06e9a58e85cd529de0:
>
>   tcg: simplify !CONFIG_TCG handling of tb_invalidate_* (2018-07-02 15:41:18 +0200)
>
> ----------------------------------------------------------------
> * IEC units series (Philippe)
> * Hyper-V PV TLB flush (Vitaly)
> * git archive detection (Daniel)
> * host serial passthrough fix (David)
> * NPT support for SVM emulation (Jan)
> * x86 "info mem" and "info tlb" fix (Doug)
>

Applied, thanks.

-- PMM

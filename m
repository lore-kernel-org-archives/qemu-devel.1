Received: from eggs.gnu.org ([2001:4830:134:3::10]:43794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evlo0-0007V2-SG
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evlo0-0000qr-3d
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:25:36 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:41901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evlnz-0000qS-UH
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:25:36 -0400
Received: by mail-ot0-x22d.google.com with SMTP id w38so19341328ota.8
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 08:25:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180312200022.9760-1-ehabkost@redhat.com>
References: <20180312200022.9760-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Mar 2018 15:25:14 +0000
Message-ID: <CAFEAcA__NUw+u8HLgcqU4GBvrBksV3JyD5kY5CnPbqhq=XZxXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] x86 queue, 2018-03-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>

On 12 March 2018 at 20:00, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit b16a54da0696efc5d91b6c3597a37a317abb5de7:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180312-pull-request' into staging (2018-03-12 14:06:23 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-next-pull-request
>
> for you to fetch changes up to b77146e9a129bcdb60edc23639211679ae846a92:
>
>   i386: Add support to get/set/migrate Intel Processor Trace feature (2018-03-12 15:59:46 -0300)
>
> ----------------------------------------------------------------
> x86 queue, 2018-03-12
>
> * Intel Processor Trace support
> * KVM_HINTS_DEDICATED
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM

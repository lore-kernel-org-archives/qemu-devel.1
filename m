Received: from eggs.gnu.org ([2001:4830:134:3::10]:58517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNbfE-0001M0-Ak
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNbfD-0005U4-6v
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:15:36 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:39728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fNbfD-0005Tn-2B
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:15:35 -0400
Received: by mail-ot0-x244.google.com with SMTP id l12-v6so16315222oth.6
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 03:15:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180526025520.3298441-1-stefanb@linux.vnet.ibm.com>
References: <20180526025520.3298441-1-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 May 2018 11:15:13 +0100
Message-ID: <CAFEAcA_dNpPhK9QuaeqyvmPcKpbEAwgoWHYKnMXkznMQFb+POg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v4 0/4] Merge tpm 2018/05/23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 26 May 2018 at 03:55, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> This series of patches adds TPM emulator state migration support and a
> test case for testing (local) migration.
>
>    Stefan
>
> The following changes since commit 4f50c1673a89b07f376ce5c42d22d79a79cd466d:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-05-22 09:43:58 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-05-23-4
>
> for you to fetch changes up to b21373d0713d060e42dcec8262197a91b71dfd4b:
>
>   test: Add test cases that use the external swtpm with CRB interface (2018-05-25 22:47:27 -0400)
>
> ----------------------------------------------------------------
> Merge tpm 2018/05/23 v4
>
> ----------------------------------------------------------------
> Stefan Berger (4):
>       tpm: extend TPM emulator with state migration support
>       tpm: extend TPM TIS with state migration support
>       docs: tpm: add VM save/restore example and troubleshooting guide
>       test: Add test cases that use the external swtpm with CRB interface

Applied, thanks.

-- PMM
